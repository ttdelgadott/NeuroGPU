from file_io import get_lines, put_lines
import os
import neuron as nrn
import numpy as np
from cell import cell_numel

def get_comp_index(types, compt_name):
    ind = []
    for i in range(1, len(types) + 1):
        if(compt_name in types[i - 1] and types[i - 1][len(compt_name) - 1] == '('):
            ind.append(i)
    return ind

def proc_add_param_to_hoc_for_opt(all_parameters_non_global_c, hoc_base_fn, base_p, available_mechanisms, neuron_sc, reversals, comp_names, comp_mechanisms, g_globals, n_globals, neuron, ftypestr, p_size_set, param_set):
    param_start_i = np.array([0] + list(np.cumsum(cell_numel(np.array(all_parameters_non_global_c[:])))))
    fn = hoc_base_fn
    fn_with_topo = fn[:-4] + '_topo.hoc'
    fn_with_param = fn[:-4] + '_param.hoc'
    file_sep = '/'
    fn_param_m = base_p + file_sep + '..' + file_sep + '..' + file_sep + 'Neuron' + file_sep + 'printCell' + file_sep + 'Amit' + file_sep + 'output' + file_sep + 'ParamM.dat'
    fn_mat = fn_param_m
    lines = get_lines(fn_with_topo)
    add_line_i = np.where(np.array(['End point processess mechanisms output' in i for i in lines]))
    if add_line_i[0].size != 1:
        raise RuntimeError('Problem with finding place to add code: End point processes mechanisms output')
    p_size_line = np.where(np.array(['psize =' in i for i in lines]))
    if p_size_line[0].size != 0:
        for i in p_size_line[0]:
            lines[i] = lines[i][0:7] + str(p_size_set)
    time_steps_line = np.where(np.array(['ntimestep =' in i for i in lines]))
    n_sets = []
    for i in p_size_line[0]:
        n_sets.append(int(lines[i][7:]))
    nt = []
    for i in time_steps_line[0]:
        nt.append(int(lines[i][11:]))
    params_set_line = np.where(np.array(['paramsFile =' in i for i in lines]))
    if params_set_line[0].size != 0:
        for i in params_set_line[0]:
            lines[i] = lines[i][:16] + param_set + '"'
    param_name = lines[params_set_line[0][0]][17:-5]
    reversals_c = [None for i in range(len(available_mechanisms))]
    for cur_mod_i in range(1, len(available_mechanisms) + 1):
        reversals_c[cur_mod_i - 1] = neuron_sc[cur_mod_i - 1]
    reversals_c = np.array(reversals_c)
    reversals = list(reversals)
    rep_comp = [None for i in range(len(reversals))]
    for i in range(1, len(reversals) + 1):
        found_rep_comp = False
        while not found_rep_comp:
            for c in range(1, len(comp_names) + 1):
                cur_mech_f = []
                for k in available_mechanisms:
                    cur_mech_f.append(k in comp_mechanisms[c - 1])
                cur_mech_f = np.where(np.array(cur_mech_f))
                tmp = reversals_c[cur_mech_f[0]]
                cur_reversals = []
                for j in range(1, len(tmp) + 1):
                    curr_temp = list(tmp[j - 1])
                    for jj in range(1, len(curr_temp) + 1):
                        cur_reversals.append(curr_temp[jj - 1])
                cur_reversals = np.array(cur_reversals)
                cr = list(reversals[i - 1])
                cin = False
                for r in cr:
                    if r in cur_reversals:
                        cin = True
                        break
                if cin:
                    rep_comp[i - 1] = c
                    found_rep_comp = True
                    break
    added_lines = []
    added_lines.append('// Start params output')
    added_lines.append('proc writeReversals(){')
    for i in range(1, len(reversals) + 1):
        added_lines.append('access ' + comp_names[rep_comp[i - 1]])
        added_lines.append('a=' + str(reversals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    added_lines.append('proc writeGGlobals(){')
    for i in range(1, len(g_globals) + 1):
        added_lines.append('a=' + str(g_globals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    funcs_index = len(added_lines)
    added_lines.append('proc printParams(){')
    added_lines.append('fn.wopen("' + fn_param_m + '")')
    added_lines.append('writeReversals()')
    added_lines.append('writeGGlobals()')
    added_lines.append('writeNGlobals()')
    added_lines.append('for (ii=0;ii<pmat.nrow();ii+=1){')
    added_lines.append('transvec = pmat.getrow(ii)')
    added_lines.append('tfunc()')
    added_lines.append('finitialize()')
    proc_counter, counter = 0, 0
    funcs = []
    func_name = 'proc' + str(proc_counter) + '()'
    added_lines.append(func_name)
    funcs.append('proc ' + func_name + '{')
    for c in range(1, len(comp_names) + 1):
        if counter > 50:
            funcs.append('}')
            proc_counter += 1
            counter = 0
            func_name = 'proc' + str(proc_counter) + '()'
            added_lines.append(func_name)
            funcs.append('proc ' + func_name + '{')
        F = []
        for i in available_mechanisms:
            F.append(i in comp_mechanisms[c - 1])
        F = np.where(np.array(F))
        funcs.append('access ' + comp_names[c - 1][1:])
        counter += 1
        for m in range(1, len(F[0]) + 1):
            cur_mech_params = all_parameters_non_global_c[F[0][m - 1]]
            for p in range(1, len(cur_mech_params) + 1):
                funcs.append('a=' + cur_mech_params[p - 1])
                funcs.append('fn.vwrite(&a)')
                counter += 2
    if counter > 0:
        funcs.append('}')
    added_lines_temp = []
    added_lines_temp.extend([added_lines[i] for i in range(funcs_index)])
    added_lines_temp.extend(funcs)
    added_lines_temp.extend([added_lines[i] for i in range(funcs_index + 1, len(added_lines))])
    added_lines = added_lines_temp
    added_lines.append('}')
    added_lines.append('fn.close()')
    added_lines.append('}')
    added_lines.append('printParams()')
    added_lines.append('// End params output')
    added_lines.append('// Start Mat Output')
    added_lines.append('fcurrent()')
    added_lines.append('hoc_stdout("' + fn_mat + '")')
    added_lines.append('MyPrintMatrix()')
    added_lines.append('hoc_stdout()')
    added_lines.append('// endMat Output')
    out_lines = []
    out_lines.extend([lines[i] for i in range(add_line_i[0])])
    out_lines.extend(added_lines)
    out_lines.extend([lines[i] for i in range(len(add_line_i[0]) + 1, len(lines))])
    put_lines(fn_with_param, out_lines)
    hoc_p = os.path.dirname(fn_with_param)
    hoc_n, hoc_ext = os.path.splitext(fn_with_param)
    nrn.h.load_file(1, fn_with_param)
    f = open(fn_param_m, 'rb')
    reversals_v, g_globals_v, n_globals_v = [0 for i in range(len(reversals))], [0 for i in range(len(g_globals))], [0 for i in range(len(n_globals))]
    for i in range(len(reversals)):
        reversals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(g_globals)):
        g_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(n_globals)):
        n_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    comp_topology_map = [None for i in range(len(comp_names))]
    all_params = np.zeros((n_sets[0], len(comp_names) * len(all_parameters_non_global_c)))
    for kk in range(1, n_sets[0] + 1):
        param_m = np.zeros((len(comp_names), len(all_parameters_non_global_c)))
        for c in range(1, len(comp_names) + 1):
            comp_name = comp_names[c - 1]
            comp_ind = get_comp_index(comp_names, comp_name)
            comp_topology_map[c - 1] = comp_ind
            F = []
            for i in available_mechanisms:
                F.append(i in comp_mechanisms[c - 1])
            F = np.where(np.array(cur_mech_f))
            for m in range(1, F[0].size + 1):
                cur_mech_params = all_parameters_non_global_c[F[0][m - 1]]
                for p in range(1, len(cur_mech_params) + 1):
                    Tmp = np.fromfile(f, dtype=np.float64, count=1)
                    param_m[comp_ind, int(param_start_i[F[0][m - 1]] + p - 1)] = Tmp
        tmp = param_m.reshape((all_params.shape[0] * all_params.shape[1],))
        all_params[kk - 1,:] = tmp
        param_m = []
    f.close()
    all_params = all_params.reshape((all_params.shape[0] * all_params.shape[1],))
    f = open('../../Data/AllParams.dat', 'w')
    f.write(np.array(n_sets).astype(np.uint16))
    f.write(all_params.astype(np.float32))
    f.close()
