function lines = deleteAllTypeComments (lines, oneLineComment, manyLineCommentStart,...
    manyLineCommentEnd)

lines = deleteBlockComments(lines, manyLineCommentStart, manyLineCommentEnd);

for i = 1:numel(lines)
    remarksInd = regexp(lines{i}, oneLineComment);
    if (~isempty(remarksInd))
       lines{i}(remarksInd(1):end) = [];
    end
end