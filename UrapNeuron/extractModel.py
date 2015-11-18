import neuron as nrn
import ctypes
import sys

from cStringIO import StringIO
from nrn_structs import *


def nrn_dll(printpath=False):
    """Return a ctypes object corresponding to the NEURON library.
    
    .. warning::
    
        This provides access to the C-language internals of NEURON and should
        be used with care.
    """
    import ctypes
    import os
    import platform
    
    neuron_home = os.path.split(os.path.split(nrn.h.neuronhome())[0])[0]

    success = False
    base_path = os.path.join(neuron_home, 'lib' , 'python2.7', 'site-packages', 'neuron', 'hoc')
    for extension in ['', '.dll', '.so', '.dylib']:
        try:
            the_dll = ctypes.cdll[base_path + extension]
            if printpath : print base_path + extension
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


USE_CTYPES = True
modelFile = "./runModel.hoc"
nrn.h.load_file(1, modelFile)
if USE_CTYPES:
    nrn_nthread = nrn_dll_sym('nrn_threads', ctypes.c_void_p)
    thread = ctypes.cast(nrn_nthread, ctypes.POINTER(NrnThread))
    #FN_TopoList
    for i in range(thread.contents.end):
        print i, thread.contents._v_parent_index[i] 

else:
    for s in nrn.h.allsec():
        # FN_Topo 
        name = nrn.h.secname()
        topology =  [s.nseg, s.L, s.diam, s.Ra, s.cm, nrn.h.dt, nrn.h.st.delay, nrn.h.st.dur, nrn.h.st.amp, nrn.h.tfinal, s.v, nrn.h.area(.5), nrn.h.parent_connection(), nrn.h.n3d()]

    # FN_RecSites
    for s in nrn.h.recSites:
        print s.name()
    #topolist = nrn.h.MyTopology()
    
