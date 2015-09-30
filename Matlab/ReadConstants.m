function [Sim Stim] = ReadConstants(fid,Neuron,Sim)
tline = fgetl(fid);
compStr= sscanf(tline,'%s'); 
tline = fgetl(fid);
temp = sscanf(tline,'%f,%d'); 
area = temp(1);
NStimuli = temp(2);
Stim.NStimuli = NStimuli;
for i = 1:NStimuli
    tline = fgetl(fid);
    temp = sscanf(tline,'%f,%f,%f'); 
    Stim.del(i)=temp(1);
    Stim.dur(i)=temp(2);
    Stim.amp(i)=temp(3);
end
tline = fgetl(fid);
temp = sscanf(tline,'%f,%f,%f'); 

Sim.dt = temp(1);
Sim.Tfinal = temp(2);
Sim.Celsius = temp(3);
Stim.comp = getCompIndex(Neuron.Types,compStr);
stimCompInd = Neuron.SegStart(Stim.comp);
if(Stim.comp==1)
    stimCompInd=1;
end
Stim.loc =stimCompInd+ceil(Neuron.NSegs(Stim.comp)/2);
%Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);
Stim.area = area;
FNM=['..\Data\ParamsMat' num2str(sum(Neuron.NSegsMat)) '.mat'];
fid=fopen(FNM,'wb');
fwrite(fid,Neuron.Es,'float32');
fwrite(fid,Neuron.GBars,'float32');
fclose(fid); 
FNStim=['..\Data\Stim' num2str(sum(Neuron.NSegsMat)) '.dat'];
fid=fopen(FNStim,'wb');
fwrite(fid,NStimuli,'uint16');
fwrite(fid,Stim.del,'float32');
fwrite(fid,Stim.dur,'float32');
fwrite(fid,Stim.amp,'float32');
fwrite(fid,Stim.comp,'uint16');
fwrite(fid,Stim.area,'float32');
fwrite(fid,Stim.loc,'uint16');
fclose(fid);


Sim.Vs=Neuron.Vs;
FNSim=['..\Data\Sim' num2str(sum(Neuron.NSegsMat)) '.dat'];
fid=fopen(FNSim,'wb');
fwrite(fid,Sim.dt,'float32');
fwrite(fid,Sim.Tfinal,'float32');
fwrite(fid,Sim.Celsius,'float32');
fwrite(fid,Sim.Vs,'float32');
fclose(fid);