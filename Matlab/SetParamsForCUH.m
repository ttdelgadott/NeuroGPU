declareStr = '';
parmeterSetStr = '';
for currParam = 1:nParams
    currDeclare = sprintf('p%d_ ## VARILP ,',currParam-1);
    declareStr = strcat(declareStr,currDeclare);
    currParametrStr = sprintf('p%d_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + %d*SMemMat.NComps+SMemMat.SegToComp[PIdx_ ## VARILP] ];',currParam-1,currParam-1);
    parmeterSetStr = strcat(parmeterSetStr,currParametrStr);
end