function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_CO (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_CO;
Def_ConstsPerModelAllSegs_CO;
Def_VarsPerModelPerSeg_CO;
Def_VarsPerModelAllSegs_CO;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(g_index) = constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(o_index) ;
varsAllModelPerSeg(ik_index) = ( 1e-4 ) * varsPerModelPerSeg(g_index) * ( v - constsAllModelAllSeg(ek_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ik_index);
sumConducts = 0.;
sumConducts = sumConducts + gk;

