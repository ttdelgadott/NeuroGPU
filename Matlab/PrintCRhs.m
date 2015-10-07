figure(222)
FTYPESTR = 'float';
debugFN = '..\VS\MainenExpand\NeuronC\Debug.dat';
fid = fopen(debugFN,'r');
Nt = fread(fid,1,'int16');
crhs = fread(fid,Nt,FTYPESTR);
plot(crhs(1:end));
hold on
plot(NRHSStim(1:end),'r');
%ylim([-20,20]);