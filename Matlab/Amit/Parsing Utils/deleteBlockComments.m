function lines = deleteBlockComments(lines, startBlockStr, endBlockStr)

numOfLines = numel(lines);
i = 1;
while (i<=numOfLines)
    startBlockInd = strfind(lines{i}, startBlockStr);
    if (isempty(startBlockInd))
        i = i+1;
        continue
    end
    if(startBlockInd(1)==1)
        prefixPart = '';
    else
        prefixPart = lines{i}(1:startBlockInd-1);
    end
    
    endBlockInd = strfind(lines{i}, endBlockStr);
    %if endBlockStr is in the same line as openBlockStr
    if (~isempty(endBlockInd))
        %delete the comment part
        if (endBlockInd(1)+length(endBlockStr)-1==length(lines{i}))
            postfixPart = '';
        else
            postfixPart = lines{i}(endBlockInd+length(endBlockStr):end);
        end
        lines{i} = [prefixPart postfixPart];
        continue;
    end
    %if reached here than endBlockStr is not in the same line, then delete
    %first line
    lines{i} = prefixPart;
    i=i+1;
    %delete all lines until last line
    while (i<=numOfLines && isempty(strfind(lines{i}, endBlockStr)))
        lines{i} = '';
        i=i+1;
    end
    if (i<=numOfLines)
        endBlockInd = strfind(lines{i}, endBlockStr);
        endOfBlockLetetInd = endBlockInd(1)+length(endBlockStr)-1;
        if (endOfBlockLetetInd==length(lines{i}))
            postfixPart = '';
        else
            postfixPart = lines{i}(endBlockInd+length(endBlockStr):end);
        end
        lines{i} = postfixPart;
    end
end