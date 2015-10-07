figure(2345)
DataSize=64
gdbSTRFN = '../Data/gdbstr.txt';
lines = getLines(gdbSTRFN);
gdbStr = '';
for i = 1:numel(lines)
    if(~strhas(lines{i},'Type'))
        gdbStr = [gdbStr,lines{i}];
    end
end
gdbStr = strrep(gdbStr,'{','');
gdbStr = strrep(gdbStr,'}','');
gdbStr = strrep(gdbStr,', ',' ');
gdbStr = strrep(gdbStr,'  ',' ');
[gdb status] = str2num(gdbStr);
vsmallInd = find(abs(gdb)<1e-10);
gdb(vsmallInd)=1e-20;
gdb=gdb';
CFN = '../Data/Debug.dat';
fid = fopen(CFN);
N = fread(fid,1,'int16');
C = fread(fid,DataSize,'double');
vsmallInd = find(abs(C)<1e-10);
C(vsmallInd)=1e-20;
error = (gdb-C)./gdb;
subplot(3,1,1)
plot(gdb,'red');
subplot(3,1,2)
plot(C,'blue');
subplot(3,1,3)
plot(error(2:end),'black');
