%DOCUMENTATION_REF_013D
function parseFunctionsAndProcedures(modLines, suffix)
%Function Name: parseFunctionsAndProcedures
%INPUT: cell arr representing mod file line, the model's suffix,
%OUTPUT: No output. parse the C file lines and generates the
%all the user-defined functions from the mod file.

def_generalNmodlStr;
def_generalMatlabStr;

modLines = deleteAllTypeComments(modLines, COMMENT_MOD_STR, ...
    OPEN_COMMENT_MOD_STR, CLOSE_COMMENT_MOD_STR);
    

%get the indices of all the funcs/procs start/end modLines
i=1;
procsCounter = 1;
funcsCounter = 1;
while (i<=numel(modLines))
   if (~isempty(regexp(modLines{i},PROCEDURE_MOD_STR, 'ONCE')))
        procStartLine(procsCounter) = i;
        [endLine endLetter] = findEndOfBlock(modLines, i, 1,...
            OPEN_BLOCK_MOD_STR, CLOSE_BLOCK_MOD_STR);
        procEndLine(procsCounter) = endLine;
        i = endLine + 1;
        procsCounter = procsCounter + 1;
   elseif (~isempty(regexp(modLines{i},FUNCTION_MOD_STR, 'ONCE')))
        funcStartLine(funcsCounter) = i;
        [endLine endLetter] = findEndOfBlock(modLines, i, 1,...
            OPEN_BLOCK_MOD_STR, CLOSE_BLOCK_MOD_STR);
        funcEndLine(funcsCounter) = endLine;
        i = endLine+1;
        funcsCounter = funcsCounter + 1;
   else
        i = i + 1;
   end
end

numOfProcs = procsCounter - 1;
numOfFuncs = funcsCounter - 1;

%funcsNamesMat is a matrix containing all the new names of the functions/
%procedures in MATLAB and the old funcion names in the mod file. it is used
%to later parse all the old function calls in all of the
%functions/procedures( nrn_current, nrn_states, nrn_initmodel as well) to
%the new names.
funcsNamesMat = [];

for i=1:numOfProcs
   funcsNamesMat = parseProcedureOrFunction...
       (modLines(procStartLine(i):procEndLine(i)), suffix, false, funcsNamesMat);
end

for i=1:numOfFuncs                                            
   funcsNamesMat = parseProcedureOrFunction...
       (modLines(funcStartLine(i):funcEndLine(i)), suffix, true, funcsNamesMat);
end

%DOCUMENTATION_REF_014C 
parseFunctionCalls(funcsNamesMat, suffix);




