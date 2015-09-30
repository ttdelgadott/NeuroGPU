function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_na (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gna_index) = varsPerModelAllSeg(tadj_index) * constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(h_index) ;
varsAllModelPerSeg(ina_index) = ( 1e-4 ) * varsPerModelPerSeg(gna_index) * ( v - constsAllModelAllSeg(ena_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ina_index);
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gna_index);

