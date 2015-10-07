function [endLine, endLetter] = findEndOfBlock (lines, startLine, startLetter, openBlockStr, closeBlockStr)
%find the end line of the block and return the lines from start to end
unmatchedOpenBrackets = 0;
open = strfind(lines{startLine}, openBlockStr);
open = open(open>=startLetter);
close = strfind(lines{startLine}, closeBlockStr);
close = close(close>=startLetter);
for i=startLine:(numel(lines))
    j = 1;
    k = 1;
    while ( (j<=numel(open)) || (k<=numel(close))   )
        %if the next bracket is an open one: '{'
        if (((j<=numel(open)) && (k<=numel(close) && (open(j)<close(k)))) ||...
           (k>numel(close)))
            unmatchedOpenBrackets = unmatchedOpenBrackets + 1;
            j = j + 1;
        %the next bracket is a closed one: '}'
        else
            unmatchedOpenBrackets = unmatchedOpenBrackets - 1;
            k = k + 1;
            
            if (unmatchedOpenBrackets<=0)
                if (unmatchedOpenBrackets==0)
                    endLine = i;
                    endLetter = close(k-1) + numel(closeBlockStr);
                    return;
                else    %unmatchedOpenBrackets<0  meaning that the first 
                        %bracket is a closed one instead of an open one.
                    throw(MException('NueronGPU:parsing:badBrackets','Bad Brackets1'));
                end;
            end;
        end;
    end;
    
    if (i+1<=numel(lines))
        open = strfind(lines{i+1}, openBlockStr);
        close = strfind(lines{i+1}, closeBlockStr);
    end
end;

%reached the end of newLines and there are still open brackets unmatched
throw(MException('NueronGPU:parsing:badBrackets','Bad Brackets2'));