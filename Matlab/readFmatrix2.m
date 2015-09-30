fn = '../neuron/printCell/output/nakedSoma.csv';
fid = fopen(fn);
tline = fgetl(fid);
%printf("%f,%f,%f,%f,%f\n",dt,ri(0.5),ri(1),Ra,cm)
consts = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f');
i=1;
NSeg=5;
while ischar(tline)
        for j=1:5
            tline = fgetl(fid);
            nums(i,j,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f %f %f %f %f')';
        end
        if(ischar(tline))
            for mati = 1:7
                tline = fgetl(fid);
                currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
            end
            mats(:,:,i) = currMat;
            i = i+1;
        end
    end
end
vs = squeeze(nums(:,:,2));
gk = squeeze(nums(:,:,3))';
gna = squeeze(nums(:,:,4))';
gl = squeeze(nums(:,:,5))';
m=squeeze(nums(:,:,6))';
h=squeeze(nums(:,:,7))';
n=squeeze(nums(:,:,8))';
ri=squeeze(nums(:,:,9))';
diag=squeeze(mats(:,4,:));
rhs=squeeze(mats(:,5,:));

