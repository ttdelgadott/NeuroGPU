function [varsForModelForSeg, varsForModelAllSegs] = ks_rates(varsForModelForSeg, varsForModelAllSegs, constsForModelForSeg, constsAllModelsAllSegs, v )
Def_ConstsPerModelPerSeg_ks;
Def_VarsPerModelPerSeg_ks;
Def_VarsPerModelAllSegs_ks;
Def_ConstsAllModelsAllSegs;
qt=constsForModelForSeg(q10_index)^((constsAllModelsAllSegs(celsius_index)-22)/10);
varsForModelAllSegs(ninf_index) = 1/(1 + exp(-(v-constsForModelForSeg(vhalfn_index))/constsForModelForSeg(kn_index)));
varsForModelAllSegs(linf_index) = 1/(1 + exp(-(v-constsForModelForSeg(vhalfl_index))/constsForModelForSeg(kl_index)));
if (v<-50)
varsForModelAllSegs(taun_index) = (1.25+175.03*exp(v*0.026))/qt;
else
varsForModelAllSegs(taun_index) = (1.25+13*exp(-v*0.026))/qt;
end
varsForModelAllSegs(taul_index) = (360+(1010+24*(v+55))*exp(-((v+75)/48)^2))/qt;

