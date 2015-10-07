%parseVariables
indexFid=fopen(fileName,'r');
indexLines = cell(0);
while 1
    tline = fgetl(indexFid);
    if ~ischar(tline),   break,   end
    indexLines{end+1}=tline;
end
fclose(fid);
for i=1:numel(indexLines)
    if (~isempty(strfind(indexLines{i}, '_index')))
        [mat tok ext] = regexp(indexLines{i}, '(\w*) *_index *=', 'match', ...
        'tokens', 'tokenExtents');
        variableName = tok{1};
        %['\<' char(variableName) '\>'] - exactly the variableName -
        %meaning that if variableName = 'el' than words like 'model' won't
        %count
        Lines=regexprep(Lines, ['\<' char(variableName) '\>'],...
            [variableType '(' char(variableName) '_index)'])';
    end;
end;