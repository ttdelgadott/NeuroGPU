function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg] = NrnInitModel_stim (constsAllModelAllSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_stim;
Def_ConstsPerModelAllSegs_stim;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
constsPerModelPerSeg = zeros(64, 4);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(64, 1);
varsPerModelAllSeg = zeros(1, 0);

constsPerModelPerSeg(2, del_index) = 0.1;       %edited in
constsPerModelPerSeg(2, dur_index) = 0.5;
constsPerModelPerSeg(2, amp_index) = 120;
constsPerModelPerSeg(2, area_index) = pi * 500 * 100 / 2;

for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_stim;
Def_ConstsPerModelAllSegs_stim;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
varsPerModelPerSeg(i_index) = 0;

