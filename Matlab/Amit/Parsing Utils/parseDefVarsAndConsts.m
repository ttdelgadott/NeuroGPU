%DOCUMENTATION_REF_009D
function varsAndConstsNames = parseDefVarsAndConsts (modLines, suffix, isElectrodeCurrent)
%Function Name: parseDefVarsAndConsts
%INPUT: a cell array representing mod file lines, the model suffix, and if
%it is electrode current (bool)
%OUTPUT: no output. generates the Def_ files.

def_generalNmodlStr;
neuronBlockLines = getBlock(NEURON_BLOCK_STR, modLines,...
    OPEN_BLOCK_MOD_STR,  CLOSE_BLOCK_MOD_STR);
parameterBlockLines = getBlock(PARAMETER_BLOCK_STR, modLines,...
    OPEN_BLOCK_MOD_STR,  CLOSE_BLOCK_MOD_STR);
assignedBlockLines = getBlock(ASSIGNED_BLOCK_STR, modLines,...
    OPEN_BLOCK_MOD_STR,  CLOSE_BLOCK_MOD_STR);
try
    stateBlockLines = getBlock(STATE_BLOCK_STR, modLines,...
        OPEN_BLOCK_MOD_STR,  CLOSE_BLOCK_MOD_STR);
catch exc
    %if the exception is of the statment missing type than we can recover
    %since STATE block isn't mandatory.
    if (strcmp(exc.identifier, 'NueronGPU:getBlock:statementMissing'))
        stateBlockLines{1} = '';
    else
        rethrow(exc);
    end
end

parameterBlockLines = deleteFirstInstanceOfStr(parameterBlockLines, PARAMETER_BLOCK_STR);
assignedBlockLines = deleteFirstInstanceOfStr(assignedBlockLines, ASSIGNED_BLOCK_STR);

assignedVarsStr = getAssignedVarsStr (assignedBlockLines);
parameterVarsStr = getParameterVarsStr (parameterBlockLines);
[rangeVarsStr globalVarsStr] = getRangeGlobalVarsStr (neuronBlockLines);
stateVarsStr = getStateVarsStr (stateBlockLines);

%This how the consts SHOULD be defined
constsPerModelPerSegStr = intersect(rangeVarsStr, parameterVarsStr);
constsPerModelAllSegStr = setdiff(parameterVarsStr, constsPerModelPerSegStr);
%this was the original solution but somethimes globalVarsStr doesn't
%contain all the consts
%constsPerModelAllSegStr = intersect(globalVarsStr, parameterVarsStr);

%this is a temporary solution instead:
% constsPerModelAllSegStr = parameterVarsStr;
varsPerModelAllSegsStr = intersect(globalVarsStr, assignedVarsStr);
varsPerModelPerSegStr = union((intersect(rangeVarsStr, assignedVarsStr)), stateVarsStr);

%the area const (AREA_STR) probably shouldn't come here cause it's not
%directly derieved from the model being a an elctrode_current. to do - to
%find from where it comes from.
if (isElectrodeCurrent)  
    constsPerModelPerSegStr = [constsPerModelPerSegStr DEL_STR DUR_STR AMP_STR AREA_STR];
end

%saves all the vars and consts names in a struct to be used when
%initializing those vars/consts in nrnInitModel_model
varsAndConstsNames = struct();
varsAndConstsNames.constsPerModelPerSeg = constsPerModelPerSegStr;
varsAndConstsNames.constsPerModelAllSeg = constsPerModelAllSegStr;
varsAndConstsNames.varsPerModelPerSeg = varsPerModelPerSegStr;
varsAndConstsNames.varsPerModelAllSeg = varsPerModelAllSegsStr;


printAllDefFiles (constsPerModelPerSegStr, constsPerModelAllSegStr, varsPerModelAllSegsStr,...
    varsPerModelPerSegStr, suffix);

function printAllDefFiles (constsPerModelPerSegStr, constsPerModelAllSegStr,...
    varsPerModelAllSegsStr, varsPerModelPerSegStr, suffix)
