function [sumCurrents sumConducts] = NrnCurrent_MainenKv (t, v, VarsForModelPerSeg, VarsForModelAllSegs, constsForModelPerSeg, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_MainenKv;
Def_VarsPerModelPerSeg_MainenKv;
Def_VarsPerModelAllSegs_MainenKv;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
VarsForModelPerSeg(gk_index) = VarsForModelAllSegs(tadj_index) * constsForModelPerSeg(gbar_index) * VarsForModelPerSeg(n_index) ;
ik = ( 1e-4 ) * VarsForModelPerSeg(gk_index) * ( v - constsAllModelsAllSegs(ek_index) ) ;
sumCurrents = sumCurrents + ik;
sumConducts = 0.;
sumConducts = sumConducts + VarsForModelPerSeg(gk_index);

