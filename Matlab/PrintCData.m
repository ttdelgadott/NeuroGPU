%close all
FTYPESTR = 'float';
Stim.NStimuli=8;
%Sim.dt=0.25;
%Sim.Tfinal = 252.9;
%Sim.Tfinal = 51.3;
%Nt=floor(Sim.Tfinal/Sim.dt);
Nt=6150;
figure(27);
hold on
cc=hsv(12);
fidVHotC = fopen('../Data/VHotC.dat');
NVHotC = fread(fidVHotC, 1, 'uint16');
VHotC = fread(fidVHotC, NVHotC, FTYPESTR);
bigInds = find(abs(VHotC)>1000);
VHotP(bigInds) = NaN;
fclose(fidVHotC);
if(hasF)
plot(squeeze(Traces(2:end,1,3,2)),'r');
end
for stimulus =1:Stim.NStimuli
    hold on
figure(stimulus);
    plot(VHotC((stimulus-1)*Nt+1:Nt*stimulus),'color',cc(stimulus,:));
    %plot(Sim.dt*2:Sim.dt:(Sim.Tfinal),VHotP((stimulus-1)*Nt+1:(stimulus)*Nt),'black');
    %plot(Sim.dt:Sim.dt:(Sim.Tfinal),VHotP((stimulus-1)*Nt+1:(stimulus)*Nt),'black');
    % ylim([-200,100]);
end
xlabel('Time step');
ylabel('V[mv]');
