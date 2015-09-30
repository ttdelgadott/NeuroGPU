fn = '../neuron/printCell/output/fmatrix.csv';
fid = fopen(fn);
tline = fgetl(fid);
%printf("%f,%f,%f,%f,%f\n",dt,ri(0.5),ri(1),Ra,cm)
consts = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
i=1;
while ischar(tline)
    if (strfind(tline,'*'))
        tline = fgetl(fid);
        %printf("\n******\n%f,%f,%f,%f,%f,%f,%f,%f\n",t,v,gk_hh,gna_hh,gl_hh,ik,ina,il_hh,m h n)
        nums(i,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f %f %f %f')';
        tline = fgetl(fid);
        if(ischar(tline))
            for mati = 1:7
                currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
                tline = fgetl(fid);
            end
            mats(:,:,i) = currMat;
            i = i+1;
        end
    end
    tline = fgetl(fid);
end

vs = nums(:,2)';
gk = nums(:,3)';
gna = nums(:,4)';
gl = nums(:,5)';
m=nums(:,6)';
h=nums(:,7)';
n=nums(:,8)';
diag=squeeze(mats(:,4,:));
rhs=squeeze(mats(:,5,:));



