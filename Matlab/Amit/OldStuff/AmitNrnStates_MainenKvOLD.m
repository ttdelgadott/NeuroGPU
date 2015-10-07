function [varsForModelForSeg, varsForModelAllSegs] = AmitNrnStates_MainenKv (dt, v, varsForModelForSeg,...
    varsForModelAllSegs, constsForModel, constsForAllModels)

Def_ConstsPerModelPerSeg_MainenKv;
Def_VarsPerModelPerSeg_MainenKv;
Def_VarsPerModelAllSegs_MainenKv;
Def_ConstsAllModelsAllSegs;

%QWERTY - notice it should be trates and not rates.
varsForModelForSeg = Amit_trates_MainenKv (varsForModelForSeg, constsForModel, v) ;

n = varsForModelForSeg(n_index);
ntau = varsForModelForSeg(ntau_index);
ninf = varsForModelForSeg(ninf_index);

n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;

 varsForModelForSeg(n_index) = n;
