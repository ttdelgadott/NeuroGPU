clear variables
fid = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
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
q =1;
Parent=0;
ind=1;
while ~isempty(q)
    typeInd = q(1);
    Types(ind) = Type(typeInd);
    nodeBreak = breaks(typeInd);
    childsInds = find(gereshes==(nodeBreak+1));
    if ~isempty(childsInds)
       q = [q fliplr(childsInds)]; 
       Parent = [Parent ones(1,numel(childsInds))*ind];
    end
    ind = ind+1;
    q = q(2:end);
end


