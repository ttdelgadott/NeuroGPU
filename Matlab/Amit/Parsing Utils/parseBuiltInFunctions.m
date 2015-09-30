function Lines = parseBuiltInFunctions(Lines)

ABS_MOD_STR = 'fabs';
ABS_MAT_STR = 'abs';
POW_MOD_STR = 'pow';
POW_MAT_STR = 'power';

for i=1:numel(Lines)
   if (~isempty(regexp(Lines{i}, ['\<' ABS_MOD_STR '\>'])))
       Lines{i} = regexprep (Lines{i}, ['\<' ABS_MOD_STR '\>'], ABS_MAT_STR);
   end;
   if (~isempty(regexp(Lines{i}, ['\<' POW_MOD_STR '\>'])))
       Lines{i} = regexprep (Lines{i}, ['\<' POW_MOD_STR '\>'], POW_MAT_STR);
   end;
end