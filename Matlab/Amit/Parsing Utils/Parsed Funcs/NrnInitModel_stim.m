function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_stim (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_stim;
Def_ConstsPerModelAllSegs_stim;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(192, 4);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(192, 1);
varsPerModelAllSeg = zeros(1, 0);
constsPerModelPerSeg(4, del_index) = 0;
constsPerModelPerSeg(4, dur_index) = 1000000000;
constsPerModelPerSeg(4, amp_index) = 0;
constsPerModelPerSeg(4, area_index) = 178.0522;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_stim;
Def_ConstsPerModelAllSegs_stim;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
Def_VarsAllModelsPerSeg;
varsPerModelPerSeg(i_index) = 0;

