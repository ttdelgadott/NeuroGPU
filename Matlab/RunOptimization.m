
HocBaseFromOpt=fullfile(BaseP, 'Neuron','Mainen','FullTest','runModel.hoc');
testFunc2;
pause(5);
NMODLtoC_Main;
StimFN = '../Data/Step.dat';
TimeFN = '../Data/StimTimes.dat';
StimOut = '../Data/StimF.dat';
AddParamToHocForOpt;
AdjustStim;