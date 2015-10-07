function namesMat = parseProcedureOrFunction(lines, suffix, isFunc, namesMat)
def_generalMatlabStr;
def_generalNmodlStr;
def_fileTypeSuffix;
def_namesMatIndices;

if (isFunc)
    name = getBlockName(lines ,FUNCTION_MOD_STR);
else
    name = getBlockName(lines ,PROCEDURE_MOD_STR);
end

newFuncName = [suffix '_' name];
FNOut= [newFuncName MATLAB_SUFFIX];

[~, cols]=size(namesMat);
i = cols+1;
namesMat{FILE_NAME_IND, i} = FNOut;
namesMat{ORIGIN_FUNC_NAME_IND, i} = name;
if (isFunc)
    namesMat{IS_FUNC_IND, i} = TRUE_STR;
else
    namesMat{IS_FUNC_IND, i} = FALSE_STR;
end

lines = deleteUselessLines(lines);
lines = parseFirstLineOfFuncOrProc(lines, suffix, isFunc, name);
lines = parseControlFlow(lines, 1, 1, numel(lines), numel(lines{numel(lines)}));
lines = parseBuiltInFunctions(lines);
lines = addSemicolon(lines, newFuncName);

lines(2:end) = parseAllTypesVariables(lines(2:end), suffix);
%delete curly brackets
lines=regexprep(lines,'{|}','')';
%delete leading spaces and empty lines
lines = identLines(lines);


fid=fopen(FNOut,'w');
fprintf(fid,'%s\n',lines{1});
fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_PER_SEG suffix ';']);
fprintf(fid,'%s\n',[DEF_CONSTS_PER_MODEL_ALL_SEGS suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_PER_SEG suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_PER_MODEL_ALL_SEGS suffix ';']);
fprintf(fid,'%s\n',[DEF_VARS_ALL_MODELS_PER_SEG ';']);
fprintf(fid,'%s\n',[DEF_CONSTS_ALL_MODELS_ALL_SEGS ';']);
for i=2:numel(lines)
    fprintf(fid,'%s\n',lines{i});
end
fprintf(fid,'\n');
fclose(fid);


