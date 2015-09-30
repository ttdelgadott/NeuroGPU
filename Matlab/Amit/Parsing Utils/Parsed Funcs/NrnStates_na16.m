function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_na16 (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_na16;
Def_ConstsPerModelAllSegs_na16;
Def_VarsPerModelPerSeg_na16;
Def_VarsPerModelAllSegs_na16;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = na16_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v + constsPerModelPerSeg(:, vshift_index) ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(mtau_index))))*(- ( ( ( varsPerModelPerSeg(minf_index) ) ) / varsPerModelPerSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(htau_index))))*(- ( ( ( varsPerModelPerSeg(hinf_index) ) ) / varsPerModelPerSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;

