 g = struct('K', 36, 'Na', 120, 'Cl', 1/15); 
stim = struct('t1',10,'t2',12,'amp',1e-2,'loc',10,'Tfin',50);
 dt = 0.01;
 pinc =4;
 
[t,Vhot] = stEfork2(g,stim,pinc);

% fid = fopen('C:\Users\Roy\Documents\Academics\NeuroGPU\Gilad2\VHotC.dat', 'rb');
% CNt=fread(fid,1,'uint16');
% CVHot=fread(fid,CNt,'float32');
% fclose(fid);

figure(34);plot(t,Vhot,'b'); %,t,CVHot,'r')