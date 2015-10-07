function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_kv (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gk_index) = varsPerModelAllSeg(tadj_index) * constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(n_index) ;
varsAllModelPerSeg(ik_index) = ( 1e-4 ) * varsPerModelPerSeg(gk_index) * ( v - constsAllModelAllSeg(ek_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ik_index);
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gk_index);

