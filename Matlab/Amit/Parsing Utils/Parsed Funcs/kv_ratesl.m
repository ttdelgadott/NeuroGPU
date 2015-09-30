function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kv_ratesl(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v )
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
qt=constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index)-24)/10);
a =  kv_alpl(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v,constsPerModelAllSeg(zetal_index),constsPerModelAllSeg(vhalfl_index));
varsPerModelPerSeg(linf_index) = 1/(1+ a);
varsPerModelPerSeg(taul_index) = kv_betl(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v,constsPerModelAllSeg(zetal_index),constsPerModelAllSeg(gml_index),constsPerModelAllSeg(vhalfl_index))/(constsPerModelAllSeg(qtl_index)*constsPerModelAllSeg(a0l_index)*(1+a));

