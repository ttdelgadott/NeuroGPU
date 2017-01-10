from file_io import get_lines, put_lines

def proc_add_param_to_hoc_for_opt(all_parameters_non_global_c, hoc_base_fn, base_p, available_mechanisms, neuron_sc, reversals, comp_names, comp_mechanisms, g_globals, n_globals, neuron, ftypestr, p_size_set, param_set):
    param_start_i = np.array([0].extend(list(np.cumsum(cell_numel(all_parameters_non_global_c[:])))))
    fn = hoc_base_fn
    fn_with_topo = fn[:-4] + '_topo.hoc'
    fn_with_param = fn[:-4] + '_param.hoc'
    file_sep = '/'
    fn_param_m = base_p + file_sep + 'Neuron' + file_sep + 'printCell' + file_sep + 'Amit' + file_sep + 'output' + file_sep + 'ParamM.dat'
    fm_mat = fn_param_m
    lines = get_lines(fn_with_topo)
    add_line_i = np.where(np.array(['End point processes mechanisms output' in i for i in lines]))
    if add_line_i.size != 1:
        raise RuntimeError('Problem with finding place to add code: End point processes mechanisms output')
    p_size_line = np.where(np.array(['psize =' in i for i in lines]))
    if p_size_line.size != 0:
        for i in p_size_line:
            lines[i] = lines[i][0:7] + str(p_size_set)
    time_steps_line = np.where(np.array(['ntimestep =' in i for i in lines]))
    n_sets = []
    for i in p_size_line:
        n_sets.append(int(lines[i][7:]))
    nt = []
    for i in time_steps_line:
        nt.append(int(lines[i][11:]))
    params_set_line = np.where(np.array(['paramsFile =' in i for i in lines]))
    if params_set_line.size != 0:
        for i in params_set_line:
            lines[i] = lines[i][:16] + param_set + '"'
    param_name = lines[params_set_line[0]][17:-5]
    for cur_mod_i in range(1, available_mechanisms + 1):
        reversals_c[cur_mod_i - 1] = neuron_sc[cur_mod_i - 1].Reversals
    for i in range(1, reversals + 1):
        found_rep_comp = False
        while not found_rep_comp:
            for c in range(1, comp_names + 1):
                cur_mech_f = []
                for i in available_mechanisms:
                    cur_mech_f.append(i in comp_mechanisms[c - 1])
                cur_mech_f = np.where(np.array(cur_mech_f))
                tmp = reversals_c[cur_mech_f]
                cur_reversals = []
                for j in range(1, len(tmp) + 1):
                    curr_temp = tmp[j - 1]
                    for jj in range(1, len(curr_tmp) + 1):
                        cur_reversals.append(curr_temp[jj - 1])
                cur_reversals = np.array(cur_reversals)
                if reversals[i - 1] in cur_reversals:
                    rep_comp[i - 1] = c
                    found_rep_comp = True
                    break
    added_lines = []
    added_lines.append('// Start params output')
    added_lines.append('proc writeReversals(){')
    for i in range(1, len(reversals) + 1):
        added_lines.append('access ' + np.array_str(comp_names[rep_comp[i - 1]][1:]))
        added_lines.append('a=' + str(reversals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    added_lines.append('proc writeGGlobals(){')
    for i in range(1, len(g_globals) + 1):
        added_lines.append('a=' + str(g_globals[i]))
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
        funcs.append('access ' + np.array_str(comp_names[c][1:]))
        counter += 1
        for m in range(1, len(F) + 1):
            cur_mech_params = all_parameters_non_global_c[F[m - 1]]
            for p in range(1, len(cur_mech_params) + 1):
                funcs.append('a=' + np.array_str(cur_mech_params[p - 1]))
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
    out_lines.extend([lines[i] for i in range(add_line_i)])
    out_lines.extend(added_lines)
    out_lines.extend([lines[i] for i in range(add_line_i + 1, len(lines))])
    # TODO
