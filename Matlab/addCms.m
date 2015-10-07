function [d] = addCms(d,cm,dt,NSegs)
cmsdt = (ones(length(d)-1,1).*0.001.*cm)./dt;
lastSegs = NSegs+1;
cmsdt(lastSegs) = 0;
d(2:end) = d(2:end)+cmsdt;


