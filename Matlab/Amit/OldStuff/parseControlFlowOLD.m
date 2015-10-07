%if (condition statement) 
%   statement (or statements block)
%else if
%   statement (or statements block)
%else
%   statement (or statements block)
%
%
%statements block:
%{
%statements
%}

function Lines = parseControlFlow(Lines, startLin, startLet, endLin, endLet)
%
END_MATLAB = ' end ';
END_SITUATION = 'END';
IF_STR = 'if';
ELSE_STR = 'else';

OPEN_CONDITION_STR = '(';
CLOSE_CONDITION_STR = ')';
OPEN_BLOCK_STR = '{';
CLOSE_BLOCK_STR = '}';
END_STATEMENT_STR = ';';

%make sure endL isn't exceeding matrix dimensions
endLin = min(endLin, numel(Lines));
lineInd = startLin;
letterInd = startLet;
while (lineInd<endLin || (lineInd==endLin && letterInd<=endLet))
    % find if statement
    ifStatementInd = regexp(Lines{lineInd}, ['\<' IF_STR '\>']);
    ifStatementInd = ifStatementInd(ifStatementInd>=letterInd);
    if (lineInd==endLin)
       ifStatementInd = ifStatementInd(ifStatementInd<=endLet);
    end; 
    if (isempty (ifStatementInd))
        lineInd = lineInd + 1;
        letterInd = 1;
        continue;
    end;
    letterInd = ifStatementInd(1)+numel(IF_STR);
    flowSituation = IF_STR;
    
    while (~strcmp(flowSituation,END_SITUATION))
        if (~strcmp(flowSituation,ELSE_STR))
            % find end of condition ')'
            [lineInd letterInd]=findEndOfBlock(Lines, lineInd, letterInd+1,...
                OPEN_CONDITION_STR, CLOSE_CONDITION_STR);
            letterInd = letterInd + numel(CLOSE_CONDITION_STR);
            if ((lineInd>endLin) || (lineInd==endLin && letterInd>endLet))
                break;
            end;
        end
        
        %handle the upcoming section whether if it is a statement or 
        %statements block or a neseted if. incase of a block or nested if...
        %go to the end of it and parse recursively the block by itself.
        startSectionLine = lineInd;
        startSectionLetter = letterInd;
        
        
        if (isUpcomingStr(Lines, lineInd, letterInd, OPEN_BLOCK_STR) || ...
                isUpcomingStr(Lines, lineInd, letterInd, IF_STR));
            [endSectionLine endSectionLetter]= findEndOfBlock(Lines, lineInd,...
                letterInd, OPEN_BLOCK_STR, CLOSE_BLOCK_STR);
            Lines = parseControlFlow(Lines, startSectionLine, startSectionLetter,...
                endSectionLine, endSectionLetter);
            lineInd = endSectionLine;
            letterInd = endSectionLetter + numel(CLOSE_BLOCK_STR);
        %else - it's a single statement
        else
            endOfStatement = regexp(Lines{lineInd}, END_STATEMENT_STR);
            endOfStatement = endOfStatement(endOfStatement>letterInd);
            while (isempty(endOfStatement) && lineInd<endLin)
                lineInd=lineInd + 1;
                endOfStatement = regexp(Lines{lineInd}, END_STATEMENT_STR);
            end
            if (lineInd==endLin)
                endOfStatement = endOfStatement(endOfStatement<=endLet);
            end
            if (~isempty(endOfStatement))
                letterInd = endOfStatement(1)+numel(END_STATEMENT_STR);
            end
        end

        if (isUpcomingStr(Lines, lineInd, letterInd, ELSE_STR))
            ifStatementInd = regexp(Lines{lineInd}, ['\<' ELSE_STR '\>']);
            ifStatementInd = ifStatementInd(ifStatementInd>=letterInd);
            while (isempty(ifStatementInd) && lineInd<endLin)
                lineInd = lineInd + 1;
                ifStatementInd = regexp(Lines{lineInd}, ['\<' ELSE_STR '\>']);
                continue
            end
            if (lineInd==endLin)
               ifStatementInd = ifStatementInd(ifStatementInd<=endLet);
            end
            letterInd = ifStatementInd(1)+numel(ELSE_STR);
            flowSituation = ELSE_STR;
            
        %else - end of condition structure - add the 'end;' in appropriate 
        %place in matlab
        else
            flowSituation = END_SITUATION;
            if (letterInd>numel(Lines{lineInd}))
                Lines{lineInd} = [Lines{lineInd} END_MATLAB];
            elseif (letterInd==1)
                 Lines{lineInd} = [END_MATLAB Lines{lineInd}];
            else
                Lines{lineInd} = [Lines{lineInd}(1:letterInd-1) END_MATLAB...
                    Lines{lineInd}(letterInd:numel(Lines{lineInd}))];
            end
        end
    end
end

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


