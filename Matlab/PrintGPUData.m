FTYPESTR = 'float';
Stim.NStimuli=1;
Sim.dt=0.025;
NSets = 120;
Sim.Tfinal = 50;
%Sim.Tfinal = 51.3;
%Nt=floor(Sim.Tfinal/Sim.dt);
Nt=2017;
figure(27);
fidVHotP = fopen('../Data/VHotP.dat');
NVHotP = fread(fidVHotP, 1, 'int');
VHotP = fread(fidVHotP, NVHotP, FTYPESTR);
Nt = NVHotP/NSets;
bigInds = find(abs(VHotP)>1000);
VHotP(bigInds) = NaN;
fclose(fidVHotP);
for set=1:10:NSets-1
    figure(set);
    currVhotP = VHotP((set-1)*Nt+1:set*Nt);
    for stimulus =1:Stim.NStimuli
        hold on;
        %plot(Sim.dt*2:Sim.dt:(Sim.Tfinal),VHotP((stimulus-1)*Nt+1:(stimulus)*Nt),'black');
        plot(currVhotP(1:end-1));
        %plot(Sim.dt:Sim.dt:(Sim.Tfinal),VHotP((stimulus-1)*Nt+1:(stimulus)*Nt),'black');
        % ylim([-200,100]);
    end
end