function [varsPerModelPerSeg, varsPerModelAllSeg] = hh_rates(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, v)
Def_ConstsPerModelPerSeg_hh;
Def_ConstsPerModelAllSegs_hh;
Def_VarsPerModelPerSeg_hh;
Def_VarsPerModelAllSegs_hh;
Def_ConstsAllModelsAllSegs;
q10 = 3^((constsAllModelAllSeg(celsius_index) - 6.3)/10);
alpha = .1 * hh_vtrap(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-(v+40),10);
beta =  4 * exp(-(v+65)/18);
sum = alpha + beta;
varsPerModelAllSeg(mtau_index) = 1/(q10*sum);
varsPerModelAllSeg(minf_index) = alpha/sum;
alpha = .07 * exp(-(v+65)/20);
beta = 1 / (exp(-(v+35)/10) + 1);
sum = alpha + beta;
varsPerModelAllSeg(htau_index) = 1/(q10*sum);
varsPerModelAllSeg(hinf_index) = alpha/sum;
alpha = .01*hh_vtrap(varsPerModelPerSeg, varsPerModelAllSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,-(v+55),10) ;
beta = .125*exp(-(v+65)/80);
sum = alpha + beta;
varsPerModelAllSeg(ntau_index) = 1/(q10*sum);
varsPerModelAllSeg(ninf_index) = alpha/sum;

