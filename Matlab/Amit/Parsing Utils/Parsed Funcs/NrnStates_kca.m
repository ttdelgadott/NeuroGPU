function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_kca (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_kca;
Def_ConstsPerModelAllSegs_kca;
Def_VarsPerModelPerSeg_kca;
Def_VarsPerModelAllSegs_kca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kca_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,  varsAllModelPerSeg(cai_index) ) ;
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(n_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsPerModelPerSeg(ntau_index))))*(- ( ( ( varsPerModelPerSeg(ninf_index) ) ) / varsPerModelPerSeg(ntau_index) ) / ( ( ( ( - 1.0) ) ) / varsPerModelPerSeg(ntau_index) ) - varsPerModelPerSeg(n_index)) ;

