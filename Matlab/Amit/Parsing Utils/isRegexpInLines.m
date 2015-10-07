function check = isRegexpInLines (lines, expression)

check = false;
for i = 1:numel(lines)
   if ~isempty(regexp(lines{i}, expression, 'ONCE'))
       check = true;
       return;
   end
end