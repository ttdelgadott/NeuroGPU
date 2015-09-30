%parseAllTypesVariables
function lines = parseAllTypesVariables(lines, suffix)
def_fileTypeSuffix;
def_generalMatlabStr;

fileName = [DEF_CONSTS_PER_MODEL_PER_SEG suffix MATLAB_SUFFIX];
variableType = CONSTS_PER_MODEL_PER_SEG_STR;
parseVariables;
fileName = [DEF_CONSTS_PER_MODEL_ALL_SEGS suffix MATLAB_SUFFIX];
variableType = CONSTS_PER_MODEL_ALL_SEG_STR;
parseVariables;
fileName = [DEF_VARS_PER_MODEL_PER_SEG suffix MATLAB_SUFFIX];
variableType = VARS_PER_MODEL_PER_SEG_STR;
parseVariables;
fileName = [DEF_VARS_PER_MODEL_ALL_SEGS suffix MATLAB_SUFFIX];
variableType = VARS_PER_MODEL_ALL_SEG_STR;
parseVariables;
fileName = [DEF_VARS_ALL_MODELS_PER_SEG MATLAB_SUFFIX];
variableType = VARS_ALL_MODEL_PER_SEG_STR;
parseVariables;
fileName = [DEF_CONSTS_ALL_MODELS_ALL_SEGS MATLAB_SUFFIX];
variableType = CONSTS_ALL_MODEL_ALL_SEG_STR;
parseVariables;