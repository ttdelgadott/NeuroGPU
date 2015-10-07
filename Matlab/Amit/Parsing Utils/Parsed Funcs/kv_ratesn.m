function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kv_ratesn(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v )
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
qt=constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index)-24)/10);
a = kv_alpn(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v,constsPerModelAllSeg(zetan_index),constsPerModelAllSeg(pw_index),constsPerModelAllSeg(tq_index),constsPerModelAllSeg(qq_index),constsPerModelAllSeg(vhalfn_index));
varsPerModelPerSeg(ninf_index) = 1/(1 + a);
varsPerModelPerSeg(taun_index) =kv_betn(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v,constsPerModelAllSeg(zetan_index),constsPerModelAllSeg(pw_index),constsPerModelAllSeg(tq_index),constsPerModelAllSeg(qq_index),constsPerModelAllSeg(vhalfn_index),constsPerModelAllSeg(gmn_index))/(qt*constsPerModelAllSeg(a0n_index)*(1+a));

