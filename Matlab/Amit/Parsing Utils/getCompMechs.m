function  CompMechnisms = getCompMechs(fileName)
%A variation I did for ReadMechanisms function (Amit)
fid = fopen(fileName);
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
LinesX=Lines(cellfun(@isempty,regexp(Lines,'_ion')))';
fclose(fid);
AA=regexp(LinesX,'#');
CompLines=find(~cellfun(@isempty,AA));
CompEnds=[CompLines(2:end)'-1 numel(LinesX)];
for i=1:numel(CompLines)
    bla2=@(x) x{1}{1};
    blax=@(x) bla2(regexp(x,'.*?_([^_]*) =.*','tokens'));
    CurCompLines=LinesX(CompLines(i)+1:CompEnds(i));
    [U , ~, ~]=unique(cellfun(blax,CurCompLines,'UniformOutput',false));
%     CurPasLine=CurCompLines{strhas(CurCompLines,'g_pas')};
%     if(strhas(CurPasLine,'-777'))
%         U=setdiff(U,'pas');
%     end
    CompMechnisms{i}=U;
end
end

