function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = ca_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vm )
Def_ConstsPerModelPerSeg_ca;
Def_ConstsPerModelAllSegs_ca;
Def_VarsPerModelPerSeg_ca;
Def_VarsPerModelAllSegs_ca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/(10 ));
a = 0.209*ca_efun(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-(27+vm)/3.8);
b = 0.94*exp((-75-vm)/17);
varsPerModelPerSeg(mtau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(minf_index) = a/(a+b);
a = 0.000457*exp((-13-vm)/50);
b = 0.0065/(exp((-vm-15)/28) + 1);
varsPerModelPerSeg(htau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(hinf_index) = a/(a+b);

