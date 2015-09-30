function [sumCurrents sumConducts] = NrnCurrent_hh (t, v, varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
varsPerModelPerSeg(gna_index) = constsPerModelPerSeg(:, gnabar_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(m_index) * varsPerModelPerSeg(h_index) ;
ina = varsPerModelPerSeg(gna_index) * ( v - constsAllModelAllSeg(ena_index) ) ;
varsPerModelPerSeg(gk_index) = constsPerModelPerSeg(:, gkbar_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) * varsPerModelPerSeg(n_index) ;
ik = varsPerModelPerSeg(gk_index) * ( v - constsAllModelAllSeg(ek_index) ) ;
il = constsPerModelPerSeg(:, gl_index) * ( v - constsPerModelPerSeg(:, el_index) ) ;
sumCurrents = sumCurrents + ina;
sumCurrents = sumCurrents + ik;
sumCurrents = sumCurrents + il;
sumConducts = 0.;
sumConducts = sumConducts + varsPerModelPerSeg(gna_index);
sumConducts = sumConducts + varsPerModelPerSeg(gk_index);
sumConducts = sumConducts + constsPerModelPerSeg(:, gl_index);

