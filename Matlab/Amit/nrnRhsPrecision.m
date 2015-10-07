%DOCUMENTATION_REF_005D
function [rhss dg constsAndVars] = nrnRhsPrecision (rhss, dg, t, Vs, hasModel,...
    constsAndVars, ModelsFuncsNames, nModels, nSegs)
%Function Name: initialize
%INPUT: right hand side values arr, diff conductance arr, t, v arr, has model arr,
%the vars/consts arrays of the models, Models Funcs names, num of models,
%num of segs
%OUTPUT: returns the rhss, dg and varsPerModelPerSeg arrays after
%doing the breakpointModel

global CURRENT_INDEX;

dg(1,:) = 0;

%%for each model
for modelInd=1:nModels
    %get the model's current function
    curFunc= str2func(ModelsFuncsNames{modelInd, CURRENT_INDEX});
    %for each segment
    for segInd=1:nSegs
        if hasModel(segInd, modelInd)
            
            [rhsForModel dgForThisModel constsAndVars.varsPerModelPerSeg{modelInd}(segInd, :)] =...
                nrnCurPrecision(t, Vs(segInd), constsAndVars.varsPerModelPerSeg{modelInd}(segInd, :),...
                constsAndVars.varsPerModelAllSeg{modelInd}, constsAndVars.constsPerModelPerSeg{modelInd}(segInd, :),...
                constsAndVars.constsPerModelAllSeg{modelInd}, constsAndVars.constsAllModelAllSeg, curFunc);
           
            rhss(segInd) = rhss(segInd)- rhsForModel;
            dg(segInd) = dg(segInd) + dgForThisModel;
        end
    end
end

