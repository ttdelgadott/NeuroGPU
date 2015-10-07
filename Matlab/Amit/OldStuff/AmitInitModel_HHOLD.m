function [hasThisModel varsForModelPerSeg varsForModelAllSegs constsForModelAllSegs isElectrodeCurrent] = ...
    AmitInitModel_HH(hasThisModel, varsForModelPerSeg, varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs, Vs, isElectrodeCurrent, nSegs)
global HH_INDEX;
Def_ConstsPerModelPerSeg_HH;
Def_VarsPerModelPerSeg_HH;
Def_VarsPerModelAllSegs_HH;
Def_ConstsAllModelsAllSegs;

%QWERTY - originally was in Neuron in hh.c in nrn_alloc - to check if it's
%best to unify it with InitModel (since no real allocation is done here)
%QWERTY - to verify the enumeration is correct!
isElectrodeCurrent = 0;
%constsForModelAllSegs(gnabar_index) = 0.12;
constsForModelAllSegs(gnabar_index) = 0;     %QWERTY - Cancels out Na_HH practically.
%constsForModelAllSegs(gkbar_index) = 0.036;
constsForModelAllSegs(gkbar_index) = 0;      %QWERTY - Cancels out K_HH practically.
constsForModelAllSegs(gl_index) = 0.0003;
constsForModelAllSegs(el_index) = -54.3;

          
%initModel of HH
for segInd=2:3
    [varsForModelPerSeg(segInd,:), varsForModelAllSegs] = hh_rates(varsForModelPerSeg(segInd,:), varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs, Vs(segInd));
    %[minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    varsForModelPerSeg(segInd, m_index)=varsForModelAllSegs(minf_index);
    varsForModelPerSeg(segInd, h_index)=varsForModelAllSegs(hinf_index);
    varsForModelPerSeg(segInd, n_index)=varsForModelAllSegs(ninf_index);
end;

for segInd=5:33
    [varsForModelPerSeg(segInd,:), varsForModelAllSegs] = hh_rates(varsForModelPerSeg(segInd,:), varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs, Vs(segInd));
    %[minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    varsForModelPerSeg(segInd, m_index)=varsForModelAllSegs(minf_index);
    varsForModelPerSeg(segInd, h_index)=varsForModelAllSegs(hinf_index);
    varsForModelPerSeg(segInd, n_index)=varsForModelAllSegs(ninf_index);
end;

for segInd=35:63
    [varsForModelPerSeg(segInd,:), varsForModelAllSegs] = hh_rates(varsForModelPerSeg(segInd,:), varsForModelAllSegs, constsForModelAllSegs, constsAllModelsAllSegs, Vs(segInd));
    %[minf hinf ninf mtau htau ntau]=Amit_rates_HH(Vs(segInd));
    varsForModelPerSeg(segInd, m_index)=varsForModelAllSegs(minf_index);
    varsForModelPerSeg(segInd, h_index)=varsForModelAllSegs(hinf_index);
    varsForModelPerSeg(segInd, n_index)=varsForModelAllSegs(ninf_index);
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

