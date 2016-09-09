import neuron as nrn
import ctypes
import sys
import collections
import glob
import re

from cStringIO import StringIO
from nrn_structs import *

# Definitions
ModData = collections.namedtuple('ModData', 'mod_per_seg,available_mechs')
ParsedModel = collections.namedtuple('ParsedModel', 'Writes,Reads')
ModNeuron = collections.namedtuple('ModNeuron', 'Suffix,UseIon,NonspecificCurrent,Reads,Writes,Range,Global')
FTYPESTR = 'float'
end_str = '|X|X|'
# Globals
ParamStartVal = 0
StateStartVal = 0
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
    for i in range(thread.contents.end):
        node = thread.contents._v_node[i]
        _a = thread.contents._actual_a[node.contents.v_node_index]
        _b = thread.contents._actual_b[node.contents.v_node_index]

        try:
            _rhs = node.contents._rhs[0]
            lst.append([i, _b, _a, node.contents._d[0], _rhs])
        except ValueError:
            _rhs = 0.0
            lst.append([i, _b, _a, node.contents._d[0], _rhs])
    return lst


def get_topo():
    sections = {}
    for s in nrn.h.allsec():
        name = nrn.h.secname()
        topology = [s.nseg, s.L, s.diam, s.Ra, s.cm, nrn.h.dt, nrn.h.st.delay, nrn.h.st.dur, nrn.h.st.amp, nrn.h.tfinal,
                    s.v, nrn.h.area(.5), nrn.h.parent_connection(), nrn.h.n3d()]
        sections[name] = topology
    return sections


def get_topo_mdl():
    # TODO: Currently prints out DEFAULT values. Check if this is expected behavior.
    available_mechs = set([])
    sections = {}
    exclude_str = "_ion"
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
            ms = nrn.h.MechanismStandard(mech_name, -1)  # contains mechanism parameter names
            tmpind = mech_name.find(exclude_str)
            if ms.count() > 0 and tmpind == -1:
                available_mechs.add(mech_name)

            for j in range(int(ms.count())):
                param = nrn.h.ref('')  # string reference to store parameter name
                ms.name(param, j)
                nrn.h('x = {0}'.format(param[0]))
                mech_params[param[0]] = nrn.h.x
        sections[name] = mech_params
        output = ModData(mod_per_seg=sections, available_mechs=available_mechs)
    return output


def get_recsites():
    sites = []
    for s in nrn.h.recSites:
        sites.append(s.name())
    return sites


### Functions for Parsing Mod/C files ###


def parse_models():
    modout = []

    mod_files = list(glob.glob('*.mod'))
    mod_files.remove('branching.mod')
    for  i in range(len(mod_files)):
        mod_f = mod_files[i]
       # print 'parsing ' + mod_f + 'i is ' + repr(i)
        modout.append(parse_model(mod_f))
    return modout



def parse_model(FN):
    print 'parsing ' +FN
    writes = []
    reads = []
    lines = file_to_list_no_comments(FN)
    #output = get_mech_writes_reads(lines) # we might not need this.
    output = handleNeuronBlock(lines)
    assigned = handleAssignedBlock(lines)
    states = handleStateBlock(lines)
    output = handleParamsBlock(lines,output.Global)
    all_param_line_declare = output[3]
    functions = handleModFunction(lines)
    procedure = hadnleModProcedures(lines,all_param_line_declare,output.Global)
    return output

def get_mech_writes_reads(lines):
    writes = []
    reads = []
    ion_ind = index_containing_substring(lines,'USEION')
    if ion_ind != -1:
        Tmp = re.findall('.*WRITE(.*)',lines[ion_ind])
        Tmp = Tmp[0].strip(' ')
        writes  = Tmp.split(',')
        Tmp = re.findall('READ(.*)WRITE.*', lines[ion_ind])
        Tmp = Tmp[0].strip(' ')
        reads = Tmp.split(',')

    output = ParsedModel(Writes=writes, Reads=reads)

    return output

