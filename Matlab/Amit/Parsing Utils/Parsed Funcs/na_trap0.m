function [trap0] = na_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v,th,a,q)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
if (abs((v-th)/q) > 1e-6)
trap0 = a * (v - th) / (1 - exp(-(v - th)/q));
else
trap0 = a * q;
end

