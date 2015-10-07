function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = it_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v_)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
varsPerModelPerSeg(minf_index) = 1.0 / ( 1 + exp(-(v_+constsPerModelAllSeg(v12m_index))/constsPerModelAllSeg(vwm_index)) );
varsPerModelPerSeg(hinf_index) = 1.0 / ( 1 + exp((v_+constsPerModelAllSeg(v12h_index))/constsPerModelAllSeg(vwh_index)) );
varsPerModelPerSeg(mtau_index) = ( constsPerModelAllSeg(am_index) + 1.0 / ( exp((v_+constsPerModelAllSeg(vm1_index))/constsPerModelAllSeg(wm1_index)) + exp(-(v_+constsPerModelAllSeg(vm2_index))/constsPerModelAllSeg(wm2_index)) ) ) ;
varsPerModelPerSeg(htau_index) = ( constsPerModelAllSeg(ah_index) + 1.0 / ( exp((v_+constsPerModelAllSeg(vh1_index))/constsPerModelAllSeg(wh1_index)) + exp(-(v_+constsPerModelAllSeg(vh2_index))/constsPerModelAllSeg(wh2_index)) ) ) ;

