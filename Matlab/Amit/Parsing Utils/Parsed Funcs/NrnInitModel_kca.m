function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_kca (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_kca;
Def_ConstsPerModelAllSegs_kca;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_kca;
Def_VarsPerModelAllSegs_kca;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(64, 1);
constsPerModelAllSeg = zeros(1, 7);
varsPerModelPerSeg = zeros(64, 4);
varsPerModelAllSeg = zeros(1, 1);
constsPerModelPerSeg(:, gbar_index) = 10   		;
constsPerModelAllSeg(caix_index) = 1	;
constsPerModelAllSeg(Ra_index)   = 0.01			;
constsPerModelAllSeg(Rb_index)   = 0.02			;
constsPerModelAllSeg(temp_index) = 23			;
constsPerModelAllSeg(q10_index)  = 2.3			;
constsPerModelAllSeg(vmin_index) = -120	;
constsPerModelAllSeg(vmax_index) = 100	;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_kca;
Def_ConstsPerModelAllSegs_kca;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_kca;
Def_VarsPerModelAllSegs_kca;
Def_VarsAllModelsPerSeg;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kca_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,varsAllModelPerSeg(cai_index));
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(ninf_index);

