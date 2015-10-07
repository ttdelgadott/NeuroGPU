close all
Nt = 6176;

Ntraces = 8;
toCompare = 6;
FNNeuron = '../Neuron/Mainen\FullTest\orig_step.dat';
FNC = '../Data/VHotC.dat';
FNP = '../Data/VHotP.dat';
NeuronVS = nrn_mread(FNNeuron,Ntraces*Nt);
timeFiles = '../Data/times.dat';
dts =  nrn_mread(timeFiles,Nt);
times = cumsum(dts);
fid = fopen(FNC);
NVHotC = fread(fid, 1, 'uint16');
VHotC = fread(fid, NVHotC, FTYPESTR);
fclose(fid);
fid = fopen(FNP);
NVHotP = fread(fid, 1, 'uint16');
NtP = NVHotP/Ntraces;
VHotP = fread(fid, NVHotP, FTYPESTR);
fclose(fid);
bigInds = find(abs(VHotC)>1000);
VHotC = reshape(VHotC,Nt,Ntraces);
VHotP = reshape(VHotP,NtP,Ntraces);
NeuronVS = reshape(NeuronVS,Nt,Ntraces);
figure(101);
currVhotP = VHotP(:,toCompare);
currVhotC = VHotC(:,toCompare);
currNeuronVS =NeuronVS(:,toCompare);
plot(times,currVhotC,'r');
hold on
plot(times,currNeuronVS,'b');
hold on
plot(times,currVhotP(1:length(times)),'black');
figure(102);
plot(NeuronVS);
figure(103);
plot(VHotC);
figure(104);
plot(VHotP);