def handleNeuronBlock(lines):
    writes = ''
    reads = ''
    NSC = ''
    Useion = ''
    Range = ''
    currglobal = ''
    start = index_containing_substring(lines,'NEURON')
    end = index_containing_substring(lines[start:],'}')
    neuron_lines = lines[start+1:(start+end)]
    for currline in neuron_lines:
        [first,rest] = currline.split(' ',1)
        #print "first is" + first + "rest is "+ rest
        if first.find('SUFFIX')>0:
            Suffix=rest.strip(' ')
        elif first.find('USEION')>0:


            [ion_name,rest] = rest.split(' ',1)
            Useion = ion_name
            Tmp = re.findall('.*WRITE(.*)', rest)
            if Tmp:
                writes = Tmp[0].split(',')
                writes = [x.strip(' ') for x in writes]
            else:
                writes=[]
                Writes = writes
            Tmp = re.findall('READ(.*)WRITE.*', rest)
            if Tmp:
                reads = Tmp[0].split(',')
                reads = [x.strip(' ') for x in reads]
            else:
                reads = []
        elif first.find('NONSPECIFIC_CURRENT') > 0:

            NSC = rest.strip(' ')
            Writes = ['i']
            Reads = []
            Useion = ''
        elif first.find('RANGE') > 0:

            Tmp=rest.split(',')
            currrange = [x.strip(' ') for x in Tmp]
            Range = currrange
            #print currrange
        elif first.find('GLOBAL') > 0:

            Tmp = rest.split(',')
            currglobal = [x.strip(' ') for x in Tmp]

            #print currglobal
        else:
            print 'unknown' + currline

    output = ModNeuron(Suffix, Useion, NSC, reads,writes,Range, currglobal)
    return output

def handleAssignedBlock(lines):
    start = index_containing_substring(lines,'ASSIGNED')

    end = index_containing_substring(lines[start:],'}')
    assigned_lines = lines[start+1:(start+end)]
    all_assigned = []
    for line in assigned_lines:
            line = re.sub(r'\([^)]*\)', '', line)
            tmp = line.split(' \t')
            for s in tmp:
                s = re.sub('\s+', '', s)
                if len(s)>0:
                    all_assigned.append(s)
    return all_assigned

def handleStateBlock(lines):
    states=[]
    all_state_line = str(0)
    all_state_line_seg = ''
    start = index_containing_substring(lines,'STATE')
    if start==-1:
        return states
    end = index_containing_substring(lines[start:],'}')
    if end == 0:
        states_line = lines[start:(start+end+1)][0]
        all_states = re.search('\{(.*?)\}',states_line).group(1)
        all_states = all_states.strip(' ')
        states = all_states.split(' ')
        states = [x.strip(' ') for x in states]
    else:
        states_line = lines[(start+1):(start + end )]
        states_line = [re.sub(r'\([^)]*\)', '', line) for line in states_line]
        states_line = [line.strip(' \t') for line in states_line]
        states_line = [line.split(' ')[0] for line in states_line]
        states = [x.strip(' ') for x in states_line]
    if len(states)>0:
        all_state_line = ['float &' + s + ',' for s in states]
        all_state_line = ''.join(all_state_line)
        all_state_line = all_state_line[:-1]
        all_state_line_seg =''
        for x in xrange(0, len(states)):
            all_state_line_seg = all_state_line_seg +'StatesM[' + str(x +StateStartVal) + '][seg] ,'
        all_state_line_seg = all_state_line_seg[:-1]
    #print all_state_line
    #print all_state_line_seg

def handleParamsBlock(lines,globals):
    params = []
    new_params_lines = []
    new_params_lines_with_values = []
    all_params_line = str(0)
    all_params_line_seg = []
    c_param_lines = []
    all_param_line_declare = ''
    all_param_line_call = []
    start = index_containing_substring(lines, 'PARAMETER')
    if start == -1:
        return params
    end = index_containing_substring(lines[start:], '}')
    if end == 0:
        params_line = lines[start:(start + end + 1)][0]
        all_params = re.search('\{(.*?)\}', params_line).group(1)
        all_params = all_params.strip(' ')
        params = all_params.split(' ')
        params = [x.strip(' ') for x in params]
    else:
        params_line = lines[(start + 1):(start + end)]

        params_line = [re.sub(r'\([^)]*\)|<[^)]*\>', '', line) for line in params_line]
        indices = [i for i, x in enumerate(params_line) if re.search('.*=.*', x)]
        for i in indices:
            params_line[i] = params_line[i].strip(' \t')
            new_params_lines.append(params_line[i].split('=', 1)[0])
            new_params_lines_with_values.append(params_line[i])
        new_params_lines = [line.split(' ')[0] for line in new_params_lines]
        params = [x.strip(' ') for x in new_params_lines]
        global_inds =[]
        not_global_inds = []

        for i in range(len(params)):
            if params[i] in globals:
                global_inds.append(i)
                c_param_lines.append(FTYPESTR + ' ' + new_params_lines_with_values[i])
            else:
                not_global_inds.append(i)

        c_globals_not_predefined = list(set(globals)-set(params))
        for e in c_globals_not_predefined:
            c_param_lines.append(FTYPESTR + ' ' + e)
        all_params = params + c_globals_not_predefined

        if params:
            all_params_line = ['float ' + params[i] + ',' for i in not_global_inds]
            all_params_line = ''.join(all_params_line)[:-1]
            for x in xrange(0, len(params)):
                all_params_line_seg.append('ParamsM[' + str(x + ParamStartVal) + '][comp],')
            all_params_line_seg = ''.join(all_params_line_seg)[:-1]
            all_param_line_declare = ','+all_params_line
            all_params_line_call = [params[i] + ',' for i in not_global_inds]
            all_params_line_call = ''.join(all_params_line_call)[:-1]
    return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_param_line_call]

