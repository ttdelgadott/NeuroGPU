function [hasThisModel vars_HH varsForModelAllSegs consts_HH isElectrodeCurrent] = ...
    AmitInitModel_HH(hasThisModel, vars_HH, varsForModelAllSegs, consts_HH, constsAllModelAllSegs, Vs, isElectrodeCurrent, nSegs)
global HH_INDEX;
AmitModelVarsIndicesDef_HH;
AmitModelConstsIndicesDef_HH;

%QWERTY - originally was in Neuron in hh.c in nrn_alloc - to check if it's
%best to unify it with InitModel (since no real allocation is done here)
%QWERTY - to verify the enumeration is correct!
isElectrodeCurrent = 0;
consts_HH(gnabar_index) = 0.12;
%consts_HH(gnabar_index) = 0;     %QWERTY - Cancels out Na_HH practically.
consts_HH(gkbar_index) = 0.036;
%consts_HH(gkbar_index) = 0;      %QWERTY - Cancels out K_HH practically.
consts_HH(gl_index) = 0.0003;
consts_HH(el_index) = -54.3;

%initModel of HH
for segInd=2:3
    [minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    vars_HH(segInd, m_index)=minf;
    vars_HH(segInd, h_index)=hinf;
    vars_HH(segInd, n_index)=ninf;
end;

for segInd=5:33
    [minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    vars_HH(segInd, m_index)=minf;
    vars_HH(segInd, h_index)=hinf;
    vars_HH(segInd, n_index)=ninf;
end;

for segInd=35:63
    [minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    vars_HH(segInd, m_index)=minf;
    vars_HH(segInd, h_index)=hinf;
    vars_HH(segInd, n_index)=ninf;
end;

for segInd=2:3
    hasThisModel(segInd) = 1;
end;

for segInd=5:33
    hasThisModel(segInd) = 1;
end;

for segInd=35:63
    hasThisModel(segInd) = 1;
end;

