function [varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg] = NrnInitModel_ks (varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs, hasThisModel, vs, nSegs)
Def_ConstsPerModelPerSeg_ks;
Def_VarsPerModelPerSeg_ks;
Def_VarsPerModelAllSegs_ks;
Def_ConstsAllModelsAllSegs;
constsForModelForSeg(gkbar_index)=.08 ;
constsForModelForSeg(vhalfn_index)=-14   ;
constsForModelForSeg(vhalfl_index)=-54   ;
constsForModelForSeg(kn_index)=14.6   ;
constsForModelForSeg(kl_index)=-11   ;
constsForModelForSeg(q10_index)=2.3;
constsForModelForSeg(tmp_index)=13;
for ind=1:nSegs
if (hasThisModel(ind))
[varsForModelForSeg(ind, : ), varsForModelAllSegs] = initial(varsForModelForSeg(ind, : ), varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs, vs(ind));
end
end
function [varsForModelForSeg, varsForModelAllSegs] = initial(varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs, v)
Def_ConstsPerModelPerSeg_ks;
Def_VarsPerModelPerSeg_ks;
Def_VarsPerModelAllSegs_ks;
Def_ConstsAllModelsAllSegs;
[varsForModelForSeg, varsForModelAllSegs] = ks_rates(varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs,v);
varsForModelForSeg(n_index)=varsForModelAllSegs(ninf_index);
varsForModelForSeg(l_index)=varsForModelAllSegs(linf_index);

