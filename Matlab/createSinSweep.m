function [stim] = createSinSweep(npoints,mean,std,f,dts)
times = cumsum(dts);
stim = zeros(1,npoints);
for i = 1:npoints
    stim(1,i) =mean+ std*sin(2*pi*f*times(i));
end
