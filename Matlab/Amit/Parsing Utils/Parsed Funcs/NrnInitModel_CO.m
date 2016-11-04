function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_CO (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_CO;
Def_ConstsPerModelAllSegs_CO;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_CO;
Def_VarsPerModelAllSegs_CO;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(64, 5);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(64, 3);
varsPerModelAllSeg = zeros(1, 0);
constsPerModelPerSeg(:, gbar_index) = 1000     ;
constsPerModelPerSeg(:, a12_index) = 0.995050492	;
constsPerModelPerSeg(:, a21_index) = 7.617215488	;
constsPerModelPerSeg(:, z12_index) = 0.015702762	;
constsPerModelPerSeg(:, z21_index) = 0.054372320	;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_CO;
Def_ConstsPerModelAllSegs_CO;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_CO;
Def_VarsPerModelAllSegs_CO;
Def_VarsAllModelsPerSeg;
SOLVE states STEADYSTATE sparse

