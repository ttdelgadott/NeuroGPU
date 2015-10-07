function Out=AddModelNameToFunctions(In,Src,Trg)
Out=In;
if(ischar(In))
    for j=1:numel(Src)
%         Out=strrep(Out,Src{j},Trg{j});
        Out=regexprep(Out,['(^|\W)(' Src{j} ')(\W)'],['$1' Trg{j} '$3']);
    end
else
    for i=1:numel(In)
        for j=1:numel(Src)
%             Out{i}=strrep(Out{i},Src{j},Trg{j});
            Out{i}=regexprep(Out{i},['(^|\W)(' Src{j} ')(\W)'],['$1' Trg{j} '$3']);
        end
    end
end