function Lines = identLines(Lines)
%delete leading spaces and empty lines
i = 1;
while (i<=numel(Lines))
    Lines{i} = strtrim(Lines{i});
    if (isempty(Lines{i}))
        Lines(i)=[];
    else
        i=i+1;
    end;
end;