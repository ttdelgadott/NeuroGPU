function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = CO_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_CO;
Def_ConstsPerModelAllSegs_CO;
Def_VarsPerModelPerSeg_CO;
Def_VarsPerModelAllSegs_CO;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
k12 = constsPerModelPerSeg(:, a12_index)*exp(constsPerModelPerSeg(:, z12_index)*v);
k21 = constsPerModelPerSeg(:, a21_index)*exp(-constsPerModelPerSeg(:, z21_index)*v);

