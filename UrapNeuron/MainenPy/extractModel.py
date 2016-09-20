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
    model_name=[]
    reads =[]
    writes =[]
    only_reads = []
    all_states = []
    lines = []
    globals = []
    nglobals_c = []
    ions_c = []
    all_state_line=[]
    reads_no_reversals = []
    only_reads_no_reversals = []
    write_no_currents = []
    all_state_line_seg = []
    all_assigned = []
    gs = []
    mod_files = list(glob.glob('*.mod'))
    mod_files.remove('branching.mod')
    for  i in range(len(mod_files)):
        mod_f = mod_files[i]
        print 'parsing ' + mod_f
        lines.append(file_to_list_no_comments(mod_f))
       # print 'parsing ' + mod_f + 'i is ' + repr(i)
        output = parse_model(lines[i])
        #return [model_name,globals,ions,reads,writes,only_reads,nglobal_c,curr_all_state,all_state_line]
        model_name.append(output[0])
        ions_c.append(output[2])
        currents = ['i' + s for s in ions_c[i]]
        reads.append(output[3])
        writes.append(output[4])
        curr_gs = ['g' + s for s in ions_c[i]]
        gs.append(curr_gs)
        curr_writes_no_currents = set(writes[i]) - set(currents)
        write_no_currents.append(curr_writes_no_currents)
        only_reads_tmp = output[5]
        only_reads.append(only_reads_tmp)
        curr_all_states = output[7]
        all_states.append(curr_all_states)
        globals.append(output[1])
        nglobals_c.append(output[6])
        all_state_line.append(output[8])
        all_state_line_seg.append(output[9])
        all_assigned.append(output[10])
        reversals = set(['e' + v for v in ions_c[i]])
        tmp = only_reads_tmp-reversals
        only_reads_no_reversals.append(tmp)
    ions = set([item for sublist in ions_c for item in sublist])
    all_currents = ['i' + s for s in ions]
    all_reversals = ['e' + s for s in ions]
    all_reads = set([item for sublist in reads for item in sublist])
    all_reads_no_reversals = set(all_reads-set(all_reversals))
    for i in range(len(lines)):
        print 'parsing ' + model_name[i]
        output = parse_model2(lines[i],globals[i],all_state_line[i],all_state_line_seg[i],model_name[i],only_reads_no_reversals[i],write_no_currents[i],all_reads_no_reversals,writes[i],all_assigned[i],all_states[i],reads[i],gs[i])





def parse_model(lines):

    writes = []
    reads = []
    ions = []
    nglobal_c = []
    only_reads = []
    #output = get_mech_writes_reads(lines) # we might not need this.
    output = handle_neuron_block(lines)
    #return [suffix, currglobal, Useion, NSC, reads, writes, Range]
    model_name = output[0]
    globals = output[1]
    ions = output[2]
    reads = output[4]
    writes = output[5]
    only_reads = set(set(reads) - set(writes))
    nglobal_c = [ v  + '_' + model_name for v in globals]
    all_assigned = handle_assigned_block(lines)
    output = handle_state_block(lines)
    if not output:
        output = ['',[],[]]
    all_state_line = output[0]
    all_state_line_seg = output[1]
    curr_all_state = output[2]
    return [model_name,globals,ions,reads,writes,only_reads,nglobal_c,curr_all_state,all_state_line,all_state_line_seg,all_assigned]


def parse_model2(lines,globals,all_state_line,all_state_line_seg,model_name,only_reads_no_reversals,writes_no_currents,all_reads_no_reversals,writes,all_assigned,all_states,reads,gs):
    output = handle_params_block(lines,globals)
    # return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_params_line_call,all_params]
    all_params_line = output[0]
    all_params_line_seg = output[1]
    all_params = output[5]
    all_param_line_declare = output[3]
    all_params_line_call = output[4]

    #MIGHT need to pass this to parse model
    output = create_states_param_str(all_state_line,all_state_line_seg,all_params_line,all_params_line_seg,only_reads_no_reversals,writes_no_currents,all_reads_no_reversals,writes)
    states_params_str = output[0]
    states_params_str_seg = output[1]
    #return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_params_line_call]
    output = handle_mod_function(lines)
    #[func_names,c_func_lines,input_vars]
    func_names = output[0]
    c_func_lines = output[1]
    input_vars = output[2]
    output = handle_mod_procedures(lines,model_name,all_param_line_declare,globals,all_params_line_call)
    #return [str_of_out_vars, before_first_line_all, all_c_proc_lines_cu, func_names, input_vars_c, all_out_vars]
    before_first_line_all = output[1]
    proc_names = output[3]
    input_vars_proc = output[4]
    all_out_vars = output[5]
    tmpset = set(['celsius','v'] +all_states +all_params +reads+writes)
    locals = set(all_assigned)-tmpset
    output = handle_initial_block(lines,model_name,states_params_str,states_params_str_seg,proc_names,input_vars_proc,all_params_line_call,before_first_line_all)
    # handle_initial_block(lines,model_name,states_params_str,func_names,input_vars_c,all_param_li
    output = handle_deriv_block(lines,model_name,states_params_str,all_states,locals,all_params,all_out_vars,gs)

    #def handle_deriv_block(lines, model_name, states_params_str, states, locals, all_parameters, all_out_vars,conductances):

    return [locals]

