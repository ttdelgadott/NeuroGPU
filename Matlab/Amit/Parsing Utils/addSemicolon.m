function lines = addSemicolon(lines, funcName)
def_generalNmodlStr;

i = 1;
while (i<numel(lines) && isempty(regexp(lines{i}, funcName, 'ONCE')))
    i = i + 1;
end
if i<numel(lines)
    letterInd = regexp(lines{i}, funcName, 'ONCE');
    if (~isempty(letterInd))
        startLetter =  letterInd(1);
    else
        startLetter = 0;
    end
   [lastDeclareLine startLetter] = findEndOfBlock(lines, i, startLetter,...
       OPEN_EXP_MOD_STR, CLOSE_EXP_MOD_STR);
   i = lastDeclareLine;
end
firstRegularLine = i+1;

for i=firstRegularLine:numel(lines)
   %if there is an assigment (even procedures in NMODL are translated to assigment lines) - specifically:
   %if there is a '=' sign but no '<=', '==', etc
   if (~isempty(regexp(lines{i}, '[^><=]=[^><=]','ONCE')))
       if (isempty(regexp(lines{i}, '\<for\>', 'ONCE')))
           lines{i} = [lines{i} ';'];
       end
   end
end
