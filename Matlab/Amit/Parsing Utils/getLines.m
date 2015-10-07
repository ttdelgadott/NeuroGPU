function lines = getLines(fileName)
lines = cell(0);
fid = fopen(fileName, 'r');
line = fgetl(fid);
while ischar(line)
    lines{end+1} = line;
    line = fgetl(fid);
end
fclose(fid);