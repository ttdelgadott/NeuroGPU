function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_ca (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_ca;
Def_ConstsPerModelAllSegs_ca;
Def_VarsPerModelPerSeg_ca;
Def_VarsPerModelAllSegs_ca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gca_index) = varsPerModelAllSeg(tadj_index) * constsPerModelPerSeg(:, gbar_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(h_index) ;
varsAllModelPerSeg(ica_index) = ( 1e-4 ) * varsPerModelPerSeg(gca_index) * ( v - constsAllModelAllSeg(eca_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ica_index);
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gca_index);