def handleModFunction(lines):
    func_names = []
    func_names_cu = []
    c_func_lines =[]
    c_func_lines_cu = []
    indices = [i for i, x in enumerate(lines) if "FUNCTION" in x]
    for start in indices:
        sumP =lines[start].count('{') - lines[start].count('}')
        currInd = start+1
        while(sumP>0):
            sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
            currInd += 1
        end = currInd
        output = parseModFunction(lines[start:end])
        func_names.append(output[0])
        func_names_cu.append('Cu' + output[0])
        c_func_lines.append(output[1])
        c_func_lines_cu.append('__device__ ' + re.sub(output[0],'Cu' + output[0],output[1][0]))
    print c_func_lines_cu

def parseModFunction(lines):
    p_ind = lines[0].find('(')
    func_name = lines[0][9:p_ind]
    input_vars =  re.search('\((.*?)\)', lines[0]).group(1)
    input_vars = input_vars.split(',')
    input_vars =['float ' + s + ',' for s in input_vars]
    input_vars = ''.join(input_vars)
    input_vars = input_vars[:-1]
    c_func_lines = [FTYPESTR + ' ' + func_name + '(' + input_vars +'){']
    for line in lines[1:]:
        c_func_lines.append(re.sub(func_name + '\W*=', 'return ', line.strip(' \t')))
    #print c_func_lines
    return [func_name,c_func_lines]

def hadnleModProcedures(lines,all_param_line_declare,globals,all_param_line_call):
    indices = [i for i, x in enumerate(lines) if "PROCEDURE" in x]
    out_vars_c = []
    func_names = []
    input_vars_c = []
    list_of_out_vars = []
    proc_declare = []
    all_c_proc_lines = []
    proc_declare_cu = []
    c_proc_lines_cu= []
    for start in indices:
        end = index_containing_substring(lines[start:],'}')
        output = parseModProc(lines[start:start+end+1],all_param_line_declare,all_param_line_call)
        out_vars_c.append(output[0])
        func_names.append(output[1])
        input_vars_c.append(output[2])
        list_of_out_vars.apeend(output[3])
        first_line = output[4]
        c_local_line = output[5]
        f_lines = output[6]
        flat_f_lines = [v for v in f_lines]
        c_proc_lines = [first_line, c_local_line + flat_f_lines]
        all_c_proc_lines.append(c_proc_lines)
        curr_proc_declare = first_line[:-1] + ';'
        proc_declare.append(curr_proc_declare)
        proc_declare_cu.append(curr_proc_declare[:curr_proc_declare.find(')')-1] + end_str + ');' )
        first_line_cu = [proc_declare_cu[-1][:-1] + ' {']
        c_proc_lines_cu.append[first_line_cu + c_local_line + flat_f_lines]


