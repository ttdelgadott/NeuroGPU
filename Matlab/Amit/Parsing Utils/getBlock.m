function newLines = getBlock(statement, lines, openBlockStr, closeBlockStr)
%getBlock recieves a statement (string) and lines (a cell array of strings -
%each cell represent one line). and returns the lines starting from the
%statement to the end of the block following the statement.
newLines = lines;
foundStatement = false;
% unmatchedOpenBrackets = 0;

%find the start line of the block
for i=1:numel(newLines)
    statementLetterInd = strfind(newLines(i), statement);
    if isempty(statementLetterInd{1})
        continue;
    end;
    
    foundStatement = true;
    %cut everything before the statement
    newLines = newLines(i:end);
    newLines{1} =newLines{1}(statementLetterInd{1}:end); 
    break;
end;

if (~foundStatement)
    
    throw(MException('NueronGPU:getBlock:statementMissing','statement missing'));
end;

%find the end line of the block and return the newLines from start to end
[endLine, endLetter] = findEndOfBlock(newLines, 1, 1, openBlockStr, closeBlockStr);
endLetter = endLetter - numel(closeBlockStr);
newLines = newLines(1:endLine);
newLines{endLine} = newLines{endLine}(1:endLetter);

