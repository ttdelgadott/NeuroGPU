function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_km (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_km;
Def_ConstsPerModelAllSegs_km;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_km;
Def_VarsPerModelAllSegs_km;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(64, 1);
constsPerModelAllSeg = zeros(1, 8);
varsPerModelPerSeg = zeros(64, 4);
varsPerModelAllSeg = zeros(1, 1);
constsPerModelPerSeg(:, gbar_index) = 10   		;
constsPerModelAllSeg(tha_index)  = -30			;
constsPerModelAllSeg(qa_index)   = 9			;
constsPerModelAllSeg(Ra_index)   = 0.001			;
constsPerModelAllSeg(Rb_index)   = 0.001			;
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
Def_ConstsPerModelPerSeg_km;
Def_ConstsPerModelAllSegs_km;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_km;
Def_VarsPerModelAllSegs_km;
Def_VarsAllModelsPerSeg;
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/(10 )) ;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = km_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v);
varsPerModelPerSeg(n_index) = varsPerModelPerSeg(ninf_index);

