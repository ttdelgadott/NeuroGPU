% function [sumCurrents sumConductivity]=AmitNrnCurrent_HH(v, m, h, n, gnabar, gkbar, gl, el)
% ena=50;
% ek=-77;
% gl = 0.0003;
% gna=gnabar*m*m*m*h;
% ina=gna*(v-ena);
% gk=gkbar*n*n*n*n;
% ik=gk*(v-ek);
% il=gl*(v-el);
% sumCurrents= ina+ik+il;
% sumConductivity= gk+gna+gl;

function [sumCurrents sumConducts] = AmitNrnCurrent_HH (t, v, varsForThisModel,...
    varsForAllModels, constsForThisModel, constsForAllModels)

AmitModelConstsIndicesDef_HH;
AmitModelVarsIndicesDef_HH;
AmitCommonConstsIndicesDef;

%QWERTY - for now constsForThisModel is taken from the "PARAMETER" section 
%in the mod file. to check if it's sufficient for our purpose
gnabar = constsForThisModel(gnabar_index);
gkbar = constsForThisModel(gkbar_index);
gl = constsForThisModel(gl_index);
el = constsForThisModel(el_index);

ena = constsForAllModels(ena_index);
ek = constsForAllModels(ek_index);

m = varsForThisModel(m_index);
h = varsForThisModel(h_index);
n = varsForThisModel(n_index);

isElectrodeCurrent = 0;
gna=gnabar*m*m*m*h;
ina=gna*(v-ena);
gk=gkbar*n*n*n*n;
ik=gk*(v-ek);
il=gl*(v-el);

% varsForThisModel(gna_index) = gna;            QWERTY - need to be entered
% soon!
% varsForThisModel(gna_index) = gk;
sumConducts = gna + gk + gl;
sumCurrents = ina + ik + il;
if (isElectrodeCurrent)
    sumCurrents = -sumCurrents;
    sumConducts = -sumConducts;
end;


