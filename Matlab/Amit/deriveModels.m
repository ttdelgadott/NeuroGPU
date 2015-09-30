%DOCUMENTATION_REF_006D
function [constsAndVars] = deriveModels (dt, Vs, hasModel, ...
    constsAndVars, ModelsFuncsNames, nModels, nSegs)
%Function Name: deriveModels
%INPUT: dt, Vs arr, hasModel arr, vars/consts models arrays, num of models,
%num of segs
%OUTPUT: returns the vars models array after the states function was done
%by each model.

global STATES_INDEX

for modelInd=1:nModels
    statesFunc= str2func(ModelsFuncsNames{modelInd, STATES_INDEX});
    for segInd=1:nSegs
        if hasModel(segInd, modelInd)
            [constsAndVars.varsPerModelPerSeg{modelInd}(segInd,:) constsAndVars.varsPerModelAllSeg{modelInd} ...
                constsAndVars.varsAllModelPerSeg(segInd, :)]= statesFunc(dt, Vs(segInd),...
                constsAndVars.varsPerModelPerSeg{modelInd}(segInd,:), constsAndVars.varsPerModelAllSeg{modelInd},...
                constsAndVars.varsAllModelPerSeg(segInd, :), constsAndVars.constsPerModelPerSeg{modelInd}(segInd,:),...
                constsAndVars.constsPerModelAllSeg{modelInd}, constsAndVars.constsAllModelAllSeg);
        end;
    end;
end;