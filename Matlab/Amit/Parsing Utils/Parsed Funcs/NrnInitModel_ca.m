function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_ca (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_ca;
Def_ConstsPerModelAllSegs_ca;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_ca;
Def_VarsPerModelAllSegs_ca;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(64, 1);
constsPerModelAllSeg = zeros(1, 6);
varsPerModelPerSeg = zeros(64, 7);
varsPerModelAllSeg = zeros(1, 1);
constsPerModelPerSeg(:, gbar_index) = 0.1   		;
constsPerModelAllSeg(vshift_index) = 0			;
constsPerModelAllSeg(cao_index)  = 2.5		        ;
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
Def_ConstsPerModelPerSeg_ca;
Def_ConstsPerModelAllSegs_ca;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_ca;
Def_VarsPerModelAllSegs_ca;
Def_VarsAllModelsPerSeg;
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/(10 )) ;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = ca_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v+constsPerModelAllSeg(vshift_index));
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(minf_index);
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(hinf_index);

