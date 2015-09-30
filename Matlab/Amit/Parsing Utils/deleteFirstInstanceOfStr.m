function lines = deleteFirstInstanceOfStr (lines, str)
for i = 1:numel(lines)
   if (~isempty(regexp(lines{i}, str, 'ONCE')))
      lines{i} = regexprep (lines{i}, str, '', 'ONCE');
      return
   end
end
