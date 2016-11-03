function [alltimes] = MeasureRunningTimesGPU()
cd(fileparts(which(mfilename)))
NeuroGPUInitGitHub;

model = Model;
HocBaseFromOpt=fullfile(OptP, 'URapNeuron',model,'runModel.hoc');
stim = 'stepone.dat';
addpath(genpath(BaseP));
[nrnpath bla1 bla2] = fileparts(HocBaseFromOpt);
params = nrn_mread([nrnpath,'\params\orig.dat'],inf);
%params = zeros(1,12);
nrn_mwrite([nrnpath,filesep,'opt_params.dat'],params);
paramSet = 'opt_params.dat'; 
if(nargin<4)
   copyToFileFlg =0;
end
%HocBaseFromOpt=fullfile(OptP, 'Neuron',model,'runModelForAnalyze.hoc');
%HocBaseFromOpt=fullfile(OptP, 'Neuron',model,'runModelPas.hoc');

testFunc2V2;
pause(2);
NMODLtoC_MainV3;
model = 'Markov2st';
slnFN = fullfile(BaseP,'VS',['NeuroGPULast7_5',Model],'NeuroGPU7_5.sln');
%slnFN = fullfile(BaseP,'VS','NeuroGPULast7_5Mainen','NeuroGPU7_5.sln');
%slnFN = fullfile(BaseP,'VS','NeuroGPULastLast','NeuroGPU6.sln');
 eval(['!msbuild /property:Configuration=Debug /p:Platform=x64 ',slnFN,]);
%model = 'NewModelCA';

ntimestep=3168;
stimSize =1;
StimFolder = fullfile(OptP, 'UrapNeuron',model,'Stims');
StimFN = [StimFolder,filesep,stim];
%StimFN = [StimFolder,filesep,'Step.dat'];
%VoltsFolder = fullfile(OptP, 'Neuron',model,'Volts','passive');
VoltsFolder = fullfile(OptP, 'UrapNeuron',model,'Volts');
TimeFN = [VoltsFolder,'/times.dat'];
StimOut =  fullfile(BaseP,'Data','StimF.dat');
%gpuDir = fullfile(BaseP,'VS','NeuroGPUStimCUDAHu','Release');
exeFile = fullfile(BaseP,'VS',['NeuroGPULast7_5',Model],'x64/Debug/NeuroGPU6.exe');
%exeFile = fullfile(BaseP,'VS','NeuroGPULastLast','x64/Debug/NeuroGPU6.exe');
gpuDir = fullfile(BaseP,'VS',['NeuroGPULast7_5',Model],'NeuroGPU6');
%gpuDir = fullfile(BaseP,'VS','NeuroGPULastLast','NeuroGPU6');
GpuOut = fullfile(BaseP,'Data','VHotP.dat');
%paramSet = 'opt_params.dat';

%paramSet = 'orig.dat';
StimFN = strrep(StimFN,'.mat','.dat')
stimSize = 1;
Nt = ntimestep;
AdjustStim;




pSizeSet = size(params,1);
%HocBaseFN = fullfile(OptP, 'Neuron',model,'runModelForAnalyze.hoc');
HocBaseFN = fullfile(OptP, 'UrapNeuron',model,'runModel.hoc');
cd([OptP '/Matlab']);
for jj = 0:1:14 
    HocBaseFromOpt=fullfile(OptP, 'URapNeuron',model,'runModel.hoc');

    [nrnpath bla1 bla2] = fileparts(HocBaseFromOpt);
    params = nrn_mread([nrnpath,'\params\orig.dat'],inf);
    params = repmat(params,2^jj,1);
    pSizeSet = size(params,1);
    ProcAddParamToHocForOpt(AllParametersNonGlobalC,HocBaseFN,BaseP,availableMechanisms,NeuronSC,Reversals,CompNames,CompMechnisms,GGlobals,NGlobals,Neuron,FTYPESTR,pSizeSet,paramSet)
%AddParamToHocForOpt;
    NeuroGPUInitGitHub;
%exeFile = fullfile(BaseP,'VS','NeuroGPULast7_5Mainen','x64/Debug/NeuroGPU6.exe');
    gpuDir = fullfile(BaseP,'VS',['NeuroGPULast7_5',Model],'NeuroGPU6');
    exeFile = fullfile(BaseP,'VS',['NeuroGPULast7_5',Model],'x64/Debug/NeuroGPU6.exe');
%gpuDir = fullfile(BaseP,'VS','NeuroGPULastLast','NeuroGPU6');
%
    pause(1);
    cd(gpuDir);
    copyfile(exeFile,gpuDir);
     jj
    system('NeuroGPU6.exe');
   
    runtimes = fullfile(OptP,'Data','RunTimes.dat');
    fid = fopen(runtimes);
    fread(fid,1,'short');
    curr_time = fread(fid,1,'float')
    alltimes(jj+1) = curr_time;
end
%eval(['!"NeuroGPU6.exe" '])
if(copyToFileFlg)
    psize = size(params,1);
    ParamName = paramSet(1:end-4);
    outFileName = [VoltsFolder,'/',ParamName,'_',stim];
    copyfile(GpuOut,outFileName);
end
% data = nrn_mread(GpuOut,inf);
% data = reshape(data,[psize ntimestep stimSize]);