def create_states_param_str(all_state_line,all_state_line_seg,all_params_line,all_params_line_seg,only_reads_no_reversals,writes_no_currents,all_reads_no_reversals,writes):
    additional_writes = set(set(v for  v in writes) & all_reads_no_reversals)-set(writes_no_currents)
    only_reads_no_reversals = [v for v in only_reads_no_reversals]
    additional_writes = [v for v in additional_writes]
    state_param_sep = ''
    param_global_sep = ''
    if all_state_line:
        state_param_sep=','
    if all_params_line:
        param_global_sep = ','
    only_read = ''
    only_read_seg = ''
    if only_reads_no_reversals:
        only_read = [', float ' + s for s in only_reads_no_reversals]
        only_read = ''.join(only_read)
        only_read_seg = [', ' + s +' [ seg ]' for s in only_reads_no_reversals]
        only_read_seg = ''.join(only_read_seg)
    write_no_current = ''
    write_no_current_seg = ''
    if writes_no_currents:
        write_no_current = [', float &' + s for s in writes_no_currents]
        write_no_current_seg = [', ' + s + ' [ seg ]' for s in writes_no_currents]
        write_no_current = ''.join(write_no_current)
        write_no_current_seg = ''.join(write_no_current_seg)
    if additional_writes:
        additional_writes = [', float &' + s for s in additional_writes]
        additional_writes_seg = [', ' + s + ' [ seg ]' for s in additional_writes]
        additional_writes = ''.join(additional_writes)
        additional_writes_seg = ''.join(additional_writes_seg)
    else:
        additional_writes= ''
        additional_writes_seg = ''

    #your here and line 126 in handlemodlassigned

    states_params_str = state_param_sep + all_state_line + param_global_sep + all_params_line + only_read + write_no_current + additional_writes
    states_params_str_seg = state_param_sep + all_state_line_seg + param_global_sep + all_params_line_seg + only_read_seg + write_no_current_seg + additional_writes_seg
    return [states_params_str,states_params_str_seg]






def handle_initial_block(lines,model_name,states_params_str,states_params_str_seg,proc_names,input_vars_c,all_param_line_call,before_first_line_all):
    start = index_containing_substring(lines, 'INITIAL')
    if start < -1:
        return []
    sumP = lines[start].count('{') - lines[start].count('}')
    currInd = start + 1
    while (sumP > 0):
        sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
        currInd += 1
    end = currInd
    tmp = lines[start].find('}')
    if tmp>-1:
        lines = lines[start][tmp:].split(' ')
    else:
        lines = lines[start+1:end]
    first_line = 'void InitModel_' + model_name + '(float v' + states_params_str + '){'
    init_declare = first_line[:-1] + ';'
    tmp_lines = [s+';' for s in lines]
    tmp_ind = index_containing_substring(tmp_lines,'SOLVE')
    if tmp_ind>-1:
        tmp_lines[tmp_ind] = '}'
    c_init_lines = [first_line] + tmp_lines
    c_init_lines = add_params_to_func_call(c_init_lines,proc_names,input_vars_c,all_param_line_call)
    call_to_init = 'InitModel_' + model_name + '(V[seg]' + states_params_str_seg + ');'
    tmp_lines_cu = tmp_lines
    var_def_line = ''
    has_proc_call = False
    for proc in proc_names:
        proc_ind = index_containing_substring(tmp_lines_cu,proc)
        if proc_ind>-1:
            has_proc_call = True
            tmp_line = tmp_lines_cu[proc_ind][:tmp_lines_cu[proc_ind].rfind(')')]
            tmp_lines_cu[proc_ind] = tmp_line+ ',' + all_param_line_call + ');'
    if has_proc_call:
        c_init_lines_cu = [first_line] + [before_first_line_all]+tmp_lines_cu
    else:
        c_init_lines_cu = [first_line] + tmp_lines_cu
    c_init_lines_cu[0] = '__device__' + re.sub(c_init_lines_cu[0],'void\W*','void Cu')


