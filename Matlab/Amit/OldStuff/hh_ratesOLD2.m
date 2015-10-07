function [varsForModelPerSeg, varsForModelAllSegs] = hh_rates(v, varsForModelPerSeg, varsForModelAllSegs, constsForModelPerSeg, constsForModelAllSegs, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
q10 = 3^((celsius - 6.3)/10);
alpha = .1 * vtrap(-(v+40),10);
beta =  4 * exp(-(v+65)/18);
sum = alpha + beta;
VarsForModelAllSegs(mtau_index) = 1/(q10*sum);
VarsForModelAllSegs(minf_index) = alpha/sum;
alpha = .07 * exp(-(v+65)/20);
beta = 1 / (exp(-(v+35)/10) + 1);
sum = alpha + beta;
VarsForModelAllSegs(htau_index) = 1/(q10*sum);
VarsForModelAllSegs(hinf_index) = alpha/sum;
alpha = .01*vtrap(-(v+55),10) ;
beta = .125*exp(-(v+65)/80);
sum = alpha + beta;
VarsForModelAllSegs(ntau_index) = 1/(q10*sum);
VarsForModelAllSegs(ninf_index) = alpha/sum;

