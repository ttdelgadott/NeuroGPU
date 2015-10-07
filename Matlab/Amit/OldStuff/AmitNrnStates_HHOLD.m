function [varsForModelForSeg, varsForModelAllSegs] = AmitNrnStates_HH (dt, v, varsForModelForSeg,...
    varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs)
Def_ConstsPerModelPerSeg_HH;
Def_VarsPerModelPerSeg_HH;
Def_VarsPerModelAllSegs_HH;
Def_ConstsAllModelsAllSegs;

%[varsForModelForSeg, varsForModelAllSegs] = hh_rates(v, varsForModelForSeg, varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs);
[minf hinf ninf mtau htau ntau]=Amit_rates_HH(v);

m = varsForModelForSeg(m_index);
h = varsForModelForSeg(h_index);
n = varsForModelForSeg(n_index);
% minf = varsForModelAllSegs(minf_index);
% mtau = varsForModelAllSegs(mtau_index);
% hinf = varsForModelAllSegs(hinf_index);
% htau = varsForModelAllSegs(htau_index);
% ninf = varsForModelAllSegs(ninf_index);
% ntau = varsForModelAllSegs(ntau_index);

% m_d=(minf-m)/mtau;        /QWERTY - useless?
% h_d=(hinf-h)/htau;
% n_d=(ninf-n)/ntau;

m = m + (1.0 - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
h = h + (1.0 - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
n = n + (1.0 - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;

varsForModelForSeg(m_index) = m;
varsForModelForSeg(h_index) = h;
varsForModelForSeg(n_index) = n;     
% global NT;                %QWERTY-delete
% global StimNeuronStates;
% varsForModelForSeg(n_index) = StimNeuronStates(NT+1,11);