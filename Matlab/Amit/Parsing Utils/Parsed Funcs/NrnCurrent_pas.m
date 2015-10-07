function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_pas (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_pas;
Def_ConstsPerModelAllSegs_pas;
Def_VarsPerModelPerSeg_pas;
Def_VarsPerModelAllSegs_pas;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
i = constsPerModelPerSeg(:, g_index) * ( v - constsPerModelPerSeg(:, e_index) ) ;
sumCurrents = sumCurrents + i;
sumConducts = 0.;
sumConducts = sumConducts + constsPerModelPerSeg(:, g_index);

