NUM_OF_MODELS = 7;
NUM_OF_SEGS = 64;
MAX_NUM_CONSTS_PER_MODEL = 4;
MAX_NUM_CONSTS_GLOBAL = 3;
MAX_NUM_VARS_PER_MODEL_PER_SEG = 7;
MAX_NUM_VARS_PER_MODEL_ALL_SEGS = 1;

ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};
ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'ca');
ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'cad');
ModelsFuncsNames(3,:) = strcat(ModelsFuncsNames(3,:), 'kca');
ModelsFuncsNames(4,:) = strcat(ModelsFuncsNames(4,:), 'km');
ModelsFuncsNames(5,:) = strcat(ModelsFuncsNames(5,:), 'kv');
ModelsFuncsNames(6,:) = strcat(ModelsFuncsNames(6,:), 'na');
ModelsFuncsNames(7,:) = strcat(ModelsFuncsNames(7,:), 'stim');

hasModel = zeros (NUM_OF_SEGS, NUM_OF_MODELS);
for segInd = 2:2
    hasModel(segInd, [1  2  3  4  5  6]) = 1;
end
for segInd = 4:6
    hasModel(segInd, [1  2  3  4  6]) = 1;
end
for segInd = 8:8
    hasModel(segInd, [1  2  3  4  6]) = 1;
end
for segInd = 10:35
    hasModel(segInd, [1  2  3  4  6]) = 1;
end
for segInd = 37:37
    hasModel(segInd, [1  2  3  4  6]) = 1;
end
for segInd = 39:39
    hasModel(segInd, [5  6]) = 1;
end
for segInd = 41:41
    hasModel(segInd, [5  6]) = 1;
end
for segInd = 43:43
    hasModel(segInd, [6]) = 1;
end
for segInd = 45:45
    hasModel(segInd, [6]) = 1;
end
for segInd = 47:47
    hasModel(segInd, [6]) = 1;
end
for segInd = 49:49
    hasModel(segInd, [6]) = 1;
end
for segInd = 51:51
    hasModel(segInd, [6]) = 1;
end
for segInd = 53:53
    hasModel(segInd, [6]) = 1;
end
for segInd = 55:55
    hasModel(segInd, [6]) = 1;
end
for segInd = 57:57
    hasModel(segInd, [6]) = 1;
end
for segInd = 59:59
    hasModel(segInd, [6]) = 1;
end
for segInd = 61:61
    hasModel(segInd, [6]) = 1;
end
for segInd = 63:63
    hasModel(segInd, [6]) = 1;
end
hasModel([2],7)=1;

