function [conductances nums mats diags parents childs rhs NSeg L diam Ra cm dt stdel stdur stamp vinit gnabar_hh gkbar_hh ek ena el_hh] = readFmatrixCapSoma()
fn = '../neuron/printCell/output/fmatrixHHSoma.csv';
fid = fopen(fn);
tline = fgetl(fid);
%printf("%f,%f,%f,%f,%f\n",dt,ri(0.5),ri(1),Ra,cm)
consts = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
NSeg=consts(1);
tline = fgetl(fid);
L=consts(2); 
diam=consts(3);
Ra=consts(4);
cm=consts(5); 
dt=consts(6); 
stdel=consts(7);
stdur=consts(8); 
stamp=consts(9); 
vinit=consts(10);
conductances=sscanf(tline,'%f,%f,%f,%f,%f');
gnabar_hh = conductances(1);
gkbar_hh = conductances(2);
ek = conductances(3);
ena = conductances(4);
el_hh= conductances(5);
i=1;
tline = fgetl(fid);
while ischar(tline)
    for segs = 1:5
        aaa = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')'; 
         nums(i,segs,:)=aaa;
         tline = fgetl(fid);
    end
    if(ischar(tline))
        for mati = 1:NSeg+2
            currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
            tline = fgetl(fid);
            if(~ischar(tline))
                break;
            end
        end
        mats(:,:,i) = currMat;
        i = i+1;
%         tline = fgetl(fid);
%         tline = fgetl(fid);
    end  
end
fclose(fid);
% nums = nums(2:end,:);
% ts = nums(:,1);
% vs = nums(:,2);
% icaps = nums(:,3);
% iamps = nums(:,4);
parents = squeeze(mats(:,2,:));
childs = squeeze(mats(:,3,:));
diags=squeeze(mats(:,4,:));
rhs=squeeze(mats(:,5,:));

