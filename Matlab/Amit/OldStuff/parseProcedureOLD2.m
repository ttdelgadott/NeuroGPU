function parseProcedure(Lines, fileName)
DefineStrings;
functionName = getBlockName(Lines ,PROCEDURE_STR);

FNOut=[fileName '_' functionName '.m'];
Lines = deleteRemarks(Lines);

fid=fopen(FNOut,'w');
for i=1:numel(Lines)
    fprintf(fid,'%s\n',Lines{i});
end
fprintf(fid,'\n');
fclose(fid);