def handle_deriv_block(lines,model_name,states_params_str,states,locals,all_parameters,all_out_vars,conductances):
    start = index_containing_substring(lines, 'DERIVATIVE')
    if start < 0:
        return []
    sumP = lines[start].count('{') - lines[start].count('}')
    currInd = start + 1
    while (sumP > 0):
        sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
        currInd += 1
    end = currInd
    tmp = lines[start].find('}')
    lines = lines[start + 1:end]
    first_line = 'void DerivModel_' + model_name + '(float dt, float v' + states_params_str + '){'
    derivs = [s + '_d,' for s in states]
    derivs[-1] = derivs[-1][:-1]
    second_line_x = FTYPESTR + ' '.join(derivs) + ';'
    tmp_vars = set(locals-set(all_parameters))- set(all_out_vars | set(conductances))
    locals_line = ''
    if tmp_vars:
        locals_line = [s + ',' for s in tmp_vars]
        locals_line = FTYPESTR.join(locals_line)
        locals_line = locals_line[:-1] + ';'
    deriv_declare = first_line[:-1] + ';'
    tmp_lines = [re.sub("'",'_d',s)+';' for s in lines ]
    add_deriv_lines = [s + '+=' + s + '_d*dt;' for s in states]
    print tmp_lines


#CInitLines=AddParamsToFuncCall(CInitLines,FuncNames,InputVarsC,AllParamLineCall);






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

def handle_neuron_block(lines):
    writes = []
    reads = []
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
            suffix=rest.strip(' ')
        elif first.find('USEION')>0:


            [ion_name,rest] = rest.split(' ',1)
            Useion = [ion_name]
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


    return [suffix, currglobal, Useion, NSC, reads,writes,Range]

def handle_assigned_block(lines):
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

def handle_state_block(lines):
    states=[]
    all_states = []
    all_state_line = ''
    all_state_line_seg = ''
    start = index_containing_substring(lines,'STATE')
    if start==-1:
        return [all_state_line,all_state_line_seg,states]
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

    return [all_state_line,all_state_line_seg,states]

def handle_params_block(lines,globals):
    params = []
    new_params_lines = []
    new_params_lines_with_values = []
    all_params_line = str(0)
    all_params_line_seg = []
    c_param_lines = []
    all_param_line_declare = ''
    all_params_line_call = ''
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
    return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_params_line_call,all_params]

def handle_mod_function(lines):
    func_names = []
    func_names_cu = []
    c_func_lines =[]
    c_func_lines_cu = []
    input_vars = []
    indices = [i for i, x in enumerate(lines) if "FUNCTION" in x]
    for start in indices:
        sumP =lines[start].count('{') - lines[start].count('}')
        currInd = start+1
        while(sumP>0):
            sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
            currInd += 1
        end = currInd
        output = parse_mod_function(lines[start:end])
        func_names.append(output[0])
        func_names_cu.append('Cu' + output[0])
        c_func_lines.append(output[1])
        input_vars.append(output[2])
        c_func_lines_cu.append('__device__ ' + re.sub(output[0],'Cu' + output[0],output[1][0]))
    return [func_names,c_func_lines,input_vars]

def parse_mod_function(lines):
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
    return [func_name,c_func_lines,input_vars]


