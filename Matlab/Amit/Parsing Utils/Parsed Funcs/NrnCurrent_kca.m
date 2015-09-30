function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_kca (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_kca;
Def_ConstsPerModelAllSegs_kca;
Def_VarsPerModelPerSeg_kca;
Def_VarsPerModelAllSegs_kca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gk_index) = varsPerModelAllSeg(tadj_index) * constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(n_index) ;
varsAllModelPerSeg(ik_index) = ( 1e-4 ) * varsPerModelPerSeg(gk_index) * ( v - constsAllModelAllSeg(ek_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ik_index);
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gk_index);

