function [Mats Traces] = readFmatrixForkHH(fn,Neuron)
Traces=[];
fid = fopen(fn);
tline = fgetl(fid);

Ns = sum(Neuron.NSegs+1);
NComp = numel(Neuron.NSegs);
%printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,v(0.5))
%printf("%f,%f,%f,%f,%f\n",gnabar_hh2,gkbar_hh2,ek,ena,el_hh2)
i=1;
while ischar(tline)
        if(ischar(tline))
            for mati = 1:Ns+1
                currMat(mati,:) =  sscanf(tline,'%f %f %f %f %f');
                tline = fgetl(fid);
            end
            Mats(:,:,i) = currMat;
            i = i+1;
        end
        if(ischar(tline))
            for comps = 1:NComp
                currType = strtrim(tline);
                indType = getCompIndex(Neuron.Types,currType);
                tline = fgetl(fid);
                %t,v(0.5),i_cap(0.5),st.amp
                for segs = 1:5
                    if (Neuron.BoolModel(indType))
                        Traces(i,indType,segs,:) = sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f')';   
                    else
                        Traces(i,indType,segs,1:2) = sscanf(tline,'%f,%f')';   
                    end
                    tline = fgetl(fid);
                end
            end
        end
end

