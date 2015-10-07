function [Adj,Diams,Lengths,Type,Parent,NSeg] = ReadFromNeuron()
[Type Parent] = ReadTopology();
fid = fopen('../Neuron/printCell/Output/nakedSoma.csv');
tline = fgetl(fid);
%outFile.printf("%d,%d,%f,%f\n",i,nseg,currDiam,L)
ind =1;
while ischar(tline)
    out = sscanf(tline,'%d,%d,%f,%f\n');
    NSeg(ind)=out(2);
    if NSeg(ind)>1
        disp(['there are ' str2num(NSeg(ind)) ' segments in the compartment']);
    end
    Diams{ind} = out(3);
    Lengths{ind} = out(4);
    ind = ind+1;
    tline = fgetl(fid);
end
[Parent,Type,Diams,Lengths,NSeg] = turnAroundMatForNeuron(Parent,Type,Diams,Lengths,NSeg);
for i=1:numel(Parent)
    Adj{i}=find(Parent==i);
end

