%AmitNrnJacob
function D = AmitNrnJacob (D, hasModel, varsPerModelPerSeg, varsForAllModelsPerSeg,...
    constsPerModelPerSeg, constsForAllModelsPerSeg, ModelsFuncsNames,...
    isElectrodeCurrent, nModels, nSegs)

global JACOB_INDEX;

for modInd = 1:nModels
    getDgFunc= str2func(ModelsFuncsNames{modInd, JACOB_INDEX});
    for segInd = 1:nSegs
        if hasModel(segInd, modInd)
            dg = getDgFunc(varsPerModelPerSeg(segInd, modInd, :));
            if (isElectrodeCurrent(modInd))
                D(segInd) = D(segInd)- dg;
            else
                D(segInd) = D(segInd)+ dg;
            end;
        end;
    end;
end;