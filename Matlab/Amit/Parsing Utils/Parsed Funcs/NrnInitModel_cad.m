function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_cad (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_cad;
Def_ConstsPerModelAllSegs_cad;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_cad;
Def_VarsPerModelAllSegs_cad;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(416, 0);
constsPerModelAllSeg = zeros(1, 3);
varsPerModelPerSeg = zeros(416, 1);
varsPerModelAllSeg = zeros(1, 0);
constsPerModelAllSeg(depth_index)	= .1			;
constsPerModelAllSeg(taur_index)	= 200			;
constsPerModelAllSeg(cainf_index)	= 100e-6;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_cad;
Def_ConstsPerModelAllSegs_cad;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_cad;
Def_VarsPerModelAllSegs_cad;
Def_VarsAllModelsPerSeg;
varsPerModelPerSeg(ca_index) = constsPerModelAllSeg(cainf_index);
varsAllModelPerSeg(cai_index) = varsPerModelPerSeg(ca_index);

