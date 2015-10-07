function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_na12 (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_na12;
Def_ConstsPerModelAllSegs_na12;
Def_VarsPerModelPerSeg_na12;
Def_VarsPerModelAllSegs_na12;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = na12_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v + constsPerModelPerSeg(:, vshift_index) ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(mtau_index))))*(- ( ( ( varsPerModelPerSeg(minf_index) ) ) / varsPerModelPerSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(htau_index))))*(- ( ( ( varsPerModelPerSeg(hinf_index) ) ) / varsPerModelPerSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;

