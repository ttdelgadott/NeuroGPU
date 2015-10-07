function [sumCurrents sumConducts] = NrnCurrent_HH (t, v, VarsForModelPerSeg, VarsForModelAllSegs, constsForModelPerSeg, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_HH;
Def_VarsPerModelPerSeg_HH;
Def_VarsPerModelAllSegs_HH;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
VarsForModelPerSeg(gna_index) = constsForModelPerSeg(gnabar_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(h_index) ;
ina = VarsForModelPerSeg(gna_index) * ( v - constsAllModelsAllSegs(ena_index) ) ;
VarsForModelPerSeg(gk_index) = constsForModelPerSeg(gkbar_index) * VarsForModelPerSeg(n_index) * VarsForModelPerSeg(n_index) * VarsForModelPerSeg(n_index) * VarsForModelPerSeg(n_index) ;
ik = VarsForModelPerSeg(gk_index) * ( v - constsAllModelsAllSegs(ek_index) ) ;
il = constsForModelPerSeg(gl_index) * ( v - constsForModelPerSeg(el_index) ) ;
sumCurrents = sumCurrents + ina;
sumCurrents = sumCurrents + ik;
sumCurrents = sumCurrents + il;
sumConducts = 0.;
sumConducts = sumConducts + VarsForModelPerSeg(gna_index);
sumConducts = sumConducts + VarsForModelPerSeg(gk_index);
sumConducts = sumConducts + constsForModelPerSeg(gl_index);

