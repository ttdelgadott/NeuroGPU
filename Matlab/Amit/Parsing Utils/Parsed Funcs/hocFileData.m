NUM_OF_MODELS = 2;
NUM_OF_SEGS = 64;
MAX_NUM_CONSTS_PER_MODEL = 4;
MAX_NUM_CONSTS_GLOBAL = 3;
MAX_NUM_VARS_PER_MODEL_PER_SEG = 5;
MAX_NUM_VARS_PER_MODEL_ALL_SEGS = 6;

ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};
ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'hh2');
ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'stim');

hasModel = zeros (NUM_OF_SEGS, NUM_OF_MODELS);
for segInd = 2:2
    hasModel(segInd, [1]) = 1;
end
for segInd = 4:6
    hasModel(segInd, []) = 1;
end
for segInd = 8:8
    hasModel(segInd, []) = 1;
end
for segInd = 10:21
    hasModel(segInd, []) = 1;
end
for segInd = 23:23
    hasModel(segInd, []) = 1;
end
for segInd = 25:27
    hasModel(segInd, []) = 1;
end
for segInd = 29:29
    hasModel(segInd, []) = 1;
end
for segInd = 31:33
    hasModel(segInd, []) = 1;
end
for segInd = 35:37
    hasModel(segInd, []) = 1;
end
for segInd = 39:39
    hasModel(segInd, []) = 1;
end
for segInd = 41:43
    hasModel(segInd, []) = 1;
end
for segInd = 45:45
    hasModel(segInd, []) = 1;
end
for segInd = 47:49
    hasModel(segInd, []) = 1;
end
for segInd = 51:51
    hasModel(segInd, []) = 1;
end
for segInd = 53:55
    hasModel(segInd, []) = 1;
end
for segInd = 57:57
    hasModel(segInd, []) = 1;
end
for segInd = 59:61
    hasModel(segInd, []) = 1;
end
for segInd = 63:63
    hasModel(segInd, []) = 1;
end
hasModel([],2)=1;

