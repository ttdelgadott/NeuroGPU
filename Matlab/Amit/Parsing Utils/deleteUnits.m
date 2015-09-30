function lines = deleteUnits(lines)

%delete min/max values in angle brackets.
lines = regexprep(lines, '<.*>', '');
%delete units in round brackets
lines = regexprep(lines, '\(.*\)', '');
%delete lines with no assignments
for i=1:numel(lines)
    if (isempty(regexp(lines{i}, '=', 'ONCE')))
        lines{i} = '';
    end
end