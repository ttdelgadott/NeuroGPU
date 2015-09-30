%DOCUMENTATION_REF_011D
function parseNrnCurrent (cLines, suffix, isElectrodeCurrent, isPointProcess)
%Function Name: parseNrnCurrent
%INPUT: cell arr representing mod file line, the model's suffix,
%isElectrodeCurrent bool, isPointProcess bool.
%OUTPUT: No output. parse the C file lines and generates the
%NrnCurrent_ function.

def_generalCStr;
def_generalMatlabStr;
def_fileTypeSuffix;

firstLine = ['function [sumCurrents, sumConducts, ' VARS_OUTPUT_STR '] = NrnCurrent_' suffix ...
    ' (t, v, ' VARS_INPUT_STR ')'];

cLines = getBlock(NRN_CURRENT_IDENTIFIER_STR, cLines, OPEN_BLOCK_C_STR, CLOSE_BLOCK_C_STR);
cLines = removeAtTimeFunc(cLines);
cLines = parseBuiltInFunctions(cLines);
cLines = parseControlFlow(cLines, 1, 1, numel(cLines), numel(cLines{numel(cLines)}));

%delete everything prefacing the block.
cLines = deleteLinesUntilStr(cLines, OPEN_BLOCK_C_STR);

if (isElectrodeCurrent)
    cLines=regexprep(cLines,'_current *\+= *','sumCurrents = sumCurrents - ')';
else
    cLines=regexprep(cLines,'_current *\+= *','sumCurrents = sumCurrents + ')';
end 
cLines=regexprep(cLines,'_current *= *','sumCurrents = ')';
%remove return statements, '{', '}', double, v=_v;
cLines=regexprep(cLines,'return *(\w*);','')';
cLines=regexprep(cLines,'{|}|double|v *= *_v *;','')';

%duplicate and convert the cLines the calculate sumCurrrents to do so for
%sumConducts.
numOfcLines = numel(cLines);
for i=1:numOfcLines
    if (~isempty(strfind(cLines{i},'sumCurrents')))
        newLine = regexprep(cLines{i}, 'Currents', 'Conducts');
        newLine = regexprep(newLine, '(\+ *)(i)(\w*)', '$1g$3');
        cLines{end+1} = newLine;
    end;
end;
%if point process multiply in 100 and divide by area.
if (isPointProcess)
    cLines{end+1} = 'sumCurrents = sumCurrents*100/area;';
end

cLines = parseAllTypesVariables(cLines, suffix);
cLines = deleteUselessCVars(cLines);

%delete leading spaces and empty cLines
cLines = identLines(cLines);

FNOut=[NRN_CURRENT_STR suffix MATLAB_SUFFIX];
fid=fopen(FNOut,'w');
fprintf(fid,'%s\n',firstLine);
fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_PER_SEG suffix ';']);
fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_ALL_SEGS suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_PER_SEG suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_ALL_SEGS suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_ALL_MODELS_PER_SEG ';']);
fprintf(fid,'%s\n',[DEF_CONSTS_ALL_MODELS_ALL_SEGS ';']);
for i=1:numel(cLines)
    fprintf(fid,'%s\n',cLines{i});
end
fprintf(fid,'\n');
fclose(fid);

