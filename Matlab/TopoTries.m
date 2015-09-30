clear variables
fid = fopen('../Neuron/printCell/Output/realCellTopo.csv');
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
readTopo=1;
ind=1;
while (ischar(tline)&&readTopo)
    dashInd = strfind(tline,'|');   
    gereshInd =  strfind(tline,'`'); 
    if isempty(gereshInd) %Soma       
         Parent(1)=0;
         Type{1}=strtrim(tline(dashInd(2)+1:end));
         dashes(1)=dashInd(end);
    else
        dashes(ind) = dashInd+1;
        gereshInDash = find(dashes==gereshInd,1,'last');
        Parent(ind)=gereshInDash; 
        Type{ind} = strtrim(tline(dashInd+1:end));
    end
        ind=ind+1;
        tline = fgetl(fid);
    
end
    