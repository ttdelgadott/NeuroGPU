function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnStates_cad (dt, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_cad;
Def_ConstsPerModelAllSegs_cad;
Def_VarsPerModelPerSeg_cad;
Def_VarsPerModelAllSegs_cad;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
drive_channel = - ( 10000.0 ) * varsAllModelPerSeg(ica_index) / ( 2.0 * constsAllModelAllSeg(FARADAY_index) * constsPerModelAllSeg(depth_index) ) ;
if ( drive_channel <= 0. )
drive_channel = 0. ;
end
varsPerModelPerSeg(ca_index) = varsPerModelPerSeg(ca_index) + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / constsPerModelAllSeg(taur_index))))*(- ( drive_channel + ( ( constsPerModelAllSeg(cainf_index) ) ) / constsPerModelAllSeg(taur_index) ) / ( ( ( ( - 1.0) ) ) / constsPerModelAllSeg(taur_index) ) - varsPerModelPerSeg(ca_index)) ;
varsAllModelPerSeg(cai_index) = varsPerModelPerSeg(ca_index) ;

