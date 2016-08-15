function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_hh2 (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_hh2;
Def_ConstsPerModelAllSegs_hh2;
Def_VarsPerModelPerSeg_hh2;
Def_VarsPerModelAllSegs_hh2;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gna_index) = constsPerModelPerSeg(:, gnabar_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(h_index) ;
varsAllModelPerSeg(ina_index) = varsPerModelPerSeg(gna_index) * ( v - constsAllModelAllSeg(ena_index) ) ;
varsPerModelPerSeg(gk_index) = constsPerModelPerSeg(:, gkbar_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) ;
varsAllModelPerSeg(ik_index) = varsPerModelPerSeg(gk_index) * ( v - constsAllModelAllSeg(ek_index) ) ;
il = constsPerModelPerSeg(:, gl_index) * ( v - constsPerModelPerSeg(:, el_index) ) ;
sumCurrents = sumCurrents + varsAllModelPerSeg(ina_index);
sumCurrents = sumCurrents + varsAllModelPerSeg(ik_index);
sumCurrents = sumCurrents + il;
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gna_index);
sumConducts = sumConducts + varsPerModelPerSeg(gk_index);
sumConducts = sumConducts + constsPerModelPerSeg(:, gl_index);

