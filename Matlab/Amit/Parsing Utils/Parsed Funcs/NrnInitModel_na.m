function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_na (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(416, 1);
constsPerModelAllSeg = zeros(1, 16);
varsPerModelPerSeg = zeros(416, 7);
varsPerModelAllSeg = zeros(1, 1);
constsPerModelPerSeg(:, gbar_index) = 1000   		;
constsPerModelAllSeg(vshift_index) = -10			;
constsPerModelAllSeg(tha_index)  = -35			;
constsPerModelAllSeg(qa_index)   = 9			;
constsPerModelAllSeg(Ra_index)   = 0.182			;
constsPerModelAllSeg(Rb_index)   = 0.124			;
constsPerModelAllSeg(thi1_index)  = -50			;
constsPerModelAllSeg(thi2_index)  = -75			;
constsPerModelAllSeg(qi_index)   = 5		        ;
constsPerModelAllSeg(thinf_index)  = -65			;
constsPerModelAllSeg(qinf_index)  = 6.2			;
constsPerModelAllSeg(Rg_index)   = 0.0091			;
constsPerModelAllSeg(Rd_index)   = 0.024			;
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
Def_ConstsPerModelPerSeg_na;
Def_ConstsPerModelAllSegs_na;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;
Def_VarsAllModelsPerSeg;
varsPerModelAllSeg(tadj_index) = constsPerModelAllSeg(q10_index)^((constsAllModelAllSeg(celsius_index) - constsPerModelAllSeg(temp_index))/10) ;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = na_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v+constsPerModelAllSeg(vshift_index));
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(minf_index);
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(hinf_index);

