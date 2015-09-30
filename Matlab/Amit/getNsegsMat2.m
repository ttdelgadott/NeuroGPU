function [NSegsMat] = getNsegsMat(fid)
%we have a bug!!! at the 25 ind we shouldnt have dend10[5] but dend4[4]
%fid = fopen('../Neuron/printCell/Output/try.txt');
gereshes =[];
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
        endOfTree = find(origGereshes(typeInd+1:end)<origGereshes(typeInd),1,'first')-1;
        
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
if length(strtrim(tline))<2
    tline=fgetl(fid);
end
while ischar(tline)
    currType=strtrim(tline);
    compInd = getCompIndex(Type,currType);
    tline=fgetl(fid);
    CompParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
    tline=fgetl(fid);
%     ModelParams(compInd,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f');
%     tline=fgetl(fid);
end
NSegsMat = CompParams(:,1);
 






