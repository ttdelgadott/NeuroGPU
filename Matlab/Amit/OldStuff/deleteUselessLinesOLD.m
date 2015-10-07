function Lines = deleteUselessLines(Lines)
DefineStrings;
uselessLinesKeywords = cell(1,3);
uselessLinesKeywords(1) = cellstr('LOCAL');
uselessLinesKeywords(2) = cellstr('TABLE'); 
uselessLinesKeywords(3) = cellstr('UNITSOFF');
%uselessLinesKeywords = ['LOCAL'; 'TABLE'; 'UNITSOFF'];
% numel(uselessLinesKeywords(:,1))
for i=1:numel(Lines)
    remarksInd = regexp(Lines{i}, REMARK_STR);
    if (~isempty(remarksInd))
       Lines{i}(remarksInd(1):end) = [];
    end
    for j=1:numel(uselessLinesKeywords)
%         uselessLinesKeywords(j)
        if (~isempty(regexp(Lines{i}, uselessLinesKeywords{j}, 'ONCE')))
            Lines{i} = '';
            break
        end
    end
end