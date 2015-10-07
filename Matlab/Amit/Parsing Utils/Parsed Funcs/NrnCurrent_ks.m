function [sumCurrents sumConducts] = NrnCurrent_ks (t, v, varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_ks;
Def_VarsPerModelPerSeg_ks;
Def_VarsPerModelAllSegs_ks;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsForModelForSeg(gk_index) = constsForModelForSeg(gkbar_index) * power( varsForModelForSeg(n_index) , 2.0 ) * varsForModelForSeg(l_index) ;
ik = varsForModelForSeg(gk_index) * ( v - constsAllModelsAllSegs(ek_index) ) ;
sumCurrents = sumCurrents + ik;
sumConducts = 0.;
sumConducts = sumConducts + varsForModelForSeg(gk_index);

