function hasHH = AmitGetHHsegs(Neuron)
hasHH=[];
for i=1:numel(Neuron.NSegs)
    hasHH(end+1:end+Neuron.NSegs(i)+1) = [0 ones(1,Neuron.NSegs(i))];
end
hasHH(end+1)=0;
[ ~, hasHH] = find(hasHH);