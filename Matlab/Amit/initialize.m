%DOCUMENTATION_REF_004D
function [constsAndVars, vs, rhss, D, parentIndexes] = ...
    initialize(Neuron, ModelsFuncNames, Sim, nSegs, nModels, hasModel)
%Function Name: initialize
%INPUT: the vars/consts arrays of the models, Neuron data, Models Funcs names
%array, simulation data, num of segs, num of models
%OUTPUT: intialize and return all the vars/consts arrays and also hasModel,
%vs, rhss, D, parentIndexes arrays.
    
%runs the all the initModel functions of all the models in all the
%segments. 
global INIT_INDEX;

%%intialize voltage/right hand side/diagonal in each segment
vs=ones(1,nSegs)*Sim.Vs(1);
rhss = zeros(1,nSegs);
D = zeros(1,nSegs);

%intialize parent-segment-index of each segment.
parentIndexes = zeros(1, nSegs);
for segInd=2:nSegs
    parentIndexes(segInd) = getParentInd(Neuron,segInd);
end

constsAllModelAllSeg1 = DefineConstsAllModelsAllSegs();
varsAllModelPerSeg1 = DefineVarsAllModelPerSeg(nSegs);

%%for each model initialization
% constsPerModelAllSegs - no gradients! (also different stims)
for modelInd=1:nModels
    %get the initFunc of the model by the Matrix of the funcs names
    initFunc= str2func(ModelsFuncNames{modelInd, INIT_INDEX});
    [constsPerModelPerSeg1{modelInd} ,constsPerModelAllSegs1{modelInd}, ...
        varsPerModelPerSeg1{modelInd}, varsPerModelAllSegs1{modelInd}, varsAllModelPerSeg1] = ...
        initFunc(constsAllModelAllSeg1, varsAllModelPerSeg1, hasModel(:, modelInd), vs, nSegs);
end

constsAndVars.constsPerModelPerSeg = constsPerModelPerSeg1;
constsAndVars.constsPerModelAllSeg = constsPerModelAllSegs1;
constsAndVars.constsAllModelAllSeg = constsAllModelAllSeg1;
constsAndVars.varsPerModelPerSeg = varsPerModelPerSeg1;
constsAndVars.varsPerModelAllSeg = varsPerModelAllSegs1;
constsAndVars.varsAllModelPerSeg = varsAllModelPerSeg1;
