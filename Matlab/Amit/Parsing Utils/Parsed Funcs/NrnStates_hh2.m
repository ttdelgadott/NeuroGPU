function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_hh2 (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_hh2;
Def_ConstsPerModelAllSegs_hh2;
Def_VarsPerModelPerSeg_hh2;
Def_VarsPerModelAllSegs_hh2;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = hh2_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(mtau_index))))*(- ( ( ( varsPerModelAllSeg(minf_index) ) ) / varsPerModelAllSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(htau_index))))*(- ( ( ( varsPerModelAllSeg(hinf_index) ) ) / varsPerModelAllSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(n_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelAllSeg(ntau_index))))*(- ( ( ( varsPerModelAllSeg(ninf_index) ) ) / varsPerModelAllSeg(ntau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelAllSeg(ntau_index) ) - varsPerModelPerSeg(n_index)) ;

