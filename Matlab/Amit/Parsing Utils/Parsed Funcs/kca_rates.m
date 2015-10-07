function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kca_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, cai)
Def_ConstsPerModelPerSeg_kca;
Def_ConstsPerModelAllSegs_kca;
Def_VarsPerModelPerSeg_kca;
Def_VarsPerModelAllSegs_kca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
a = constsPerModelAllSeg(Ra_index) * varsAllModelPerSeg(cai_index)^constsPerModelAllSeg(caix_index);
b = constsPerModelAllSeg(Rb_index);
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/10);
varsPerModelPerSeg(ntau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(ninf_index) = a/(a+b);

