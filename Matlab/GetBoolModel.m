boolModel = [];
for i = 1:size(availableMechanisms,1)
    mechName = availableMechanisms{i};
    currBoolVec = zeros(1,NUM_OF_SEGS);
    for ind = 1:length(Neuron.NSegsMat)
        comp = CompTopologyMap(ind);
        currBool = ~isempty(find(strcmp(CompMechnisms{ind},mechName)>0, 1));
        currBoolVec(Neuron.SegStart(comp):Neuron.SegEnd(comp)-1)=currBool;
    end
    currBoolVec(1)=0;
    boolModel = [boolModel; currBoolVec];
end