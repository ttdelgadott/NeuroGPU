function [Neuron Sim Stim FNM] = ReadTopologyMainenPas(fid)
%we have a bug!!! at the 25 ind we shouldnt have dend10[5] but dend4[4]
%fid = fopen('../Neuron/printCell/Output/try.txt');
tline = fgetl(fid);
tline = fgetl(fid);
readTopo=1;
ind=1;
while (ischar(tline)&&readTopo)
    gereshInd = strfind(tline,'`'); 
    breaksInd = strfind(tline,'|');
    dash = numel(strfind(tline,'-'))-1;
    if ~isempty(breaksInd)
        if isempty(gereshInd)
            Type{ind} = strtrim(tline(breaksInd(2)+1:end));
            breaks(ind) = breaksInd(2);
            dashes(ind) = dash;
        else
            Type{ind} = strtrim(tline(breaksInd+1:end));
            breaks(ind) = breaksInd;
            dashes(ind) = dash;
            gereshes(ind)=gereshInd;
        end
    else
        readTopo=0;
    end
    ind = ind+1;
    tline = fgetl(fid);    
end
%[Parent Type indToTypeInd] = buildMorphoAsNeuron(gereshes,breaks,dashes,Type);
% Neuron.AltParent= AltParent;
% Neuron.AltType= AltType;
origGereshes=gereshes;
q =1;
Parent=0;
ind=1;
typeInds=[];
while ~isempty(q)
    if(numel(q)>2)
    end
    typeInd = q(1);    
    if(ind==80)
        1
    end
    if isempty(find(typeInds==typeInd))
        typeInds(ind)=typeInd;
        Types(ind) = Type(typeInd);
        nodeBreak = breaks(typeInd);
        %leaf
        if(nodeBreak>gereshes(min((typeInd+1),numel(gereshes))))
            ind = ind+1;
            q = q(2:end);
            continue
        end
        endOfTree = find(origGereshes(typeInd+1:end)==origGereshes(typeInd),1,'first');
        
        if(isempty(endOfTree))
            endOfTree = numel(gereshes);
        else
            endOfTree = endOfTree+typeInd;
        end
        childsInds = find(gereshes(typeInd:endOfTree)==(nodeBreak+1))+typeInd-1;
        gereshes(childsInds)=0;
        if isempty(childsInds)&& (ind==1)
            childsInds = find(gereshes==(nodeBreak));
            
        end
        if ~isempty(childsInds)
            if(~isempty(find(childsInds==90)))
                1
            end
           q = [q fliplr(childsInds)]; 
           Parent = [Parent ones(1,numel(childsInds))*ind];
        end
        ind = ind+1;
        
    end
    q = q(2:end);
end
Type = Types;
%,nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,v(0.5))
%tline=fgetl(fid);
while ischar(tline)
    currType=strtrim(tline);
    compInd = getCompIndex(Type,currType);
    tline=fgetl(fid);
    CompParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
    tline=fgetl(fid);
    ModelParams(compInd,:) = sscanf(tline,'%f,%f,%f');
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
Neuron.Areas = CompParams(:,12);
Neuron.ParentConnection = CompParams(:,13);
Neuron.N3d = CompParams(:,14);
Neuron.Types = Type;
Neuron.Parent = Parent;
Neuron.Es = ModelParams(:,end);
Neuron.GBars = ModelParams(:,end-1);
Neuron.Celsius = ModelParams(:,1);
CNMat = cumsum(Neuron.NSegsMat);
if(numel(CNMat)>1)
    Neuron.SegStart = [1 CNMat(1:end-1)'+1];
    Neuron.SegEnd = [Neuron.SegStart(2:end)-1 CNMat(end)];
else
    Neuron.SegStart = 1;
    Neuron.SegEnd = CNMat(1);
end
N=sum(Neuron.NSegsMat);
SegToComp=zeros(1,N);
for i=1:numel(Neuron.SegStart)
    SegToComp(Neuron.SegStart(i):Neuron.SegEnd(i))=i;
end
Sim.Vs = CompParams(:,11);
Sim.dt = CompParams(1,6);
Sim.Tfinal = CompParams(1,10);
Stim.del = CompParams(1,7);
Stim.dur = CompParams(1,8);
Stim.amp = CompParams(1,9);
Stim.comp = 1;
stimCompInd = Neuron.SegStart(Stim.comp);
if(Stim.comp==1)
    stimCompInd=1;
end

Stim.loc =stimCompInd+ceil(Neuron.NSegs(Stim.comp)/2);
Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);
Stim.area = Neuron.Areas(Stim.comp);

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
% fwrite(fid,Stim.comp,'uint16');
fwrite(fid,Stim.area,'float32');
fwrite(fid,Stim.loc,'uint16');
fclose(fid);

Neuron.SegToComp=SegToComp;
Sim.Vs=CompParams(SegToComp,11);
Sim.dt = CompParams(1,6);
Sim.Tfinal = CompParams(1,10);

FNSim='..\Data\Sim.dat';
fid=fopen(FNSim,'wb');
fwrite(fid,Sim.Vs,'float32');
fwrite(fid,Sim.dt,'float32');
fwrite(fid,Sim.Tfinal,'float32');
fclose(fid);


