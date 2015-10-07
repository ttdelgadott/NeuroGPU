%DOCUMENTATION_REF_007D
function [sumCurrents dg varsPerModelPerSeg varsPerModelAllSeg varsAllModelPerSeg]=nrnCur(t, v,...
    varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg,...
    constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg, curFunc)
%Function Name: nrnCur
%INPUT: t, v, the vars/consts models arrays and nrn_current Function 
%OUTPUT: returns the rhss, dg and varsPerModelPerSeg arrays after
%doing the breakpointModel

unchangedVarsPerModelPerSeg = varsPerModelPerSeg;
unchangedVarsPerModelAllSeg = varsPerModelAllSeg;
unchangedVarsAllModelPerSeg = varsAllModelPerSeg;

[sumCurrents ,~, varsPerModelPerSeg, varsPerModelAllSeg, varsAllModelPerSeg] = curFunc (t, v, varsPerModelPerSeg, varsPerModelAllSeg,...
    varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg);
[sumCurrentsAfterDv , ~, ~, ~, ~]= curFunc (t, v+0.001, unchangedVarsPerModelPerSeg, unchangedVarsPerModelAllSeg,...
    unchangedVarsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg); 
dg = (sumCurrentsAfterDv - sumCurrents)/0.001;

