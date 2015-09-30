function hasHH = getHHsegs(Neuron)
hasHH=[];
for i=1:numel(Neuron.NSegs)
    if(Neuron.BoolModel(i))
        hasHH(end+1:end+Neuron.NSegs(i)+1) = [0 ones(1,Neuron.NSegs(i))];
    else
        hasHH(end+1:end+Neuron.NSegs(i)+1) = [0 zeros(1,Neuron.NSegs(i))];
    end
end
hasHH(end+1)=0;
[ stam hasHH] = find(hasHH);
