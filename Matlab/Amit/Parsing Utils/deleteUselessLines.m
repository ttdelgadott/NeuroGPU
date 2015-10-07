function Lines = deleteUselessLines(Lines)
def_generalNmodlStr;
def_uselessNmodlLinesKeyWords;

Lines = deleteAllTypeComments(Lines, COMMENT_MOD_STR, OPEN_COMMENT_MOD_STR,...
    CLOSE_COMMENT_MOD_STR);

for i=1:numel(Lines)
    for j=1:numel(KEY_WORDS)
%         uselessLinesKeywords(j)
        if (~isempty(regexp(Lines{i}, ['\<' KEY_WORDS{j} '\>'], 'ONCE')))
            Lines{i} = '';
            break
        end
    end
end