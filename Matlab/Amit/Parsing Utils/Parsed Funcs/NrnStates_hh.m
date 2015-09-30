function [varsPerModelPerSeg, varsPerModelAllSeg] = NrnStates_hh (dt, v, varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg] = hh_rates(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(mtau_index))))*(- ( ( ( varsPerModelAllSeg(minf_index) ) ) / varsPerModelAllSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(htau_index))))*(- ( ( ( varsPerModelAllSeg(hinf_index) ) ) / varsPerModelAllSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(n_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(ntau_index))))*(- ( ( ( varsPerModelAllSeg(ninf_index) ) ) / varsPerModelAllSeg(ntau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(ntau_index) ) - varsPerModelPerSeg(n_index)) ;

