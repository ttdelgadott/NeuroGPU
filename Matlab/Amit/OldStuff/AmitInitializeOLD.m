function [hasModel, varsPerModelPerSeg, varsPerModelAllSegs, constsPerModelAllSegs,...
    constsAllModelAllSegs, Vs, rhss, D, parentIndexes, isElectrodeCurrent] = ...
    AmitInitialize(Neuron, ModelsFuncNames, varsPerModelPerSeg, varsPerModelAllSegs,...
        Sim, constsPerModelAllSegs, constsAllModelAllSegs, hasModel, nSegs, nModels)
%runs the all the initModel functions of all the models in all the
%segments. 
%first declaration of the indices. QWERTY-make sure this is the right place
global INIT_INDEX;

%%intialize voltage/right hand side/diagonal in each segment
Vs=ones(1,nSegs)*Sim.Vs(1);
rhss = zeros(1,nSegs);
D = zeros(1,nSegs);
isElectrodeCurrent = zeros (1, nModels);

%intialize parent-segment-index of each segment.
parentIndexes = zeros(1, nSegs);
for segInd=2:nSegs
    parentIndexes(segInd) = getParentInd(Neuron,segInd);
end

constsAllModelAllSegs = AmitDefineConstsAllModelsAllSegs(constsAllModelAllSegs);

%%for each model initialization
for modelInd=1:nModels
    %get the initFunc of the model by the Matrix of the funcs names
    %QWERTY binding of function in runtime but constant for each seg - to
    %check if this is OK in cude
    initFunc= str2func(ModelsFuncNames{modelInd, INIT_INDEX});
    [hasModel(:, modelInd) varsPerModelPerSeg(:, modelInd,:) varsPerModelAllSegs(modelInd,:)...
        constsPerModelAllSegs(modelInd, :) isElectrodeCurrent(modelInd)] = initFunc(hasModel(:, modelInd),...
        varsPerModelPerSeg(:, modelInd,:), varsPerModelAllSegs(modelInd,:),...
        constsPerModelAllSegs(modelInd, :),constsAllModelAllSegs, Vs, isElectrodeCurrent(modelInd), nSegs);
end

%QWERTY - for parallelism - what is better - model loop nested or segment 
%loop nested? or doesn't matter?