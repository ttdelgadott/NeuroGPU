function parseFunctionsAndProcedures(fileName)
PROCEDURE_STR = 'PROCEDURE';
FUNCTION_STR = 'FUNCTION';
OPEN_BLOCK_STR = '{';
CLOSE_BLOCK_STR = '}';

MODLFN=[fileName '.mod'];
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);


%get the indices of all the funcs/procs start/end lines
i=1;
procsCounter = 1;
funcsCounter = 1;
while (i<=numel(Lines))
   if (~isempty(regexp(Lines{i},PROCEDURE_STR)))
        procStartLine(procsCounter) = i;
        [endLine endLetter] = findEndOfBlock(Lines, i, 1,...
            OPEN_BLOCK_STR, CLOSE_BLOCK_STR);
        procEndLine(procsCounter) = endLine;
        i = endLine + 1;
        procsCounter = procsCounter + 1;
   elseif (~isempty(regexp(Lines{i},FUNCTION_STR)))
        funcStartLine(funcsCounter) = i;
        [endLine endLetter] = findEndOfBlock(Lines, i, 1,...
            OPEN_BLOCK_STR, CLOSE_BLOCK_STR);
        funcEndLine(funcsCounter) = endLine;
        i = endLine+1;
        funcsCounter = funcsCounter + 1;
   else
        i = i + 1;
   end
end
numOfProcs = procsCounter - 1;
numOfFuncs = funcsCounter - 1;

for i=1:numOfProcs
   parseProcedure (Lines(procStartLine(i):procEndLine(i)), fileName);
end

% for i=1:numOfFuncs                                            QWERTY
%    parseFunction (Lines(funcStartLine(i):funcEndLine(i)), fileName);
% end



