a=importdata('dataForGili.xlsx');
Data=a.data.Sheet1(:,1:2);
figure;plot(Data);
SData=Data(100:9900,:);
figure;plot(SData);
%%
figure;clf;
NN=80;
subplot(2,1,1);
plot(SData(1:NN,1),'k'); hold on;
plot(SData(1:NN,2),'r-*');
legend({'NEURON?','NeuroGPU?'});
title('Two first spikes');
subplot(2,1,2);
plot(SData(end-NN+1:end,1),'k'); hold on;
plot(SData(end-NN+1:end,2),'r-*');
title('Two last spikes');
%%
Err=abs(diff(SData,[],2));
InSpike=SData(:,1)>-10;

BSpikeStart=diff(InSpike)>0;
FSpikeStart=find(BSpikeStart);
for i=1:numel(FSpikeStart)
    Is=max(1,FSpikeStart(i)-10):FSpikeStart(i)+20;
    MaxErr(i)=max(Err(Is));
    [~, MI]=max(SData(Is,j));
    for j=1:2
        HD(:,j)=interp1(0:6,SData(Is(MI-3:MI+3),j),0:0.01:6,'spline');
        [MaxV(i,j) alx(i,j)]=max(HD(:,j));
    end
    maxErr(i)=max(diff(HD,[],2));
end
figure;
% plot(MaxErr,'*');
subplot(1,3,1);
plot(abs(diff(alx,[],2))/100,'*');
title('Time difference');
subplot(1,3,2);
plot(diff(MaxV,[],2),'*');hold on
% plot(diff(MaxErr,[],2),'r*');
title('Error at peak');
subplot(1,3,3);
plot(MaxV,'*');
ylabel('peak height');
xlabel('Spike no.');
title('Peak height');