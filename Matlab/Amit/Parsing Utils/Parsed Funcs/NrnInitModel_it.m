function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_it (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(192, 1);
constsPerModelAllSeg = zeros(1, 18);
varsPerModelPerSeg = zeros(192, 7);
varsPerModelAllSeg = zeros(1, 0);
constsPerModelPerSeg(:, gbar_index) = 0.0008 	;
constsPerModelAllSeg(vshift_index) = 0			;
constsPerModelAllSeg(cao_index)  = 2.5		        ;
constsPerModelAllSeg(vmin_index) = -120	;
constsPerModelAllSeg(vmax_index) = 100	;
constsPerModelAllSeg(v12m_index)=50         	;
constsPerModelAllSeg(v12h_index)=78         	;
constsPerModelAllSeg(vwm_index) =7.4         	;
constsPerModelAllSeg(vwh_index)=5.0         	;
constsPerModelAllSeg(am_index)=3         	;
constsPerModelAllSeg(ah_index)=85         	;
constsPerModelAllSeg(vm1_index)=25         	;
constsPerModelAllSeg(vm2_index)=100         	;
constsPerModelAllSeg(vh1_index)=46         	;
constsPerModelAllSeg(vh2_index)=405         	;
constsPerModelAllSeg(wm1_index)=20         	;
constsPerModelAllSeg(wm2_index)=15         	;
constsPerModelAllSeg(wh1_index)=4         	;
constsPerModelAllSeg(wh2_index)=50         	;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = it_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v+constsPerModelAllSeg(vshift_index));
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(minf_index);
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(hinf_index);

