clear variables
clc
close all

fidVHot = fopen('../Data/VHotC.dat');
fidTopo = fopen('../Neuron/printCell/Output/forkHHTopo.csv');
[Neuron Sim Stim] = ReadHHTopology(fidTopo);
fidFmatrix = '../Neuron/printCell/output/fmatrixHHFork.csv';
[Mats Traces] = readFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
Nx = length(OurMat);
TT=squeeze(Traces(:,1,3,1));

Traces=Traces(2:end,:,:,:);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
StimByItself=TT*0;
StimActiveTB=TT>=Stim.del & TT<=(Stim.del+Stim.dur);
StimActiveT=find(StimActiveTB);
StimByItself(StimActiveT(1))=100*Stim.amp/Stim.area;
StimByItself(StimActiveT(2:end))=100*Stim.amp/(Stim.area*sum(Neuron.NSegs)); % Probaly will not work with different diams, etc... - check Alon

NRHS=squeeze(Mats(:,5,:));

NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
icap=squeeze(Traces(:,:,3,16));
NsumCurrent = icap+NsumCurrent;
figure(83745);clf;
plot(TT(1:end-1),NRHS(4,1:end));
hold on;
plot(TT(1:end-1),NsumCurrent(:,1),'r');
figure(83746);clf;
StimNeeded = NRHS(4,1:end)-NsumCurrent(:,1)';
plot(StimNeeded);
figure(83747);clf;

plot(StimByItself);

