clc;
fileName = 'parsingTestFile';
suffix = 'test';
MODLFN=[fileName '.c'];
FNOut=['NrnCurrent_' suffix '.m'];
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);

Lines = parseControlFlow(Lines, 1, 1, numel(Lines), numel(Lines{numel(Lines)}));

%must be after parseCotrolFlow - maybe connect it? (the deletion of '{' '}'
Lines=regexprep(Lines,'{|}|double|v *= *_v *;','')';
%delete leading spaces and empty lines
i = 1;
while (i<=numel(Lines))
    Lines{i} = strtrim(Lines{i});
    if (isempty(Lines{i}))
        Lines(i)=[];
    else
        i=i+1;
    end;
end;


fid=fopen(FNOut,'w');
for i=1:numel(Lines)
    fprintf(fid,'%s\n',Lines{i});
end
fprintf(fid,'\n');
fclose(fid);