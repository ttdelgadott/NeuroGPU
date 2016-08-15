function [vtrap] = hh2_vtrap(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, x,y)
Def_ConstsPerModelPerSeg_hh2;
Def_ConstsPerModelAllSegs_hh2;
Def_VarsPerModelPerSeg_hh2;
Def_VarsPerModelAllSegs_hh2;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
if (abs(x/y) < 1e-6)
vtrap = y*(1 - x/y/2);
else
vtrap = x/(exp(x/y) - 1);
end

