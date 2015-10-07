function name = getBlockName (lines, openStatement)
lineInd = 0;
for i=1:numel(lines)
   if (~isempty(regexp(lines{i}, openStatement)))
       letterInd = regexp(lines{i}, openStatement) + numel(openStatement);
       lineInd = i;
       break
   end
end

if (lineInd~=0)
    name = regexp(lines{lineInd}(letterInd:end), '(\w*)', 'match', 'once');
else
    throw(MException('NueronGPU:parsing:BadOpenStatement','Open statement is missing'));
end