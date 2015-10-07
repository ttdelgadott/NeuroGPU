
close all
Nt = 6176;
Ntraces = 8;
NSets = 120;
whatToPlot = 1:10:120;
%toCompare = 6;
FNNeuron = '../Neuron/Mainen\FullTest\orig_step.dat';
FNP = '../Data/VHotP.dat';
NeuronVS = nrn_mread(FNNeuron,Ntraces*Nt);
timeFiles = '../Data/times.dat';
dts =  nrn_mread(timeFiles,Nt);
times = cumsum(dts);
fid = fopen(FNP);
NVHotP = fread(fid, 1, 'uint32');
NtP = NVHotP/Ntraces;
VHotPAll = fread(fid, NVHotP, FTYPESTR);
fclose(fid);
VHotPAll = reshape(VHotPAll,Nt*Ntraces,NSets);
%bigInds = find(abs(VHotP)>1000);
for i = whatToPlot
    figure(1067 + i)
    VHotP = reshape(VHotPAll(:,i),Nt,Ntraces);
    plot(times,VHotP);
end
