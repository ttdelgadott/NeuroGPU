function [diags parents childs rhs NSeg L diam Ra cm dt stdel stdur stamp vinit icaps vs ts iamps] = readFmatrixCapSoma()
fn = '../neuron/printCell/output/nakedSoma.csv';
fid = fopen(fn);
tline = fgetl(fid);
%printf("%f,%f,%f,%f,%f\n",dt,ri(0.5),ri(1),Ra,cm)
consts = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
NSeg=consts(1);
L=consts(2); 
diam=consts(3);
Ra=consts(4);
cm=consts(5); 
dt=consts(6); 
stdel=consts(7);
stdur=consts(8); 
stamp=consts(9); 
vinit=consts(10);
i=1;
tline = fgetl(fid);
while ischar(tline)
        if(ischar(tline))
            for mati = 1:NSeg+2
                currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
                tline = fgetl(fid);
            end
            mats(:,:,i) = currMat;
            i = i+1;
            tline = fgetl(fid);
            tline = fgetl(fid);
        end
        nums(i,:) = sscanf(tline,'%f,%f,%f,%f')';   
        tline = fgetl(fid);
end
nums = nums(2:end,:);
ts = nums(:,1);
vs = nums(:,2);
icaps = nums(:,3);
iamps = nums(:,4);
parents = squeeze(mats(:,2,:));
childs = squeeze(mats(:,3,:));
diags=squeeze(mats(:,4,:));
rhs=squeeze(mats(:,5,:));

