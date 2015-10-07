function [stim] = createNoiseSweep(npoints,mean,std,tau,dt)
stim = zeros(2,npoints);
stim(1,1) = 0;
stim(2,1) = 0;
for i = 2:npoints
    stim(1,i) = stim(1,i-1) + dt;
    stim(2,i) = stim(2,i-1)+(mean-stim(2,i-1))*dt/tau + std*sqrt(2*dt/tau)*random('normal',0,1);
end
