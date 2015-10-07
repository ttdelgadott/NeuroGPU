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
endLetter = endLetter - closeBlockStr;
newLines = newLines(1:endLine);
newLines{endLine} = newLines{endLine}(1:endLetter);

% for i=1:numel(newLines)
%     open = strfind(newLines(i), '{');
%     close = strfind(newLines(i), '}');
%     j = 1;
%     k = 1;
%     while ( (j<=numel(open{1})) || (k<=numel(close{1}))   )
%         %if the next bracket is an open one: '{'
%         if (((j<=numel(open{1})) && (k<=numel(close{1}) && (open{1}(j)<close{1}(k)))) ||...
%            (k>numel(close{1})))
%             unmatchedOpenBrackets = unmatchedOpenBrackets + 1;
%             j = j + 1;
%         %the next bracket is a closed one: '}'
%         else
%             unmatchedOpenBrackets = unmatchedOpenBrackets - 1;
%             k = k + 1;
%             
%             if (unmatchedOpenBrackets<=0)
%                 if (unmatchedOpenBrackets==0)
%                     %cut everything after the final close bracket
%                     newLines{i} = newLines{i}(1:close{1}(k-1));
%                     newLines = newLines(1:i);
%                     return;
%                 else    %unmatchedOpenBrackets<0  meaning that the first 
%                         %bracket is a closed one instead of an open one.
%                     throw(MException('NueronGPU:getBlock:badBrackets','Bad Brackets'));
%                 end;
%             end;
%         end;
%     end;
% end;

%reached the end of newLines and there are still open brackets unmatched
% throw(MException('NueronGPU:getBlock:badBrackets','Bad Brackets'));
