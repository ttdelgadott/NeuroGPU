function [Neuron] = ReadTopologyMultipleStim(fid)
%fid = fopen('../Neuron/printCell/Output/96RCT.csv');
tline = fgetl(fid);
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
if(numel(Type)>1)
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
else
    Parent = 0;
end
%,nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,v(0.5))
%tline=fgetl(fid);
while ischar(tline)
    currType=strtrim(tline);
    compInd = getCompIndex(Type,currType);
    tline=fgetl(fid);
    CompParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
    tline=fgetl(fid);
    if (~isempty(tline))
        ModelParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f');
        Neuron.BoolModel(compInd)=1;
    else
        ModelParams(compInd,:) = zeros(1,6);
        Neuron.BoolModel(compInd)=0;
    end
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
Neuron.Areas = CompParams(:,6);
Neuron.Vs =  CompParams(:,7);
Neuron.ParentConnection = CompParams(:,8);
Neuron.N3d = CompParams(:,9);
Neuron.Types = Type;
Neuron.Parent = Parent;

Neuron.Es = ModelParams(:,4:end);
Neuron.GBars = ModelParams(:,1:3);

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
Neuron.SegToComp=SegToComp;
Neuron.Vs=Neuron.Vs(SegToComp);





