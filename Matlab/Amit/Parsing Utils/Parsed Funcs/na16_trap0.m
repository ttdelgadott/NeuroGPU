function [trap0] = na16_trap0(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v,th,a,q)
Def_ConstsPerModelPerSeg_na16;
Def_ConstsPerModelAllSegs_na16;
Def_VarsPerModelPerSeg_na16;
Def_VarsPerModelAllSegs_na16;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
if (abs((v-th)/q) > 1e-6)
trap0 = a * (v - th) / (1 - exp(-(v - th)/q));
else
trap0 = a * q;
end

