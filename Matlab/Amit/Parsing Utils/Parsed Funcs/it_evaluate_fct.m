Vm = v + constsPerModelPerSeg(:, shift_index)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
varsPerModelPerSeg(m_inf_index) = 1.0 / ( 1 + exp(-(Vm+57)/6.2) )
varsPerModelPerSeg(h_inf_index) = 1.0 / ( 1 + exp((Vm+81)/4.0) )
varsPerModelPerSeg(tau_h_index) = 30.8 + (211.4 + exp((Vm+113.2)/5)) / (1 + exp((Vm+84)/3.2))
varsPerModelPerSeg(tau_h_index) = varsPerModelPerSeg(tau_h_index) / phi_h

