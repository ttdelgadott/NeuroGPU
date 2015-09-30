function Out=numRowsInFile(FN)
fid = fopen(FN);
tline = fgetl(fid);
Lines=cell(0);
while ischar(tline)
    Lines{end+1}=tline;
    tline = fgetl(fid);
end
fclose(fid);
Out=sum(cellNumel(Lines)>0);