function [Neuron Sim Stim CompParams] = ReadKForkTopology2V2(fid)
%we have a bug!!! at the 25 ind we shouldnt have dend10[5] but dend4[4]
%fid = fopen('../Neuron/printCell/Output/try.txt'); ...
FTYPESTR = 'float';
gereshes=[];
if(ischar(fid))
    fid=fopen(fid);
end
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
readTopo=1;
ind=1;
while (ischar(tline)&&readTopo)
    gereshInd = strfind(tline,'`'); 
    breaksInd = strfind(tline,'|');
    dash = numel(strfind(tline,'-'))-1;%the minus one comes from the secname "dend(0-1)"
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
origDashes = dashes;
dashes=[];
q =1;
Parent=0;
ChildSegs=0;
ind=1;
typeInds=[];
if(~isempty(gereshes))
while ~isempty(q)
    typeInd = q(1);    
    if isempty(find(typeInds==typeInd))
        typeInds(ind)=typeInd;
        Types(ind) = Type(typeInd);
        dashes(ind) = origDashes(typeInd);
        nodeBreak = breaks(typeInd);
%          if(ind ==28)
%             display(ind)
%         end
        %leaf
%         if(nodeBreak>gereshes(min((typeInd+1),numel(gereshes))))%this probably not right
%             ind = ind+1;
%             q = q(2:end);
%             continue
%         end
        if(typeInd == numel(gereshes) || gereshes(typeInd)>= gereshes(typeInd+1))
            ind = ind+1;
            q = q(2:end);
             continue
        end
        endOfTree = find(origGereshes(typeInd+1:end)<=origGereshes(typeInd),1,'first')-1;
        
        if(isempty(endOfTree) || origGereshes(typeInd)==0)
            endOfTree = numel(gereshes);
        else
            endOfTree = endOfTree+typeInd;
        end
        %childsInds = find(gereshes(typeInd:endOfTree)==(nodeBreak+1))+typeInd-1;
        childsInds = find(gereshes(typeInd+1:endOfTree)<=(nodeBreak+1))+typeInd;
        zeroChilds = find(gereshes(childsInds)==0);
        childsInds(zeroChilds) = [];
        adopted = [];
        for i = 1:numel(childsInds)
            currInd = childsInds(i);
            %trueParent = find((breaks(typeInd:currInd-1)+1)<gereshes(currInd));
            trueParent = find((gereshes(typeInd:currInd-1))<gereshes(currInd));
            trueParent = find(breaks(trueParent+typeInd)>gereshes(currInd));
            if(find(trueParent>1))
                adopted(end+1) = i;
            end
        end
        if(~isempty(adopted))
            childsInds(adopted)=[];
        end
        %gereshes(childsInds)=0;
        if isempty(childsInds)&& (ind==1)
            childsInds = find(gereshes==(nodeBreak));
            
        end
        currSegs=[];
        for i=1:numel(childsInds)
            currChild = childsInds(i);
            childStart = gereshes(currChild);
            if(typeInd ==1)
                parentStart = 1;
            else
                parentStart = gereshes(typeInd);
            end
            currSegs(i) = childStart-parentStart;
        end
        ChildSegs = [ChildSegs fliplr(currSegs)];
        if ~isempty(childsInds)
           q = [q fliplr(childsInds)]; 
          % q = [q childsInds]; 
           Parent = [Parent ones(1,numel(childsInds))*ind];
        end
        ind = ind+1;
        
    end
    q = q(2:end);
end
else
    Types = Type;
end
Type = Types;
% floatExpr = '\<-?\d+(\.\d+)?\>';
% %'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f'
% line1Expr = ['(' floatExpr ',){13}' floatExpr '$'];
% while (isempty(regexp(tline, line1Expr, 'ONCE')))
%     tline=fgetl(fid);
% end
while(numel(strtrim(tline))<3)
    tline=fgetl(fid);
end
CompMap=cell(0,2);
while ischar(tline)
    currType=strtrim(tline);
    compInd = getCompIndex(Type,currType);
    CompMap{end+1,1}=currType;
    CompMap{end,2}=compInd;
    tline=fgetl(fid);
    CompParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
    tline=fgetl(fid);
%     ModelParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f');
%     tline=fgetl(fid);
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
Neuron.ChildSegs = ChildSegs;
Neuron.CompMap=CompMap;
% Neuron.Es = ModelParams(:,end-2:end);
% Neuron.GBars = ModelParams(:,1:2);
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

%Stim.loc =stimCompInd+ceil(Neuron.NSegsMat(Stim.comp)/2);
Stim.loc =stimCompInd+ceil(Neuron.NSegsMat(Stim.comp)/2)-1;
Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);
Stim.area = Neuron.Areas(Stim.comp);

Neuron.SegToComp=SegToComp;
% FNM=['..\Data\ParamsMat' num2str(sum(Neuron.NSegsMat)) '.mat'];
% fid=fopen(FNM,'wb');
% fwrite(fid,Neuron.Es,'float32');
% fwrite(fid,Neuron.GBars,'float32');
% fclose(fid);
Sim.Vs=CompParams(Neuron.SegToComp,11);
Sim.dt = CompParams(1,6);
Sim.Tfinal = CompParams(1,10);
