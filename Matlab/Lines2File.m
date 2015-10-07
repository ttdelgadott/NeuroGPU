function Lines2File(allLines,FNOut)
fid=fopen(FNOut,'w');
for i=1:numel(allLines)
    fprintf(fid,'%s\n',allLines{i});
end
fprintf(fid,'\n');
fclose(fid);