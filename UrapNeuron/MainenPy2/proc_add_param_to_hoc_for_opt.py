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
                # TODO
