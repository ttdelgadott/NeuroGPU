function [betn] = kv_betn(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v,zetan,pw,tq,qq,vhalfn,gmn)
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
zeta=constsPerModelAllSeg(zetan_index)+constsPerModelAllSeg(pw_index)/(1+exp((v-constsPerModelAllSeg(tq_index))/constsPerModelAllSeg(qq_index)));
betn = exp(1.e-3*zeta*constsPerModelAllSeg(gmn_index)*(v-constsPerModelAllSeg(vhalfn_index))*9.648e4/(8.315*(273.16+constsAllModelAllSeg(celsius_index)))) ;

