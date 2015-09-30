function [sumCurrents sumConducts] = AmitNrnCurrent_MainenKv (t, v, varsForThisModel,...
    varsForAllModels, constsForThisModel, constsForAllModels)

AmitModelConstsIndicesDef_MainenKv;
AmitModelVarsIndicesDef_MainenKv;
AmitCommonConstsIndicesDef;

gbar = constsForThisModel(gbar_index);
ek = constsForAllModels(ek_index);

tadj = varsForThisModel(tadj_index);
n = varsForThisModel(n_index);


isElectrodeCurrent = 0;
gk = tadj*gbar*n;
ik = (1e-4) * gk * (v - ek);

sumConducts = gk;
sumCurrents = ik;
if (isElectrodeCurrent)
    sumCurrents = -sumCurrents;
    sumConducts = -sumConducts;
end;

