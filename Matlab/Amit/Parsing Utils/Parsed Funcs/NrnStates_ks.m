function [varsForModelForSeg, varsForModelAllSegs] = NrnStates_ks (dt, v, varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_ks;
Def_VarsPerModelPerSeg_ks;
Def_VarsPerModelAllSegs_ks;
Def_ConstsAllModelsAllSegs;
[varsForModelForSeg, varsForModelAllSegs] = ks_rates(varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs,  v ) ;
varsForModelForSeg(n_index) = varsForModelForSeg(n_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsForModelAllSegs(taun_index))))*(- ( ( ( varsForModelAllSegs(ninf_index) ) ) / varsForModelAllSegs(taun_index) ) / ( ( ( ( - 1.0) ) ) / varsForModelAllSegs(taun_index) ) - varsForModelForSeg(n_index)) ;
varsForModelForSeg(l_index) = varsForModelForSeg(l_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / varsForModelAllSegs(taul_index))))*(- ( ( ( varsForModelAllSegs(linf_index) ) ) / varsForModelAllSegs(taul_index) ) / ( ( ( ( - 1.0) ) ) / varsForModelAllSegs(taul_index) ) - varsForModelForSeg(l_index)) ;

