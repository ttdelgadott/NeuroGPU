%DOCUMENTATION_REF_014D
function parseFunctionCalls (funcsNamesMat, suffix)
%Function Name: parseFunctionCalls
%INPUT: cell matrix representing the old and new functions names ,the
%model's suffix.
%OUTPUT: No output. parse the generated matlab functions to replace the old
%function name with the new one.
def_generalMatlabStr;
def_fileTypeSuffix;
def_namesMatIndices;

[~, numOfFuncs]=size(funcsNamesMat);
if (numOfFuncs==0)
    return;
end

basicFuncsNames = [];
basicFuncsIsCfileOrigin = zeros();
basicFuncsNames{1} = [NRN_CURRENT_STR suffix MATLAB_SUFFIX];
basicFuncsNames{2} = [NRN_STATES_STR suffix MATLAB_SUFFIX];
basicFuncsNames{3} = [NRN_INITMODEL_STR suffix MATLAB_SUFFIX];
basicFuncsIsCfileOrigin(1) = true;
basicFuncsIsCfileOrigin(2) = true;
basicFuncsIsCfileOrigin(3) = false;

%grouping together all the funcs names (basic and user defined)
allTypesFuncsFileNames = [funcsNamesMat(FILE_NAME_IND, :) basicFuncsNames];

for i=1:numel(funcsNamesMat(FILE_NAME_IND, :))
    fileName = funcsNamesMat{FILE_NAME_IND, i};
    parseFunctionCallsForFile (fileName, funcsNamesMat, false);
end

for i=1:numel(basicFuncsNames)
    fileName = basicFuncsNames{i};
    parseFunctionCallsForFile (fileName, funcsNamesMat, basicFuncsIsCfileOrigin(i));
end;


function parseFunctionCallsForFile (fileName, funcsNamesMat, isCfileOrigin)

def_generalMatlabStr;
def_fileTypeSuffix;
def_namesMatIndices;

lines = getLines(fileName);
[~, numOfFuncs]=size(funcsNamesMat);

for funcOrProcInd = 1:numOfFuncs
   %if file contains a recursive self call - NOT SUPPORTED FOR NOW 
   if strcmp(fileName, funcsNamesMat{FILE_NAME_IND, funcOrProcInd})
       continue
   end
   
   oldFuncName = funcsNamesMat{ORIGIN_FUNC_NAME_IND, funcOrProcInd};
   newFuncName = funcsNamesMat{FILE_NAME_IND, funcOrProcInd}(1:end-numel(MATLAB_SUFFIX));
   isFunc = strcmp(funcsNamesMat{IS_FUNC_IND, funcOrProcInd}, TRUE_STR);
   
   %prefix str is added only if the function is procedures, therefore in
   %the function call lines the output variables need to be recieved.
   %suffix str is added also to procedure calls since addSemiColon works
   %only on assiments.
   suffixStr = '';
   if (isFunc)
       prefixStr = '';
   else
       prefixStr = ['\[' VARS_OUTPUT_STR '\] = '];
       %not basic funcs are missing semicolons in all their procedures
       %calls.
       if (~isCfileOrigin)
           suffixStr = ';';
       end
   end;
   
   for lineInd = 1:numel(lines)
       %if this line contain a call for the func (recognized by the old func name
       if (~isempty(regexp(lines{lineInd}, ['\<' oldFuncName '\>'], 'ONCE')))
           %if the function call contains no input variables
           if (~isempty(regexp(lines{lineInd}, ['\<' oldFuncName ' *\( *\)'], 'ONCE')))
               %                                                                  '(' suffixStr ')*'  - this part needs some explnation:
               % since some of the procedurs are copied from C files and some form mod file, they might or might not have a
               % semicolon at the end of the statment - suffixStr make sure here that there is exactly one semicolon
                lines{lineInd} = regexprep(lines{k}, ['\<' oldFuncName ' *\( *\)'],...
                    [prefixStr newFuncName '\(' VARS_INPUT_STR ' \)' suffixStr]);
            %else (one or more input variables)
            else
                lines{lineInd} = regexprep(lines{lineInd}, ['\<' oldFuncName ' *\((.*)\)'],...
                    [prefixStr newFuncName '\(' VARS_INPUT_STR ',$1\)' suffixStr]);
           end
       end
   end %END OF FOR LOOP

end

fid=fopen(fileName,'w');
for j=1:numel(lines)
    fprintf(fid,'%s\n',lines{j});
end
fclose(fid);



