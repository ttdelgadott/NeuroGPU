function Lines = removeAtTimeFunc (Lines)
for i=1:numel(Lines)
   if (~isempty(regexp(Lines{i},'\<at_time\>'))) 
      Lines{i}=''; 
   end
end