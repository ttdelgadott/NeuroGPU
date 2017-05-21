 NeuroGPUInitGitHub;
FN=['../UrapNeuron\Markov2st\Volts\orig_step_soma.dat'];
ntimestep=3168;
stimSize =1;
model = 'Markov2st';
[NV,err] =nrn_mread(FN,inf);
NeuronsVs = reshape(NV,ntimestep,stimSize);
ntimestep=3168;
figure (234)
plot(NeuronsVs);

stimSize =1;
psize = 1;
fidVHotP = fopen('../Data/VHotP.dat');
NVHotP = fread(fidVHotP, 1, 'int');
psize = NVHotP/(stimSize*ntimestep);
VHotP = fread(fidVHotP, NVHotP, FTYPESTR);
data = reshape(VHotP,[psize ntimestep stimSize]);
currData = squeeze(data(1,:,:))';
VoltsFolder = fullfile(OptP, 'UrapNeuron',model,'Volts');
TimeFN = [VoltsFolder,'/times.dat'];
times = cumsum(nrn_mread(TimeFN,inf)');
figure(24)
plot(times(2:end),NeuronsVs(2:end,:));
figure(235)
plot(times(2:end),currData(2:end,:))


StimFolder = fullfile(OptP, 'UrapNeuron',model,'Stims');
stim = 'Step.dat';
StimFN = [StimFolder,filesep,stim];
AllStim = nrn_mread(StimFN,ntimestep)';