def_generalMatlabStr;
printDefFile (constsPerModelPerSegStr, DEF_CONSTS_PER_MODEL_PER_SEG, suffix);
printDefFile (constsPerModelAllSegStr, DEF_CONSTS_PER_MODEL_ALL_SEGS, suffix);
printDefFile (varsPerModelAllSegsStr, DEF_VARS_PER_MODEL_ALL_SEGS, suffix);
printDefFile (varsPerModelPerSegStr, DEF_VARS_PER_MODEL_PER_SEG, suffix);

function printDefFile (varsStr, fileName, suffix)
def_fileTypeSuffix;
def_generalMatlabStr;
FNOut=[fileName suffix MATLAB_SUFFIX];
fid=fopen(FNOut,'w');
for i = 1:numel(varsStr)
   fprintf(fid,'%s%d%s\n',[varsStr{i} INDEX_SUFFIX ' = '], i, ';');
end
fprintf(fid,'\n');
fclose(fid);

function stateVarsStr = getStateVarsStr (stateBlockLines)
def_generalNmodlStr;
%delete min/max values in angle brackets.
stateBlockLines = regexprep(stateBlockLines, '<.*?>', '');
%delete units in round brackets
stateBlockLines = regexprep(stateBlockLines, '\(.*?\)', '');
stateVarsStr = [];
stateBlockLines = deleteFirstInstanceOfStr(stateBlockLines, STATE_BLOCK_STR);
for i = 1:numel(stateBlockLines)
    stateVarsStr = [stateVarsStr regexp(stateBlockLines{i}, '(\w+)', 'MATCH')];
end


function [rangeVarsStr globalVarsStr] = getRangeGlobalVarsStr (neuronBlockLines)
def_generalNmodlStr;
neuronBlockLines = deleteOneLineComments(neuronBlockLines, COMMENT_MOD_STR);
rangeVarsStr = [];
globalVarsStr = [];
rangeLines = cell(0);
globalLines = cell(0);

%get the RANGE/GLOBAL lines from the NEURON block
for i = 1:numel(neuronBlockLines)
    if (~isempty(regexp(neuronBlockLines{i}, RANGE_STR, 'ONCE')))
        rangeLines{end+1} = neuronBlockLines{i};
    elseif(~isempty(regexp(neuronBlockLines{i}, GLOBAL_STR, 'ONCE')))
        globalLines{end+1} = neuronBlockLines{i};
    end
end
%delete 'RANGE'/'GLOBAL' statements at the start of each line.
rangeLines = regexprep(rangeLines, RANGE_STR, '');
globalLines = regexprep(globalLines, GLOBAL_STR, '');

for i = 1:numel(rangeLines)
    rangeVarsStr = [rangeVarsStr regexp(rangeLines{i}, '(\w+)', 'MATCH')];
end
for i = 1:numel(globalLines)
    globalVarsStr = [globalVarsStr regexp(globalLines{i}, '(\w+)', 'MATCH')];
end

function parameterVarsStr = getParameterVarsStr (parameterBlockLines)
def_generalNmodlStr;
parameterVarsStr = [];
parameterBlockLines = deleteOneLineComments(parameterBlockLines, COMMENT_MOD_STR);
for i = 1:numel(parameterBlockLines)
    if (isempty(regexp(parameterBlockLines{i}, '\w+\s*=', 'ONCE')))
        parameterBlockLines{i} = '';
    else
        parameterBlockLines{i} = regexprep (parameterBlockLines{i}, '(\w+)\s*=.*', '$1');
    end
end
for i = 1:numel(parameterBlockLines)
    parameterVarsStr = [parameterVarsStr regexp(parameterBlockLines{i}, '(\w+)', 'MATCH')];
end

function assignedVarsStr = getAssignedVarsStr(assignedBlockLines)
def_generalNmodlStr;
assignedVarsStr = [];
assignedVarsStr = deleteOneLineComments(assignedVarsStr, COMMENT_MOD_STR);
for i = 1:numel(assignedBlockLines)
    assignedBlockLines{i} = regexprep (assignedBlockLines{i}, '\([^\(\)]*\)', '');
end

for i = 1:numel(assignedBlockLines)
    assignedVarsStr = [assignedVarsStr regexp(assignedBlockLines{i}, '(\w+)', 'MATCH')];
end