function WriteStimAndSim(Sim,Stim,FTYPESTR)

FNStim='..\Data\Stim.dat';
fid=fopen(FNStim,'wb');
fwrite(fid,Stim.del,FTYPESTR);
fwrite(fid,Stim.dur,FTYPESTR);
fwrite(fid,Stim.amp,FTYPESTR);
% fwrite(fid,Stim.comp,'uint16');
fwrite(fid,Stim.area,FTYPESTR);
fwrite(fid,Stim.loc,'uint16');
fclose(fid);

%Neuron.SegToComp=SegToComp;

FNSim='..\Data\Sim.dat';
fid=fopen(FNSim,'wb');
fwrite(fid,Sim.Vs',FTYPESTR);
fwrite(fid,Sim.dt,FTYPESTR);
fwrite(fid,Sim.Tfinal,FTYPESTR);
NRecSites = length(Sim.RecSites);
fwrite(fid,NRecSites,'uint16');
fwrite(fid,Sim.RecSites-1,'uint16');
fclose(fid);