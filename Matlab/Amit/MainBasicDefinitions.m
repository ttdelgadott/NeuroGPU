%QWERTY - adding new model - what to change.
%MainBasicDefinitions
%%DOCUMENTATION_REF_002D
%this part is written in pre-proccessing (calculted when translating the
%mod file to the MATLAB/Cuda file). for now it has constant values.
global HH_INDEX;
global STIM_INDEX;
global MAINENNA_INDEX;
global MAINENKV_INDEX;
HH_INDEX = 1;
STIM_INDEX = 4;
MAINENNA_INDEX = 2;
MAINENKV_INDEX = 3;

NUM_OF_MODELS = 4;                                   
MAX_NUM_CONSTS_PER_MODEL= 17;
%MAX_NUM_CONSTS_PER_SEG = 20;
MAX_NUM_CONSTS_GLOBAL = 3;
MAX_NUM_VARS_PER_MODEL_PER_SEG = 7;
MAX_NUM_VARS_PER_MODEL_ALL_SEGS = 6;
%MAX_NUM_VARS_ALL_MODELS_PER_SEG = 20;


%constant independently of pre-process
ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};

%depend of pre-process
ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'hh');
ModelsFuncsNames(4,:) = strcat(ModelsFuncsNames(4,:), 'stim');
ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'na');  
ModelsFuncsNames(3,:) = strcat(ModelsFuncsNames(3,:), 'kv');