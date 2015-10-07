function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = na_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vm)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
a = na_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,vm,constsPerModelAllSeg(tha_index),constsPerModelAllSeg(Ra_index),constsPerModelAllSeg(qa_index));
b = na_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-vm,-constsPerModelAllSeg(tha_index),constsPerModelAllSeg(Rb_index),constsPerModelAllSeg(qa_index));
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/10);
varsPerModelPerSeg(mtau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(minf_index) = a/(a+b);
a = na_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,vm,constsPerModelAllSeg(thi1_index),constsPerModelAllSeg(Rd_index),constsPerModelAllSeg(qi_index));
b = na_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-vm,-constsPerModelAllSeg(thi2_index),constsPerModelAllSeg(Rg_index),constsPerModelAllSeg(qi_index));
varsPerModelPerSeg(htau_index) = 1/varsPerModelAllSeg(tadj_index)/(a+b);
varsPerModelPerSeg(hinf_index) = 1/(1+exp((vm-constsPerModelAllSeg(thinf_index))/constsPerModelAllSeg(qinf_index)));