def handle_mod_procedures(lines,model_name,all_param_line_declare,globals,all_params_line_call):
    indices = [i for i, x in enumerate(lines) if "PROCEDURE" in x]
    out_vars_c = []
    func_names = []
    input_vars_c = []
    list_of_out_vars = []
    proc_declare = []
    all_c_proc_lines = []
    proc_declare_cu = []
    all_c_proc_lines_cu = []
    all_params_line_call_c = []
    all_out_vars = set()
    out_vars = []
    local_vars = []
    for start in indices:
        end = index_containing_substring(lines[start:],'}')
        output = parse_mod_proc(lines[start:start+end+1],all_param_line_declare,globals,all_params_line_call)
        #out_vars, func_name, input_vars, before_first_line, first_line, c_local_line, f_lines, params_line_call_c,local_vars)
        out_vars = output[0]
        out_vars_c.append(output[0])
        func_names.append(output[1])
        input_vars_c.append(output[2])
        list_of_out_vars.append(output[3])
        first_line = output[4]
        c_local_line = output[5]
        f_lines = output[6]
        all_params_line_call_c.append(output[7])
        #local_vars.append(output[8])
        flat_f_lines = [v for v in f_lines]
        #flat_f_lines = ''.join(flat_f_lines)
        c_proc_lines = [first_line,c_local_line]
        for v in flat_f_lines:
            c_proc_lines.append(v)
        all_c_proc_lines.append(c_proc_lines)
        curr_proc_declare = first_line[:-1] + ';'
        proc_declare.append(curr_proc_declare)
        proc_declare_cu.append(curr_proc_declare[:curr_proc_declare.find(')')] + end_str + ');' )
        first_line_cu = proc_declare_cu[-1][:-1] + ' {'
        c_proc_lines_cu = [first_line_cu,c_local_line]
        for v in flat_f_lines:
            c_proc_lines_cu.append(v)
        all_c_proc_lines_cu.append(c_proc_lines_cu)
    all_out_vars = all_out_vars.union(out_vars)
    all_out_vars = all_out_vars.difference(globals)
    tmp_str = ''
    #tmp = [FTYPESTR + ' &' + v +',' for v in all_out_vars]
    #tmp = tmp[:-1]
    tmp = ''
    tmp2 = ''
    before_first_line_all = ''
    for s in all_out_vars:
        tmp2 = tmp2 + s + ','
        tmp_str = tmp_str + FTYPESTR + ' &' + s + ','
        before_first_line_all = before_first_line_all + tmp +s
        tmp = ','
    tmp_str = tmp_str[:-1]
    str_of_out_vars = before_first_line_all
    before_first_line_all = FTYPESTR + ' ' + before_first_line_all + ';'
    seperator = ','
    if not all_out_vars:
        seperator = ''
    #all_params_line_call_all = all_params_line_call + seperator + tmp2[:-1]
    for i in range(len(indices)):
        c_proc_lines = all_c_proc_lines[i]
        proc_declare_cu[i] ='__device__ ' + proc_declare_cu[i].replace(end_str,seperator + tmp_str)
        proc_declare_cu[i] = re.sub('void\W*','void Cu',proc_declare_cu[i])
        proc_declare_cu[i] = re.sub('\W*\(','_' + model_name + '(', proc_declare_cu[i])
        #print 'start printing'
        #print c_proc_lines
        #YOU ARE HERE PUT C PROC LINES IN ORDER
        out = add_params_to_func_call(c_proc_lines[1:], func_names, input_vars_c, all_params_line_call)
        #print 'out is'
        #print out
        c_proc_lines = [c_proc_lines[0]]
        for s in out:
            c_proc_lines.append(s)
        all_c_proc_lines[i] = c_proc_lines
        curr_c_proc_cu = all_c_proc_lines_cu[i][0]
        curr_c_proc_cu = '__device__ ' + curr_c_proc_cu.replace(end_str,seperator + tmp_str)
        curr_c_proc_cu = re.sub('void\W*','void Cu',curr_c_proc_cu)
        curr_c_proc_cu = re.sub('\W*\(', '_' + model_name + '(', curr_c_proc_cu)
        all_c_proc_lines_cu[i][0] = curr_c_proc_cu
    for k in range(len(indices)):
        tmp_lines_cu = all_c_proc_lines_cu[k][1:]
        for i in range(len(tmp_lines_cu)):
            for j in range(len(func_names)):
                func_call_i = tmp_lines_cu[i].find(func_names[j])
                if func_call_i > -1:
                    tmp_line = tmp_lines_cu[i][:tmp_lines_cu[i].rfind(')')]
                    tmp_lines_cu[i] = tmp_line + ',' + all_params_line_call_c[j] + ');'
        all_c_proc_lines_cu[k][1:] = tmp_lines_cu

    return [str_of_out_vars,before_first_line_all,all_c_proc_lines_cu,func_names,input_vars_c,all_out_vars]
    #return [out_vars_c,func_names,input_vars_c,list_of_out_vars,proc_declare,all_c_proc_lines,proc_declare_cu,c_proc_lines_cu ]


def parse_mod_proc(lines,all_param_line_declare,globals,all_params_line_call):
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
    if local_line_ind>-1:
        local_lines = lines[local_line_ind]
    out_vars_no_globals = list(set(out_vars) - set(globals))
    tmp = ''
    out_vars_no_globals = [tmp.join(v.strip(' /t')) + ',' for v in out_vars_no_globals]
    out_vars_no_globals = ''.join(out_vars_no_globals)
    separtor = ','
    if not out_vars_no_globals:
        separtor = ''
    params_line_call_c = all_params_line_call + separtor + out_vars_no_globals[:-1]
    return (out_vars,func_name,input_vars,before_first_line,first_line,c_local_line,f_lines,params_line_call_c,local_vars)



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


def add_params_to_func_call(input,func_names,input_vars_c,all_param_line_call):
    out = input
    end_i =0
    seperator = ''
    for i in range(len(input)):
        curr_line = out[i]
        for j in range(len(func_names)):
            func_call_i = curr_line.find(func_names[j])
            if func_call_i==-1:
                continue
            cur_ends_i = [m.start() for m in re.finditer('\\)', curr_line)]
            end_i = -1
            for k in cur_ends_i:
                if k>func_call_i:
                    end_i = k
                    break
            seperator = ','
            if not input_vars_c:
                seperator = ''
            new_curr_line = curr_line[:end_i]+ seperator + all_param_line_call + curr_line[end_i:]
            curr_line = new_curr_line
        out[i] = curr_line
    return out



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
