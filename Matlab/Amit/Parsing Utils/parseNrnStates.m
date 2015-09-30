%DOCUMENTATION_REF_012D
function parseNrnStates(modLines, cLines, suffix)
%Function Name: parseNrnStates
%INPUT: cell arr representing mod file line, the model's suffix,
%OUTPUT: No output. parse the C file lines and generates the
%NrnStates_ function.

def_generalMatlabStr;
def_generalCStr;
def_generalNmodlStr;

%%
%get the states func name in the C code: (The word that follows the
%'DERIVATIVE' keyword in the mod file)
modLinesNoComments = deleteAllTypeComments(modLines, COMMENT_MOD_STR, ...
    OPEN_COMMENT_MOD_STR, CLOSE_COMMENT_MOD_STR);
%find the line Index of the first appearance of 'DERIVATIVE' in the modFile
lineIndOfDerivativeStr = find(~cellfun(@isempty,regexp(modLinesNoComments, 'DERIVATIVE')));
%get the states func name - this is the next string after the derivative
%string

%if no DERIVATIVE function the print an empty one
if (isempty(lineIndOfDerivativeStr))
    firstLine = ['function [' VARS_OUTPUT_STR '] = ' NRN_STATES_STR suffix ...
    ' (dt, v, ' VARS_INPUT_STR ')'];
    FNOut=[NRN_STATES_STR suffix '.m'];
    fid=fopen(FNOut,'w');
    fprintf(fid,'%s\n',firstLine);
    fprintf(fid,'\n');
    fclose(fid);
    return
end

lineIndOfFuncName = lineIndOfDerivativeStr;
funcName = regexp(modLinesNoComments{lineIndOfFuncName}, 'DERIVATIVE\s+(\w+)\s*', 'tokens', 'ignorecase');

while(isempty(funcName))
    lineIndOfFuncName = lineIndOfFuncName + 1;
    funcName = regexp(modLinesNoComments{lineIndOfFuncName}, '\s*(\w+)\s*', 'tokens');
end
funcNameStr = funcName{1};
%%
FNOut=[NRN_STATES_STR suffix '.m'];
fid=fopen(FNOut,'w');
firstLine = ['function [' VARS_OUTPUT_STR '] = ' NRN_STATES_STR suffix ...
    ' (dt, v, ' VARS_INPUT_STR ')'];

%get the state function from the c code
statesFuncIdentifier = ['static int ' char(funcNameStr) ' ('];
try
    cLines = getBlock(statesFuncIdentifier, cLines, OPEN_BLOCK_C_STR, CLOSE_BLOCK_C_STR);
catch exc
    %getBlock failed --> No states function found --> no calculation
    %this part shouldn't happen no more - check for states func is done
    %earlier.
    if (strcmp(exc.identifier, 'NueronGPU:getBlock:statementMissing'))
        %print an empty function
        fprintf(fid,'%s\n',firstLine);
        fprintf(fid,'\n');
        fclose(fid);
        return
    else
        rethrow(exc);
    end
end

cLines = parseBuiltInFunctions(cLines);
cLines = parseControlFlow(cLines, 1, 1, numel(cLines), numel(cLines{numel(cLines)}));

%delete everything prefacing the block.
cLines = deleteLinesUntilStr(cLines, OPEN_BLOCK_C_STR);

%QWERTY - CONTINUE HERE - FOR SOME REASON regexprep diagon the cell?!
cLines=regexprep(cLines,'return *(\w*);','')';
cLines=regexprep(cLines,'{|}','')';
cLines=regexprep(cLines,INPUT_VARS_C_STR , '');

cLines = parseAllTypesVariables(cLines, suffix);
cLines = deleteUselessCVars(cLines);

%delete leading spaces and empty cLines
cLines = identLines(cLines);

lines{1} = firstLine;
lines{2} = [DEF_CONSTS_PER_MODEL_PER_SEG suffix ';'];
lines{3} = [DEF_CONSTS_PER_MODEL_ALL_SEGS suffix ';'];
lines{4} = [DEF_VARS_PER_MODEL_PER_SEG suffix ';'];
lines{5} = [DEF_VARS_PER_MODEL_ALL_SEGS suffix ';'];
lines{6} = [DEF_VARS_ALL_MODELS_PER_SEG ';'];
lines{7} = [DEF_CONSTS_ALL_MODELS_ALL_SEGS ';'];
%if there are more than 1 row
if (size(cLines, 1)>1)
    %than the cell need to be transposed
    cLines = cLines.';
end
allLines = [lines cLines];

% % % % lines = [firstLine; [DEF_CONSTS_PER_MODEL_PER_SEG suffix ';'];...
% % % %     [DEF_CONSTS_PER_MODEL_ALL_SEGS suffix ';'];...
% % % %     [DEF_VARS_PER_MODEL_PER_SEG suffix ';'];...
% % % %     [DEF_VARS_PER_MODEL_ALL_SEGS suffix ';'];...
% % % %     [DEF_VARS_ALL_MODELS_PER_SEG ';'];...
% % % %     [DEF_CONSTS_ALL_MODELS_ALL_SEGS ';']; cLines];
for i=1:numel(allLines)
    fprintf(fid,'%s\n',allLines{i});
end

% % % fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_PER_SEG suffix ';']);
% % % fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_ALL_SEGS suffix ';']);
% % % fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_PER_SEG suffix ';']);
% % % fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_ALL_SEGS suffix ';']);
% % % fprintf(fid,'%s\n',[DEF_VARS_ALL_MODELS_PER_SEG ';']);
% % % fprintf(fid,'%s\n',[DEF_CONSTS_ALL_MODELS_ALL_SEGS ';']);
% % % for i=1:numel(cLines)
% % %     fprintf(fid,'%s\n',cLines{i});
% % % end

fprintf(fid,'\n');
fclose(fid);
