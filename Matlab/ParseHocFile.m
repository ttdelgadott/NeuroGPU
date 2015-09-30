% FN='Axon.hoc';
% FN='..\Neuron\printCell\Amit\printCellBinaryK64 - 3.hoc';
fid = fopen(FN);
tline = fgetl(fid);
Lines=cell(0);
while ischar(tline)
    Lines{end+1}=tline;
    tline = fgetl(fid);
end
fclose(fid);
%%
LL=regexp(Lines,'\s*insert\s*(\S+).*','tokens');
Tmp=cat(1,LL{:});
AvailableMechanisms=unique(cat(1,Tmp{:}));
IC=sum(cellNumel(regexp(Lines,'IClamp')));
if(IC>0)
    AvailableMechanisms{end+1}='stim';
end
%%
% AvailableMechanisms={'hh', 'stim', 'na','ks'};
NUM_OF_MODELS = numel(AvailableMechanisms);

Prefixes={'Def_ConstsPerModelPerSeg_','Def_VarsPerModelPerSeg_','Def_VarsPerModelAllSegs_'};
clear Tmp
for i=1:numel(Prefixes)
    for j=1:NUM_OF_MODELS
        Tmp(i,j)=numRowsInFile(['.\Amit\Parsing Utils\Parsed Funcs\' Prefixes{i} AvailableMechanisms{j} '.m']);
    end
end

MAX_NUM_CONSTS_PER_MODEL= max(Tmp(1,:));
%MAX_NUM_CONSTS_PER_SEG = 20;
MAX_NUM_CONSTS_GLOBAL = 3;
MAX_NUM_VARS_PER_MODEL_PER_SEG = max(Tmp(2,:));
MAX_NUM_VARS_PER_MODEL_ALL_SEGS = max(Tmp(3,:));
%MAX_NUM_VARS_ALL_MODELS_PER_SEG = 20;
%%
%constant independently of pre-process
ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};
%%
%depend of pre-process
for i=1:numel(AvailableMechanisms)
    ModelsFuncsNames(i,:) = strcat(ModelsFuncsNames(i,:), AvailableMechanisms{i});
end