def parseModProc(lines,all_param_line_declare,globals,all_param_line_call):
    c_local_line = ''
    before_first_line = ''
    local_vars = []
    local_line_ind = index_containing_substring(lines,'LOCAL')
    if local_line_ind>-1:
        local_var_line = lines[local_line_ind]
        local_var_line = local_var_line[local_var_line.index('LOCAL') +6:]
        local_vars = local_var_line.strip(' /t').split(',')
        local_vars = [x.strip(' \t') for x in local_vars ]
        c_local_line = FTYPESTR + ' ' + local_var_line + ';'
    assign_lines_ind = [i for i, x in enumerate(lines) if "=" in x]
    updated_var = []
    updated_var = [lines[i].strip(' \t').split('=')[0].strip(' \t') for i in assign_lines_ind]
    updated_var = set(updated_var)
    out_vars = list(set(updated_var)-set(local_vars))
    proc_line = lines[0][lines[0].index('PROCEDURE')+10:]  #YOU ARE HERE CHECK THIS LINE
    func_name = proc_line.replace('(',' ').split()[0]
    rest_line = proc_line[proc_line.index('(')+1:]
    rest_line = re.sub('\(.*?\)','',rest_line)
    rest_line = rest_line[:rest_line.index(')')-1]
    input_vars = rest_line.split(',')
    first_line = 'void ' + func_name + '('
    for i in range(len(input_vars)):
        tmp =''
        if i>0:
            tmp = ','
        first_line = first_line + tmp + FTYPESTR + ' ' + input_vars[i]
    first_line = first_line + all_param_line_declare + ') {'
    before_first_line = ''
    for i in range(len(out_vars)):
        tmp =''
        if i>0:
            tmp = ','
            before_first_line = before_first_line + tmp + out_vars[i]
    before_first_line = FTYPESTR + ' ' + before_first_line + ';'
    lines = lines[1:]
    indices = [i for i, x in enumerate(lines) if re.search('UNITSOFF|LOCAL|TABLE', x)]
    f_lines = [v.strip(' /t').strip(' /t')+';' for i, v in enumerate(lines) if i not in indices]
    print local_line_ind
    if local_line_ind>-1:
        local_lines = lines[local_line_ind]
    out_vars_no_globals = list(set(out_vars) - set(globals))
    tmp = ''
    out_vars_no_globals = [tmp.join(v.strip(' /t')) + ',' for v in out_vars_no_globals]
    separtor = ','
    if not out_vars_no_globals:
        separtor = ''
    all_param_line_call_c = [all_param_line_call + separtor + tmp[:-1]]


    print 'out_vars_no_globals:'
    print out_vars_no_globals
    return (out_vars,func_name,input_vars,before_first_line,first_line,c_local_line,f_lines,all_param_line_call_c)



        ### Helpers ###
def file_to_list_no_comments(FN):
    with open(FN) as f:
        lines = f.read().splitlines()
    indices = [i for i, x in enumerate(lines) if re.search('.*:.*', x)]
    for i in indices:
        lines[i]  = lines[i].split(':', 1)[0]
    lines = filter(lambda a: a.find(':') == -1, lines)
    comment_block_start = index_containing_substring(lines,'COMMENT')
    comment_block_end = index_containing_substring(lines, 'ENDCOMMENT')
    if comment_block_start!=-1:
        del lines[comment_block_start:comment_block_end + 1]
    indices = [i for i, x in enumerate(lines) if re.search('.*FROM.*TO.*', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    indices = [i for i, x in enumerate(lines) if re.search('.*DEPEND.*', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    indices = [i for i, x in enumerate(lines) if re.search('.*UNITSON.*', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    indices = [i for i, x in enumerate(lines) if re.search('.*UNITSOFF.', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    lines = [v for i, v in enumerate(lines) if not v == '']
    units_start = index_containing_substring(lines,'UNITS') # Removing for now can't see why we need them
    units_end = index_containing_substring(lines[units_start:],'}')+units_start
    units_strs=[]
    for line in lines[units_start:units_end+1]:

        tmp= re.findall('\W*(\(.*\))\W*=.*',line)
        if tmp:
            units_strs.append(tmp[0])
    units_strs.append('(degC)')
    del lines[units_start:units_end+1]
    for unit in units_strs:
        lines = [x.replace(unit,'') for x in lines]
    #lines = [re.sub(r'\([^)]*\)', '', line) for line in lines]# get rid of (**)
    return lines



def get_mech_list():
    mech_names = []
    mechlist = nrn.h.MechanismType(0)  # object that contains all mechanism names not sure we need this
    for i in range(int(mechlist.count())):
        s = nrn.h.ref('')  # string reference to store mechanism name
        mechlist.select(i)
        mechlist.selected(s)
        mech_names.append(s[0])
    return mech_names

def index_containing_substring(the_list, substring):
    for i, s in enumerate(the_list):
        if substring in s:
            return i
    return -1




def main():
    modelFile = "./runModel.hoc"
    nrn.h.load_file(1, modelFile)
    thread = nrn_dll_sym('nrn_threads', ctypes.POINTER(NrnThread))
    get_topo_list(thread)
    tmp = get_topo_f_matrix(thread)
    topo = get_topo()  # dictionary whose keys are section names
    topo_mdl = get_topo_mdl()  # dictionary whose keys are section names, and available mechanisms
    recsites = get_recsites()  # list of section names
    # mod_file_map = get_mod_file_map(topo_mdl.available_mechs) # dictionary whose keys are mechanisms suffixs and values are their .mod file name=
    mechanisms = parse_models()
    #file_to_list_no_comments('ca.mod')

if __name__ == '__main__':
    main()
