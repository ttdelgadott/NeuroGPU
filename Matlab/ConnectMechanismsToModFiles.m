function ModMap=ConnectMechanismsToModFiles(hocFileName, ModMap)
%BaseP='C:\Users\Roy\Documents\NeuroGPU2_2\';
%BaseP = 'C:\Users\rben.KECK-CENTER\Documents\neurogpu2\';
hocPath=fileparts(hocFileName);
D=dir([hocPath filesep '*.mod']);
D=D(~strcmp({D.name},'branching.mod'));
ModMap=struct();
for i=1:numel(D)
    Lines=getLines([hocPath filesep D(i).name]);
    SLine=Lines(strhas(Lines,'SUFFIX') | strhas(Lines,'POINT_PROCESS'));
    S=regexp(SLine,' ','split');
    ModMap.(S{1}{end})=[hocPath filesep D(i).name(1:end-4)];
end
if isfield(ModMap,'pas')
    ModMap.pas=ModMap.pas2;
end
%ModMap.esps=[BaseP 'Neuron/Mainen/passivex'];