function [varsForModelForSeg, varsForModelAllSegs]= AmitNrnStates_MainenNa (dt, v, varsForModelForSeg,...
    varsForModelAllSegs, constsForModel, constsForAllModels)
Def_ConstsPerModelPerSeg_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_ConstsAllModelsAllSegs;

%QWERTY - notice it should be trates and not rates.
varsForModelForSeg = Amit_trates_MainenNa (varsForModelForSeg, constsForModel, v+constsForModel(vshift_index)) ;

m = varsForModelForSeg(m_index);
mtau = varsForModelForSeg(mtau_index);
minf = varsForModelForSeg(minf_index);

h = varsForModelForSeg(h_index);
htau = varsForModelForSeg(htau_index);
hinf = varsForModelForSeg(hinf_index);

m = m + (1.0 - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
h = h + (1.0 - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;

 varsForModelForSeg(m_index) = m;
 varsForModelForSeg(h_index) = h;
