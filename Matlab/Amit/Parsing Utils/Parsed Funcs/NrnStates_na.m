function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_na (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = na_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v + constsPerModelAllSeg(vshift_index) ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(mtau_index))))*(- ( ( ( varsPerModelPerSeg(minf_index) ) ) / varsPerModelPerSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(htau_index))))*(- ( ( ( varsPerModelPerSeg(hinf_index) ) ) / varsPerModelPerSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;

