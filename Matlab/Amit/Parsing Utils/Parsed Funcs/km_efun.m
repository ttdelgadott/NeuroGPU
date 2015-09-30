function [efun] = km_efun(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, z)
Def_ConstsPerModelPerSeg_km;
Def_ConstsPerModelAllSegs_km;
Def_VarsPerModelPerSeg_km;
Def_VarsPerModelAllSegs_km;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
if (abs(z) < 1e-4)
efun = 1 - z/2;
else
efun = z/(exp(z) - 1);
end

