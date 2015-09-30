function Lines=removeCommentBlock(Lines)
Lines=deleteComments(Lines, ':');
CommentStart=find(strhas(Lines,'COMMENT'));
while ~isempty(CommentStart)
    CommentStart=CommentStart(1);
    CommentEnd=find(strhas(Lines,'ENDCOMMENT'));
    CommentEnd=CommentEnd(1);
    RestLines=setdiff(1:numel(Lines),CommentStart:CommentEnd);
    Lines=Lines(RestLines);
    CommentStart=find(strhas(Lines,'COMMENT'));
end
Lines=Lines(cellfun(@isempty,regexp(Lines,'.*FROM.*TO.*')));
Lines=Lines(cellfun(@isempty,regexp(Lines,'.*DEPEND.*')));
Lines=Lines(cellfun(@isempty,regexp(Lines,'.*UNITSON.*')));
Lines=Lines(cellfun(@isempty,regexp(Lines,'.*UNITSOFF.*')));
Lines=Lines(cellNumel(Lines)>0);
UnitsLineStart=find(strhas(Lines,'UNITS'),1);
if(~isempty(UnitsLineStart))
    UnitsEndLine=find(strhas(Lines(UnitsLineStart:end),'}'),1)+UnitsLineStart-1;
    UnitsLines=Lines(UnitsLineStart:UnitsEndLine)';
%     Tmp=regexp(UnitsLines,'\W*(.*?)\W*=.*','tokens');
    Tmp=regexp(UnitsLines,'\W*(\(.*\))\W*=.*','tokens');
    Tmp=Tmp(cellNumel(Tmp)>0);
    Tmp2=cat(1,Tmp{:});
    UnitsStrs=cat(1,Tmp2{:});
    UnitsStrs=[UnitsStrs; '(degC)'];
    
    for i=1:numel(UnitsStrs)
        Lines=strrep(Lines,UnitsStrs{i},'');
    end
end