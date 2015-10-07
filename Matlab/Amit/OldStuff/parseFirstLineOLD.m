function Lines = parseFirstLine(Lines, fileName, isFunc, funcName);
DefineStrings;
firstLine = 0;

if (isFunc)
    str = FUNCTION_STR;
else
    str = PROCEDURE_STR;
end

%find first line
for i=1:numel(Lines)
   procedureStrInd = regexp(Lines{i}, str, 'ONCE');
   if (~isempty(procedureStrInd))
      remarksInd = regexp(Lines{i}, REMARK_STR);
      if (isempty(remarksInd) || remarksInd(1)>procedureStrInd(1))
          firstLine = i;
          break
      end
   end
end

if (firstLine==0)
    return
end

%convert the first line to matlab format. remove the units orginated from the mod file

Lines{firstLine} = regexprep(Lines{firstLine}, str, ['function [' VARS_OUTPUT_STR '] =']);
Lines{firstLine} = regexprep(Lines{firstLine}, '(function \[.*\] = *)(\w*)', ['$1' fileName '_' '$2']);
%                                     'function [vars] =  hh_f  (    var1   (  unitA )   , var2  (  unitB  )   , etc...'
%  if function has no input vars:     'function [vars] =  hh_f  (   )
if (~isempty(regexp(Lines{firstLine}, 'function \[.*\] = *\w* *\( *\)')))
   Lines{firstLine} = regexprep(Lines{firstLine}, '(function \[.*\] = *\w* *\() *(\))', ['$1' VARS_INPUT_STR '$2']);
% else if function has one input var:     'function [vars] =  hh_f  (  var1   (  unit1 )     )          
%    '( unit1)' can also be omitted
elseif (~isempty(regexp(Lines{firstLine}, 'function \[.*\] = *\w* *\( *\w+ *(\( *\w* *\))? *\)')))
     Lines{firstLine} = regexprep(Lines{firstLine}, '(function \[.*\] = *\w* *\( *\w+ *)(\(? *\w* *\)?)(\))', ['$1' ', ' VARS_INPUT_STR '$3']);
 % else function has two or more input var:     'function [vars] =  hh_f  (    var1   (  unitA )   , var2  (  unitB  )   , etc...'
else
    [mat tok] = regexp(Lines{firstLine}, '(function \[.*\] = *\w* *\( *)(\w*) *\(? *\w* *\)?( *, *\w* *\(? *\w*\ *\)? *)*(\))(.*)', 'match', 'tokens');
    tok = tok{1};
    tok{3} = regexprep(tok{3}, '( *, *\w* *)\( *\w*\ *\) *', '$1');
    Lines{firstLine} = [tok{1} tok{2} tok{3} ', ' VARS_INPUT_STR tok{4} tok{5}];
end

%the function name is used in .mod file as the return value. we will use the
%same name as a return value. this isn't problematic for us since we are changing
%the function name anyway
if (isFunc)
    Lines{firstLine} = regexprep(Lines{firstLine}, '(function *\[)(.*)', ['$1' funcName  ', $2']);
end
% % %if the function recieve no variables
% % if (numel(tok)<=2)
% %     Lines{firstLine} = [tok{1} VARS_INPUT_STR tok{2}];
% %if the function recieve only one variable 
% if (numel(tok)<=3)
%     Lines{firstLine} = [tok{1} tok{2} ', ' VARS_INPUT_STR tok{3}];
% %else - he function recieve more than one variable
% else
%     tok{3} = regexprep(tok{3}, '( *, *\w* *)\( *\w*\ *\) *', '$1');
%     Lines{firstLine} = [tok{1} tok{2} tok{3} ', ' VARS_INPUT_STR tok{4}];
% end
