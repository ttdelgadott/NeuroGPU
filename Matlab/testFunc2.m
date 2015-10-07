
clearvars -except 'HocBaseFromOpt' stim params currOptRunStr OutFN initParams paramSet copyToFileFlg;
fclose all
clc;
NeuroGPUInit;
cd([BaseP 'Matlab']);
% HocFN=[BaseP 'Neuron\printCell\Amit\printCellBinaryK64 - 4.hoc'];
FN_Topo=fullfile(BaseP, 'Neuron','printCell','Amit','output','64T.csv');
FN_TopoF=fullfile(BaseP, 'Neuron','printCell','Amit','output','Fmatrix.csv');
FN_TopoPP=fullfile(BaseP, 'Neuron','printCell','Amit','output','64PP.csv');
FN_TopoMDL=fullfile(BaseP, 'Neuron','printCell','Amit','output','64MDL.csv');
FN_TopoList=fullfile(BaseP, 'Neuron','printCell','Amit','output','64TL.csv');
FN_Table=fullfile(BaseP, 'Neuron','printCell','Amit','output','Mat.dat');

if(filesep=='\')
    FN_Topo=strrep(FN_Topo,'\','/');
    FN_TopoF=strrep(FN_TopoF,'\','/');
    FN_TopoPP=strrep(FN_TopoPP,'\','/');
    FN_TopoMDL=strrep(FN_TopoMDL,'\','/');
    FN_TopoList=strrep(FN_TopoList,'\','/');
end
%%
% HocBaseFN='C:\SVN\Neuron\printCell\Amit\printCellBinaryK64Base.hoc';
% HocBaseFN=[BaseP 'Neuron\Mainen\test3\runModel.hoc'];
% HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','knacaonly','knacatrials.hoc');
% HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','knaonly','knatrials3.hoc');
% HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','knaonly','knatrialsbug.hoc');
%HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','mainen','mainenSimple.hoc');
%HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','mainen','caonly.hoc');
%HocBaseFN=fullfile(BaseP, 'Neuron','Mainen','runModel.hoc');
if(exist('HocBaseFromOpt','var'))
  HocBaseFN =  HocBaseFromOpt;
end
%HocBaseFN=fullfile(BaseP, 'Neuron','Mainen','FullTest','runNoStimWithPas.hoc');


%HocBaseFN=fullfile(BaseP, 'Neuron','printCell','Amit','topTest.hoc');
%HocBaseFN=fullfile(OptP, 'Neuron','NewModel','runModel.hoc');
FNWithTopo=AddTopologyToHoc(HocBaseFN,FN_Topo,FN_TopoF,FN_TopoPP,FN_TopoMDL,FN_TopoList);
[HocP, HocN, Ext]=fileparts(FNWithTopo);
cd(HocP);
RunHoc(FNWithTopo);
cd([BaseP 'Matlab']);
%%
global Neuron
[Neuron Sim Stim] = ReadKForkTopology2(FN_Topo);
%%
cd(fullfile(BaseP,'Matlab','Amit','Parsing Utils','Parsed Funcs'));
% parseHocFile (HocFN);      %QWERTY
ParseHocFile2(HocBaseFN, FN_Topo, FN_TopoMDL, FN_TopoPP)
cd([BaseP 'Matlab']);
fclose all
disp('Finished parsing.');