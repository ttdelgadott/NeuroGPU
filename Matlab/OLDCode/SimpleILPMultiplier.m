FN = 'CudaStuffILP2.cu';
fid=fopen(FN);
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);
nLines=numel(Lines);
k=5;
%%
OutLines=Lines';
NewLines=cell(k-2,1);
i=0;
while(i<numel(OutLines))
    i=i+1;
    CurLine=OutLines{i};
    if(isempty(strfind(CurLine,'_2')))
        continue;
    end
    for j=3:k
        NewLines{j-2}=strrep(CurLine,'_2',['_' num2str(j)]);
        NewLines{j-2}=strrep(NewLines{j-2},'WARPSIZE',['(WARPSIZE*' num2str(j-1) ')']);
    end
    OutLines=[OutLines(1:i); NewLines; OutLines(i+1:end)];
end
%%
FNOut=[FN(1:end-3) '_' num2str(k) '.cu'];
fid=fopen(FNOut,'w');
for i=1:numel(OutLines)
    fprintf(fid,'%s\n',OutLines{i});
end
fclose(fid);
