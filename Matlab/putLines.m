function putLines(FNorFID,Lines)
UseFN=false;
if(ischar(FNorFID))
    fid=fopen(FNorFID,'w');
    UseFN=true;
else
    fid=FNorFID;
end
for i=1:numel(Lines)
    if(iscell(Lines{i}))
        for j=1:numel(Lines{i})
            if(iscell(Lines{i}{j}))
                for k=1:numel(Lines{i}{j})
                    fprintf(fid,'%s\n',Lines{i}{j}{k});
                end
            else
                fprintf(fid,'%s\n',Lines{i}{j});
            end
        end
    else
        if(ischar(Lines{i}))
            fprintf(fid,'%s\n',Lines{i});
        end
    end
    

end
if(UseFN)
    fclose(fid);
end