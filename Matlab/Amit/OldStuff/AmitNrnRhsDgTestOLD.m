function [rhss sumConductivity varsPerModelPerSeg] = AmitNrnRhsDgTest (rhss, sumConductivity, t, Vs, hasModel, varsPerModelPerSeg, varsForAllModelsPerSeg,...
    constsPerModel, constsForAllModelsPerSeg, ModelsFuncsNames, nModels, nSegs)

global CURRENT_INDEX;

sumConductivity(1,:) = 0;

%%for each model
for modelInd=1:nModels
    %get the model's current function
    curFunc= str2func(ModelsFuncsNames{modelInd, CURRENT_INDEX});
    %for each segment
    for segInd=1:nSegs
        if hasModel(segInd, modelInd)
            %QWERTY - is dg really neccessary??
            [rhsForModel dgForThisModel varsPerModelPerSeg(segInd, modelInd, :)] =...
                AmitNrnCurDgTest(t, Vs(segInd), varsPerModelPerSeg(segInd, modelInd, :),...
                varsForAllModelsPerSeg(segInd, :), constsPerModel(modelInd, :),...
                constsForAllModelsPerSeg(segInd, :), curFunc);
                %QWERTY - to be deleted later
               %[rhsForModel dg] = BreakpointModel(Vs(segInd),varsPerModelPerSeg(segInd,1,1), varsPerModelPerSeg(segInd,1,2), varsPerModelPerSeg(segInd,1,3), constsPerModelPerSeg(segInd,1,1), constsPerModelPerSeg(segInd,1,2), constsPerModelPerSeg(segInd,1,3), constsPerModelPerSeg(segInd,1,4));
            rhss(segInd) = rhss(segInd)- rhsForModel;
            sumConductivity(segInd) = sumConductivity(segInd) + dgForThisModel;
%         else
%             rhss(segInd)=0; %QWERTY - new...
        end
    end
end

