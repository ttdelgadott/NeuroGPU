function  [CompMechnisms MechNames CompLinesPerMech]= getCompMechs(fileName)
%A variation I did for ReadMechanisms function (Amit)
Lines=getLines(fileName);
LinesX=Lines(cellfun(@isempty,regexp(Lines,'_ion')))';
AA=regexp(LinesX,'#');
CompLines=find(~cellfun(@isempty,AA));
CompEnds=[CompLines(2:end)'-1 numel(LinesX)];
MechNames=LinesX(CompLines);
bla2=@(x) x{1}{1};
blax=@(x) bla2(regexp(x,'.*?_(.*) =.*','tokens'));
for i=1:numel(CompLines)
    CurCompLines=LinesX(CompLines(i)+1:CompEnds(i));
    CompLinesPerMech{i}=CurCompLines;
    Tmp=cellfun(blax,CurCompLines,'UniformOutput',false);
    Z=regexp(Tmp,'_','split');
    for j=1:numel(Z)
        Z{j}=Z{j}{end};
    end
    [U , ~, ~]=unique(Z);
    CompMechnisms{i}=U;
end