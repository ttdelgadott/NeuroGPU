function [sumCurrents sumConducts] = AmitNrnCurrent_MainenNa (t, v, varsForThisModel,...
    varsForAllModels, constsForThisModel, constsForAllModels)

AmitModelConstsIndicesDef_MainenNa;
AmitModelVarsIndicesDef_MainenNa;
AmitCommonConstsIndicesDef;

gbar = constsForThisModel(gbar_index);

ena = constsForAllModels(ena_index);

tadj = varsForThisModel(tadj_index);
m = varsForThisModel(m_index);
h = varsForThisModel(h_index);


isElectrodeCurrent = 0;
gna = tadj*gbar*m*m*m*h;
ina = 1e-4 * gna * (v - ena);

sumConducts = gna;
sumCurrents = ina;
if (isElectrodeCurrent)
    sumCurrents = -sumCurrents;
    sumConducts = -sumConducts;
end;

