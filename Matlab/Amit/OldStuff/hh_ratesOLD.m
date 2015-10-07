function [varsForModelForSeg, varsForModelAllSegs] = hh_rates(v, varsForModelForSeg, varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
q10 = 3^((constsAllModelsAllSegs(celsius_index) - 6.3)/10);
alpha = .1 * hh_vtrap(-(v+40),10);
beta =  4 * exp(-(v+65)/18);
sum = alpha + beta;
varsForModelAllSegs(mtau_index) = 1/(q10*sum);
varsForModelAllSegs(minf_index) = alpha/sum;
alpha = .07 * exp(-(v+65)/20);
beta = 1 / (exp(-(v+35)/10) + 1);
sum = alpha + beta;
varsForModelAllSegs(htau_index) = 1/(q10*sum);
varsForModelAllSegs(hinf_index) = alpha/sum;
alpha = .01*hh_vtrap(-(v+55),10) ;
beta = .125*exp(-(v+65)/80);
sum = alpha + beta;
varsForModelAllSegs(ntau_index) = 1/(q10*sum);
varsForModelAllSegs(ninf_index) = alpha/sum;

