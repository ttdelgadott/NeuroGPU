function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = NrnInitModel_hh2 (constsAllModelAllSeg, varsAllModelPerSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_hh2;
Def_ConstsPerModelAllSegs_hh2;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_hh2;
Def_VarsPerModelAllSegs_hh2;
Def_VarsAllModelsPerSeg;
constsPerModelPerSeg = zeros(64, 4);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(64, 5);
varsPerModelAllSeg = zeros(1, 6);
constsPerModelPerSeg(:, gnabar_index) = .12 	;
constsPerModelPerSeg(:, gkbar_index) = .036 	;
constsPerModelPerSeg(:, gl_index) = .0003 	;
constsPerModelPerSeg(:, el_index) = -54.3 ;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : )] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, varsAllModelPerSeg(ind, : ), constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_hh2;
Def_ConstsPerModelAllSegs_hh2;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_hh2;
Def_VarsPerModelAllSegs_hh2;
Def_VarsAllModelsPerSeg;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = hh2_rates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v);
varsPerModelPerSeg(m_index) = varsPerModelAllSeg(minf_index);
varsPerModelPerSeg(h_index) = varsPerModelAllSeg(hinf_index);
varsPerModelPerSeg(n_index) = varsPerModelAllSeg(ninf_index);

