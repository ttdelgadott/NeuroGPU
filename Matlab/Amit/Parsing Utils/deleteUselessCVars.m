function Lines = deleteUselessCVars(Lines)
PREFIX_OF_SPARE_VAR = '_';

for i=1:numel(Lines)
    if (~isempty(regexp(Lines{i}, ['\<' PREFIX_OF_SPARE_VAR '\w*\>'], 'ONCE')))
        Lines{i} = '';
        break
    end
end