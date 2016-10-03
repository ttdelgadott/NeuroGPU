import neuron as nrn
import ctypes
import sys

from cStringIO import StringIO
from nrn_structs import *


### Helper functions for loading NEURON C library ###

def nrn_dll(printpath=False):
    """Return a ctypes object corresponding to the NEURON library.
    """
    import ctypes
    import os
    import platform

    # neuron_home = os.path.split(os.path.split(nrn.h.neuronhome())[0])[0]

    success = False
    # base_path = os.path.join(neuron_home, 'lib' , 'python2.7', 'site-packages', 'neuron', 'hoc')
    # base_path = '/home/devloop0/neuron/nrn/lib/python/neuron/hoc'
    base_path = os.path.join(os.path.expanduser('~'), 'neuron', 'nrn', 'lib', 'python', 'neuron', 'hoc')
    for extension in ['', '.dll', '.so', '.dylib']:
        try:
            the_dll = ctypes.cdll[base_path + extension]
            if printpath: print base_path + extension
            success = True
        except:
            pass
        if success: break
    else:
        raise Exception('unable to connect to the NEURON library')
    return the_dll

def nrn_dll_sym(name, type=None):
    """return the specified object from the NEURON dlls.
    
    Parameters
    ----------
    name : string
        the name of the object (function, integer, etc...)
    type : None or ctypes type (e.g. ctypes.c_int)
        the type of the object (if None, assumes function pointer)
    """
    import os
    dll = nrn_dll()
    if type is None:
        return dll.__getattr__(name)
    else:
        return type.in_dll(dll, name)

### Model extraction functions ###

def get_topo_list(thread):
    for i in range(thread.contents.end):
        print i, thread.contents._v_parent_index[i]

def get_topo_f_matrix(thread):
    lst = []
    alla = []
    allb = []
    alld = []
    for i in range(thread.contents.end):
        node = thread.contents._v_node[i]
        _a = thread.contents._actual_a[node.contents.v_node_index]
        _b = thread.contents._actual_b[node.contents.v_node_index]

        try:
            _rhs = node.contents._rhs[0]
            lst.append([ i, _b, _a, node.contents._d[0], _rhs ])
            alla.append(_a)
            allb.append(_b)
            alld.append( node.contents._d[0])
        except ValueError:
            _rhs = 0.0
            lst.append([ i, _b, _a, node.contents._d[0], _rhs ])
    return [lst,alla,allb,alld]

def get_rhs(thread):
    print 'start printing rhs'
    ans=[]
    for i in range(thread.contents.end):
        node = thread.contents._v_node[i]
        try:
            _rhs = node.contents._rhs[0]
            ans.append(_rhs)
        except ValueError:
            print 'error in extracting rhs'
            _rhs=-1
    return ans

def get_d(thread):
    ans=[]
    for i in range(thread.contents.end):
        node = thread.contents._v_node[i]
        try:
            _d = node.contents._d[0]
            ans.append(_d)
        except ValueError:
            print 'error in extracting rhs'
            _d=-1
    return ans

def run_matrix(thread):
    allrhs = []
    alld = []
    nrn.h('st = new IClamp(0.5)')
    nrn.h('st.del=0')
    nrn.h('st.dur=1e9')
    nrn.h('counter=0')
    nrn.h('transvec = pmat.getrow(sim)')
    nrn.h('tfunc()')
    nrn.h('finitialize(v_init)')
    nrows = nrn.h('stims.nrow')
    nt = nrn.h('stimtime.ncol')

    for j in range(200):
        print(nrn.h('t'))
        nrn.h('st.amp = 1*stims.x(0,' + str(j) + ')')
        nrn.h('fcurrent()')
        allrhs.append(get_rhs(thread))
        alld.append(get_d(thread))
        nrn.h('fadvance()')

        allrhs.append(get_rhs(thread))
        alld.append(get_d(thread))
    return [allrhs,alld]
def print_debug(list,fn):
    f = open(fn, 'w')
    for i in range(len(list)):
        lines = list[i]
        lines = [str(s)+',' for s in lines]
        f.write(''.join(lines) + '\n')
    f.close()
def get_topo():
    sections = {}
    for s in nrn.h.allsec():
        name = nrn.h.secname()
        topology =  [s.nseg, s.L, s.diam, s.Ra, s.cm, nrn.h.dt, nrn.h.st.delay, nrn.h.st.dur, nrn.h.st.amp, nrn.h.tfinal, s.v, nrn.h.area(.5), nrn.h.parent_connection(), nrn.h.n3d()]
        sections[name] = topology
    return sections

def get_topo_mdl():
    # TODO: Currently prints out DEFAULT values. Check if this is expected behavior.
    sections = {}
    for s in nrn.h.allsec():
        mech_params = {}
        name = nrn.h.secname()
        if nrn.h.ismembrane("pas"):
            mech_params['g_pas'] = s.g_pas
            mech_params['e_pas'] = s.e_pas
        mech_names = get_mech_list()
        for mech_name in mech_names:
            if not nrn.h.ismembrane(mech_name):
                continue
            ms = nrn.h.MechanismStandard(mech_name, -1) # contains mechanism parameter names
            for j in range(int(ms.count())):
                param = nrn.h.ref('')                   # string reference to store parameter name
                ms.name(param, j)
                nrn.h('x = {0}'.format(param[0]))
                mech_params[param[0]] = nrn.h.x
        sections[name] = mech_params
    return sections

def get_recsites():
    sites = []
    for s in nrn.h.recSites:
        sites.append(s.name())
    return sites

### Helpers ###

def get_mech_list():
    mech_names = []
    mechlist = nrn.h.MechanismType(0)       # object that contains all mechanism names
    for i in range(int(mechlist.count())):
        s = nrn.h.ref('')                   # string reference to store mechanism name
        mechlist.select(i)
        mechlist.selected(s)
        mech_names.append(s[0])
    return mech_names


def main():
    modelFile = "./runModel.hoc"
    nrn.h.load_file(1, modelFile)
    thread = nrn_dll_sym('nrn_threads', ctypes.POINTER(NrnThread))

    get_topo_list(thread)
    output = get_topo_f_matrix(thread)
    tmp = output[0]
    alla = output[1]
    allb= output[2]
    alld1 = output[3]
    #print(tmp)
    topo = get_topo()           # dictionary whose keys are section names
    topo_mdl = get_topo_mdl()   # dictionary whose keys are section names
    recsites = get_recsites()   # list of section names
    output = run_matrix(thread)
    allrhs = output[0]
    alld = output[1]
    print_debug(allrhs,'allrhs.csv')
    print_debug(alld,'alld.csv')
    print 'printed rhs'
    print 'alla'
    print alla
    print 'allb'
    print allb
    print alld1

if __name__ == '__main__':
    main()
