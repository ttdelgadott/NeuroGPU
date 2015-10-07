function Lines = parseControlFlow(Lines, startLin, startLet, endLin, endLet)

END_MATLAB = ' end ';
END_SITUATION = 'END';
IF_STR = 'if';


OPEN_CONDITION_STR = '(';
CLOSE_CONDITION_STR = ')';

END_STATEMENT_STR = ';'; 

lineInd = startLin;
letterInd = startLet;
while ((lineInd<endLin) || (lineInd==endLin && letterInd<=endLet))
    ifStatementInd = regexp(Lines{lineInd}, ['\<' IF_STR '\>']);
    if (lineInd==startLin)
        ifStatementInd = ifStatementInd(ifStatementInd>=startLet);
    end
    if (lineInd==endLet)
        ifStatementInd = ifStatementInd(ifStatementInd<=endLet);
    end
    if (~isempty(ifStatementInd))
        letterInd = ifStatementInd(1);
        letterInd = letterInd + numel(IF_STR);
        
        [endOfBlockLine endOfBlockLetter] = findEndOf_If_Block(Lines, lineInd, letterInd);
        
        Lines{endOfBlockLine} = insertStatement(Lines{endOfBlockLine}, endOfBlockLetter, END_MATLAB);
        Lines = parseControlFlow(Lines, lineInd, letterInd, endOfBlockLine, endOfBlockLetter);
        lineInd = endOfBlockLine;
        letterInd = endOfBlockLetter + numel(END_MATLAB); %might be problematic if the recursive parse inserts another end in the same line
    else
        lineInd = lineInd + 1;
        letterInd = 1;
    end
end


function line = insertStatement(line, endOfBlockLetter, END_MATLAB)
if (endOfBlockLetter>numel(line))
   line = [line END_MATLAB];
   return
end
line = [line(1:endOfBlockLetter-1) END_MATLAB line(endOfBlockLetter:end)];


function [endOfBlockLine endOfBlockLetter] = findEndOf_If_Block(Lines, lineInd, letterInd)
OPEN_BLOCK_STR = '{';
CLOSE_BLOCK_STR = '}';
ELSE_STR = 'else';
[lineInd letterInd] = findEndOfBlock(Lines, lineInd, letterInd, OPEN_BLOCK_STR, CLOSE_BLOCK_STR);
if (isUpcomingStr(Lines, lineInd, letterInd, ELSE_STR))
    [lineInd letterInd] = findEndOfBlock(Lines, lineInd, letterInd, OPEN_BLOCK_STR, CLOSE_BLOCK_STR);
end
endOfBlockLine = lineInd;
endOfBlockLetter = letterInd;


function check = isUpcomingStr(Lines, startLine, startLetter, str)
openBlockInd = regexp(Lines{startLine}, str);
openBlockInd = openBlockInd(openBlockInd>=startLetter);
anyStatementInd = regexp(Lines{startLine}, '\S');
anyStatementInd = anyStatementInd(anyStatementInd>=startLetter);
curLine = startLine + 1;
while (isempty(openBlockInd) && isempty(anyStatementInd) && curLine<=numel(Lines))
    openBlockInd = regexp(Lines{curLine}, str);
    anyStatementInd = regexp(Lines{curLine}, '\S');
    curLine = curLine + 1;
end;

if (curLine>numel(Lines) && isempty(openBlockInd) && isempty(anyStatementInd))
    check = false;
    return
end;

if (isempty(openBlockInd))
    check = false;
    return
end

if (isempty(anyStatementInd))
    check = true;
    return
end

if (openBlockInd(1)<=anyStatementInd(1))
    check = true;
    return
else
    check = false;
    return
end
