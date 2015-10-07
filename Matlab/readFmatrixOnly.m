function currMat = readFmatrixOnly(fn,Ns)
fid = fopen(fn);
tline = fgetl(fid);
while ischar(tline)
        if(ischar(tline))
            for mati = 1:Ns
                currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
                tline = fgetl(fid);
            end
        end
end

