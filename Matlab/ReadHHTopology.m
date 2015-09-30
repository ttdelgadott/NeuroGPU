function [Neuron Sim Stim FNM] = ReadHHTopology(fid)
%fid = fopen('../Neuron/printCell/Output/forkHHTopo.csv');
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
readTopo=1;
while (ischar(tline)&&readTopo)
    dashInd = strfind(tline,'|');    
    if(~isempty(dashInd))
        if numel(dashInd)>1
            Parent(1)=0;
            Type{1}=strtrim(tline(dashInd(2)+1:end));
            currTabs = dashInd(1);
            currFather = 1;
            ind =2;
        else
             if(dashInd>currTabs)
                currFather = ind-1;
                currTabs = dashInd;
            end
            Type{ind} = strtrim(tline(dashInd+1:end));
            Parent(ind) = currFather;
            ind = ind+1;
        end
    else
        readTopo=0;
    end
    tline=fgetl(fid);
end
%,nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,v(0.5))
%tline=fgetl(fid);
while ischar(tline)
    currType=strtrim(tline);
    compInd = getCompIndex(Type,currType);
    tline=fgetl(fid);
    CompParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
    tline=fgetl(fid);
    ModelParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f');
    tline=fgetl(fid);
end
Neuron.NSegs = CompParams(:,1);
Neuron.NSegsMat = Neuron.NSegs;
Neuron.NSegsMat(1) =Neuron.NSegsMat(1)+1;
Neuron.NSegsMat = Neuron.NSegsMat+1;
Neuron.Ls = CompParams(:,2);
Neuron.Diams = CompParams(:,3);
Neuron.Ras =  CompParams(:,4);
Neuron.Cms = CompParams(:,5);
Neuron.Types = Type;
Neuron.Parent = Parent;
Neuron.Es = ModelParams(:,end-2:end);
Neuron.GBars = ModelParams(:,1:2);
Sim.Vs = CompParams(:,end);
Sim.dt = CompParams(1,6);
Sim.Tfinal = CompParams(1,end-1);
Stim.del = CompParams(1,7);
Stim.dur = CompParams(1,8);
Stim.amp = CompParams(1,9);
Stim.comp = 1;
Stim.loc =4;
Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);
FNM=['..\Data\ParamsMat' num2str(sum(Neuron.NSegsMat)) '.mat'];
fid=fopen(FNM,'wb');
fwrite(fid,Neuron.Es,'float32');
fwrite(fid,Neuron.GBars,'float32');
fclose(fid);
FNStim='..\Data\Stim.dat';
fid=fopen(FNStim,'wb');
fwrite(fid,Stim.del,'float32');
fwrite(fid,Stim.dur,'float32');
fwrite(fid,Stim.amp,'float32');
fwrite(fid,Stim.comp,'uint16');
fwrite(fid,Stim.area,'float32');
fwrite(fid,Stim.loc,'uint16');
fclose(fid);

FNSim='..\Data\Sim.dat';
fid=fopen(FNSim,'wb');
Sim.Vs = CompParams(:,end);
Sim.dt = CompParams(1,6);
Sim.Tfinal = CompParams(1,end-1);
fwrite(fid,Sim.Vs,'float32');
fwrite(fid,Sim.dt,'float32');
fwrite(fid,Sim.Tfinal,'float32');
fwrite(fid,numel(Sim.Vs),'uint16');

fclose(fid);


