function [Sim] = RunOnGPUFuncMultiParamsGitHub()
NeuroGPUInitGitHub;
model = Model;
HocBaseFromOpt=fullfile(OptP, 'UrapNeuron',model,'runModel.hoc');
stim = 'Step.dat';
addpath(genpath(BaseP));
[nrnpath bla1 bla2] = fileparts(HocBaseFromOpt);
params = nrn_mread([nrnpath,'\params\orig.dat'],inf);
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
slnFN = fullfile(BaseP,'VS','NeuroGPULast','NeuroGPU6.sln');
 eval(['!msbuild /property:Configuration=Debug /p:Platform=x64 ',slnFN,]);
%model = 'NewModelCA';
model = 'Mainen';
ntimestep=3168;
stimSize =7;
StimFolder = fullfile(OptP, 'UrapNeuron',model,'Stims');
StimFN = [StimFolder,filesep,stim];
%StimFN = [StimFolder,filesep,'Step.dat'];
%VoltsFolder = fullfile(OptP, 'Neuron',model,'Volts','passive');
VoltsFolder = fullfile(OptP, 'UrapNeuron',model,'Volts');
TimeFN = [VoltsFolder,'/times.dat'];
StimOut =  fullfile(BaseP,'Data','StimF.dat');
%gpuDir = fullfile(BaseP,'VS','NeuroGPUStimCUDAHu','Release');
exeFile = fullfile(BaseP,'VS','NeuroGPULast','x64/Debug/NeuroGPU6.exe');
gpuDir = fullfile(BaseP,'VS','NeuroGPULast','NeuroGPU6');
GpuOut = fullfile(BaseP,'Data','VHotP.dat');
%paramSet = 'opt_params.dat';

%paramSet = 'orig.dat';
StimFN = strrep(StimFN,'.mat','.dat')
stimSize = 7;
Nt = ntimestep;
AdjustStim;
pSizeSet = size(params,1);
%HocBaseFN = fullfile(OptP, 'Neuron',model,'runModelForAnalyze.hoc');
HocBaseFN = fullfile(OptP, 'UrapNeuron',model,'runModel.hoc');
cd([OptP '/Matlab']);
ProcAddParamToHocForOpt(AllParametersNonGlobalC,HocBaseFN,BaseP,availableMechanisms,NeuronSC,Reversals,CompNames,CompMechnisms,GGlobals,NGlobals,Neuron,FTYPESTR,pSizeSet,paramSet)
%AddParamToHocForOpt;

%
pause(1);
cd(gpuDir);
copyfile(exeFile,gpuDir);
system('NeuroGPU6.exe')
%eval(['!"NeuroGPU6.exe" '])
if(copyToFileFlg)
    psize = size(params,1);
    ParamName = paramSet(1:end-4);
    outFileName = [VoltsFolder,'/',ParamName,'_',stim];
    copyfile(GpuOut,outFileName);
end
% data = nrn_mread(GpuOut,inf);
% data = reshape(data,[psize ntimestep stimSize]);