%parseVariables
indexlines = getLines(fileName);
for i=1:numel(indexlines)
    if (~isempty(strfind(indexlines{i}, '_index')))
        [mat tok ext] = regexp(indexlines{i}, '(\w*) *_index *=', 'match', ...
        'tokens', 'tokenExtents');
        variableName = tok{1};
        %['\<' char(variableName) '\>'] - exactly the variableName -
        %meaning that if variableName = 'el' than words like 'model' won't
        %count
        if strcmp(variableType,CONSTS_PER_MODEL_PER_SEG_STR)
            lines=regexprep(lines, ['\<' char(variableName) '\>'],...
            [variableType '(:, ' char(variableName) '_index)'])';
        else
            lines=regexprep(lines, ['\<' char(variableName) '\>'],...
            [variableType '(' char(variableName) '_index)'])';
        end
        
    end;
end;