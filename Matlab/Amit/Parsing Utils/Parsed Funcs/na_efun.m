function [efun] = na_efun(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, z)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_ConstsAllModelsAllSegs;
if (abs(z) < 1e-6)
efun = 1 - z/2;
else
efun = z/(exp(z) - 1);
end

