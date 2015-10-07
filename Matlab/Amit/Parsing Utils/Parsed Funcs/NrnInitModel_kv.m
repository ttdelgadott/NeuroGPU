function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_kv (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(416, 1);
constsPerModelAllSeg = zeros(1, 8);
varsPerModelPerSeg = zeros(416, 4);
varsPerModelAllSeg = zeros(1, 1);
constsPerModelPerSeg(:, gbar_index) = 5   		;
constsPerModelAllSeg(tha_index)  = 25			;
constsPerModelAllSeg(qa_index)   = 9			;
constsPerModelAllSeg(Ra_index)   = 0.02			;
constsPerModelAllSeg(Rb_index)   = 0.002			;
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
Def_ConstsPerModelPerSeg_kv;
Def_ConstsPerModelAllSegs_kv;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
Def_VarsAllModelsPerSeg;
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/(10 )) ;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = kv_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v);
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(ninf_index);

