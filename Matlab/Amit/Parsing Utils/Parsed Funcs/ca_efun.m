function [efun] = ca_efun(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, z)
Def_ConstsPerModelPerSeg_ca;
Def_ConstsPerModelAllSegs_ca;
Def_VarsPerModelPerSeg_ca;
Def_VarsPerModelAllSegs_ca;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
if (abs(z) < 1e-4)
efun = 1 - z/2;
else
efun = z/(exp(z) - 1);
end

