function [sumCurrents sumConducts] = NrnCurrent_MainenNa (t, v, VarsForModelPerSeg, VarsForModelAllSegs, constsForModelPerSeg, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_MainenNa;
Def_VarsPerModelPerSeg_MainenNa;
Def_VarsPerModelAllSegs_MainenNa;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
VarsForModelPerSeg(gna_index) = VarsForModelAllSegs(tadj_index) * constsForModelPerSeg(gbar_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(m_index) * VarsForModelPerSeg(h_index) ;
VarsForModelPerSeg(ina_index) = ( 1e-4 ) * VarsForModelPerSeg(gna_index) * ( v - constsAllModelsAllSegs(ena_index) ) ;
sumCurrents = sumCurrents + VarsForModelPerSeg(ina_index);
sumConducts = 0.;
sumConducts = sumConducts + VarsForModelPerSeg(gna_index);

