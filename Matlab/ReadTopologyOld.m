function [Type Parent] = ReadTopologyOld()
fid = fopen('../Neuron/printCell/Output/topology.csv');
tline = fgetl(fid);
while ischar(tline)
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
    end
    tline=fgetl(fid);
end
