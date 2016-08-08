function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_pas2 (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_pas2;
Def_ConstsPerModelAllSegs_pas2;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_pas2;
Def_VarsPerModelAllSegs_pas2;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(416, 2);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(416, 0);
varsPerModelAllSeg = zeros(1, 0);
constsPerModelPerSeg(:, g_index) = .001		;
constsPerModelPerSeg(:, e_index) = -70	;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_pas2;
Def_ConstsPerModelAllSegs_pas2;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_pas2;
Def_VarsPerModelAllSegs_pas2;
Def_VarsAllModelsPerSeg;

