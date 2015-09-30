close all
%outfolder = '../ModelDB/mainen/stims2/';
% outfolder = '../ModelDB/mainen/stims/';
% timesfolder = '../ModelDB/mainen/volts/';
outfolder = '../Neuron\Mainen\FullTest\Stims\';
timesfolder = '../Neuron\Mainen\FullTest\';

NStim = 8;
selectedIndsStep = [1:8];
selectedIndsSins = [1:8];
dstim = 0.00055;
stimStart=-0.00056;
stimdur = 600;
stimdur_dt = 0.1;
prepulse = 200;
prepulse_dt = 2;
postpulse = 152;
tau = 3;
std = dstim*1.25;
numOfPoints = prepulse/prepulse_dt+stimdur/stimdur_dt+postpulse/prepulse_dt;
time=zeros(1,numOfPoints);
prepulseInd = prepulse/prepulse_dt+1;
time(1:prepulseInd)=prepulse_dt;
stimInd = prepulseInd + stimdur/stimdur_dt;
time(prepulseInd:stimInd)=stimdur_dt;
noiseMean= zeros(NStim,numOfPoints);
time(stimInd:stimInd+postpulse/prepulse_dt-1)=prepulse_dt;
for i=1:NStim
    currNoise = createNoiseSweep(stimdur/stimdur_dt,stimStart+dstim*(i-1),std,tau,stimdur_dt);
    noiseMean(i,prepulseInd+1:stimInd)=currNoise(2,:);
end
noiseSTD= zeros(NStim,numOfPoints);
for i=1:NStim
    currNoise = createNoiseSweep(stimdur/stimdur_dt,stimStart+abs(0.5*stimStart),std+(dstim)*(i-1),tau,stimdur_dt);
    noiseSTD(i,prepulseInd+1:stimInd)=currNoise(2,:);
end
step = zeros(NStim,numOfPoints);
for i=1:NStim
    currStep = ones(1,stimdur/stimdur_dt)*(stimStart+dstim*(i-1));
    step(i,prepulseInd+1:stimInd)=currStep(1,:);
end
for f=[5 10 20 30 50 100]/1000
    sinsMean = zeros(NStim,numOfPoints);
    for i=1:NStim
        currSin = createSinSweep(stimdur/stimdur_dt,stimStart+dstim*(i-1),std,f,(ones(1,stimdur/stimdur_dt)*stimdur_dt));
        sinsMean(i,prepulseInd+1:stimInd)=currSin(1,:);
    end
    sinsSTD = zeros(NStim,numOfPoints);
    for i=1:NStim
        currSin = createSinSweep(stimdur/stimdur_dt,0,std +dstim*(i-1)*(1000*f/5),f,(ones(1,stimdur/stimdur_dt)*stimdur_dt));
        sinsSTD(i,prepulseInd+1:stimInd)=currSin(1,:);
    end
    
    figure;
    subplot(1,2,1);
    plot(sinsMean(selectedIndsStep,:)')
    subplot(1,2,2);
    plot(sinsSTD(selectedIndsSins,:)')
    nrn_mwrite([outfolder 'sinsMean' num2str(1000*f) '.dat'],sinsMean(selectedIndsStep,:));
    nrn_mwrite([outfolder 'sinsSTD' num2str(1000*f) '.dat'],sinsSTD(selectedIndsSins,:));
end
 nrn_mwrite([timesfolder,'/times.dat'],time);
 figure;
    subplot(1,2,1);
    plot(noiseMean(selectedIndsStep,:)')
    subplot(1,2,2);
    plot(noiseSTD(selectedIndsStep,:)')
 nrn_mwrite([outfolder 'noiseMean.dat'],noiseMean(selectedIndsStep,:));
 nrn_mwrite([outfolder 'noiseSTD.dat'],noiseSTD(selectedIndsStep,:));
 nrn_mwrite([outfolder 'Step.dat'],step(selectedIndsStep,:));

% %% AP stimulus
% NStim = 10;
% dstim = 0.25;
% prepulse = 200;
% prepulse_dt = 2;
% postpulse = 50;
% post = 800;
% stimdur = 2;
% APnumofpoints = prepulse/prepulse_dt+stimdur/stimdur_dt+postpulse/stimdur_dt + post/prepulse_dt;
% timesap = zeros(1,APnumofpoints);
% prepulseInd = prepulse/prepulse_dt+1;
% timesap(1:prepulseInd)=prepulse_dt;
% stimInd = prepulseInd + (stimdur+postpulse)/stimdur_dt;
% timesap(prepulseInd:stimInd)=stimdur_dt;
% post_ind = stimInd+post/prepulse_dt;
% timesap(stimInd:end) = prepulse_dt;    
% nrn_mwrite([timesfolder 'timesap.dat'],timesap);
% singleAP=zeros(NStim,APnumofpoints);
% for i=1:NStim
%     currsingleAP = ones(1,stimdur/stimdur_dt)*(0+((dstim)*i));
%     singleAP(i,prepulseInd+1:(prepulseInd+stimdur/stimdur_dt))=currsingleAP(1,:);
% end
% nrn_mwrite([outfolder 'singleAP.dat'],singleAP(:,:));
% figure;
% 
% plot(cumsum(timesap),singleAP');
