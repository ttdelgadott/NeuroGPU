function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = km_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v )
Def_ConstsPerModelPerSeg_km;
Def_ConstsPerModelAllSegs_km;
Def_VarsPerModelPerSeg_km;
Def_VarsPerModelAllSegs_km;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
a = constsPerModelAllSeg(Ra_index) * constsPerModelAllSeg(qa_index) * km_efun(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-(v - constsPerModelAllSeg(tha_index))/constsPerModelAllSeg(qa_index));
b = constsPerModelAllSeg(Rb_index) * constsPerModelAllSeg(qa_index) * km_efun(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,(v - constsPerModelAllSeg(tha_index))/constsPerModelAllSeg(qa_index));
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/10);
varsPerModelPerSeg(ntau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(ninf_index) = a/(a+b);

