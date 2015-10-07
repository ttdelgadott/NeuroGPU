%DOCUMENTATION_REF_007D
function [sumCurrents dg varsPerModelPerSeg]=nrnCurPrecision(t, v, varsPerModelPerSeg, varsPerModelAllSeg,...
   constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, curFunc)
%Function Name: nrnCur
%INPUT: t, v, the vars/consts models arrays and nrn_current Function 
%OUTPUT: returns the rhss, dg and varsPerModelPerSeg arrays after
%doing the breakpointModel

[sumCurrents ,~] = curFunc (t, v, varsPerModelPerSeg, varsPerModelAllSeg,...
    constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg);
 [sumCurrentsAfterDv ,~]= curFunc (t, v+0.001, varsPerModelPerSeg, varsPerModelAllSeg,...
    constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg); 
dg = (vpa((sumCurrentsAfterDv - sumCurrents),32)/0.001);

