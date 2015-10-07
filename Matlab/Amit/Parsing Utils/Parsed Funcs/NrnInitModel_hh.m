function [constsPerModelPerSeg, constsPerModelAllSeg, varsPerModelPerSeg, varsPerModelAllSeg] = NrnInitModel_hh (constsAllModelAllSeg, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
constsPerModelPerSeg = zeros(64, 4);
constsPerModelAllSeg = zeros(1, 0);
varsPerModelPerSeg = zeros(64, 5);
varsPerModelAllSeg = zeros(1, 6);
constsPerModelPerSeg(:, gnabar_index) = 0.120000;
constsPerModelPerSeg(:, gkbar_index) = 0.036000;
constsPerModelPerSeg(:, gl_index) = 0.000300;
constsPerModelPerSeg(:, el_index) = -54.300000;
for ind=1:nSegs
if (hasThisModel(ind))
[varsPerModelPerSeg(ind, : ), varsPerModelAllSeg] = initial(varsPerModelPerSeg(ind, : ), varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, vs(ind));
end
end
function [varsPerModelPerSeg, varsPerModelAllSeg] = initial(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
[varsPerModelPerSeg, varsPerModelAllSeg] = hh_rates(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v);
varsPerModelPerSeg(m_index) = varsPerModelAllSeg(minf_index);
varsPerModelPerSeg(h_index) = varsPerModelAllSeg(hinf_index);
varsPerModelPerSeg(n_index) = varsPerModelAllSeg(ninf_index);

