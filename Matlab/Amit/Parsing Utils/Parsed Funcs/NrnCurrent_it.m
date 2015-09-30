function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_it (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gca_index) = constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(h_index) ;
varsAllModelPerSeg(ica_index) = varsPerModelPerSeg(gca_index) * ( v - constsAllModelAllSeg(eca_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ica_index);
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gca_index);

