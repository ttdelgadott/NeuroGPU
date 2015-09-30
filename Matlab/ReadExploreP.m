fn = '../Neuron/printCell/Output/ExploreP.csv';
fid = fopen(fn);
tline = fgetl(fid);
tline = fgetl(fid);
i=1;
clear ExP
while ischar(tline)
    for segs = 1:7
        aaa = sscanf(tline,'%f %f %f %f %f')'; 
         ExP(i,segs,:)=aaa;
         tline = fgetl(fid);
         if(~ischar(tline))
             break;
         end
    end
    OtherParam(i)=sscanf(tline,'%f');
    tline = fgetl(fid);
    i=i+1;
end
fclose(fid);