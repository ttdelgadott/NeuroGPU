% function [rhs dg]=AmitNrnCur(v, m, h, n, gnabar, gkbar, gl, el)
% 
% [sumCurrents sumConductivity]=AmitNrnCurrentHH(v, m, h, n, gnabar, gkbar, gl, el);
% [sumCurrentsPlusDv sumConductivityPlusDv]=AmitNrnCurrentHH(v+0.001, m, h, n, gnabar, gkbar, gl, el);
% dg = (sumCurrentsPlusDv - sumCurrents)/0.001;
% rhs=sumCurrents;

function [sumCurrents dg varsForThisModel]=AmitNrnCurDgTest(t, v, varsForThisModel, varsForAllModels,...
   constsForThisModel, constsForAllModels, curFunc)

% AmitModelVarsIndicesDef_HH;    %WRONG! should be general here...

[sumCurrents sumConducts] = curFunc (t, v, varsForThisModel, varsForAllModels,...
    constsForThisModel, constsForAllModels);
 [sumCurrentsAfterDv sumConducts2]= curFunc (t, v+0.001, varsForThisModel, varsForAllModels,...
    constsForThisModel, constsForAllModels);  
dg = (sumCurrentsAfterDv - sumCurrents)/0.001;