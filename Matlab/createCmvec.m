function [cmVec]= createCmvec(cms,nsegs)
cmVec=[];
for i=1:numel(nsegs)
    cmVec = [cmVec,0,cms(i)*ones(1,nsegs(i))];
end
cmVec(end+1)=0;