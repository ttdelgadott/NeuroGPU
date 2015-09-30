function [Comp Seg] = ReadRecordingSite(fid,Neuron)
Comp={};
if(ischar(fid))
    fid=fopen(fid);
end
tline = fgetl(fid);
tline = fgetl(fid);
ind=1;
while (ischar(tline))
    Comp{ind} = tline;
    compInd = getCompIndex(Neuron.Types,tline);
    Seg(ind) = ceil((Neuron.SegStart(compInd) + Neuron.SegEnd(compInd))/2);
    ind = ind+1;
    tline = fgetl(fid);
end
fclose(fid);

