function lines = deleteLinesUntilStr (lines, str)
%delete everything prefacing the gives string.
for i=1:numel(lines)
    openBracketInd = strfind(lines{i},str);
    if (isempty(openBracketInd(1)))
        continue;
    end;
    lines{i} = lines{i}(openBracketInd(1):end);
    lines = lines(i:end);
    break;
end;