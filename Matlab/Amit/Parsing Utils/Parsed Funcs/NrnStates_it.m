function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_it (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = it_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v + constsPerModelAllSeg(vshift_index) ) ;
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(mtau_index))))*(- ( ( ( varsPerModelPerSeg(minf_index) ) ) / varsPerModelPerSeg(mtau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(mtau_index) ) - varsPerModelPerSeg(m_index)) ;
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(htau_index))))*(- ( ( ( varsPerModelPerSeg(hinf_index) ) ) / varsPerModelPerSeg(htau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(htau_index) ) - varsPerModelPerSeg(h_index)) ;

