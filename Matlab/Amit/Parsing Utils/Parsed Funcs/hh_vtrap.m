function [vtrap] = hh_vtrap(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, x,y)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
if (abs(x/y) < 1e-6)
vtrap = y*(1 - x/y/2);
else
vtrap = x/(exp(x/y) - 1);
end

