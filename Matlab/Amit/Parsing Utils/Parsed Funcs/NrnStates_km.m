function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_km (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_km;
Def_ConstsPerModelAllSegs_km;
Def_VarsPerModelPerSeg_km;
Def_VarsPerModelAllSegs_km;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = km_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  v ) ;
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(n_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(ntau_index))))*(- ( ( ( varsPerModelPerSeg(ninf_index) ) ) / varsPerModelPerSeg(ntau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(ntau_index) ) - varsPerModelPerSeg(n_index)) ;

