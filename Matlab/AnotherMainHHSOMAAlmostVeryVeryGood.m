close all
clc

%First finish HH by our, only then fork.
[conductances nums mats diags parents childs rhs NSeg L diam Ra cm dt stdel stdur stamp vinit gnabar_hh gkbar_hh ek ena el_hh] = readFmatrixHHSoma();
%  1 2     3          4         5        6    7      8        9      10->11
% ,t,v(0),gk_hh(0),gna_hh(0),gl_hh(0),ik(0),ina(0),il_hh(0),m_hh(0),h_hh(0),n_hh(0),minf,mtau)
[OurMat Table]= createMatrixAsNEURONOnlySoma(L,diam,NSeg,Ra);
%Table =addCms(Table,cm,dt);
%compareTables(1,Table,diags,parents,childs,rhs);
nums = nums(2:end,:,:);
Nx = length(OurMat);
%%
TT=squeeze(nums(:,3,1));

Stim.area = pi*diam*L/NSeg;

StimByItself=TT*0;
StimActiveTB=TT>=stdel & TT<=(stdel+stdur);
StimActiveT=find(StimActiveTB);
StimByItself(StimActiveT(1))=100*stamp/Stim.area;
StimByItself(StimActiveT(2:end))=100*stamp/(Stim.area*NSeg);


NRHS=squeeze(mats(:,5,:));
NV=squeeze(nums(:,3,2));
dNV=[0; diff([NV])];
% % Bla=dNV*cm/(1000*dt);
NsumCurrent=sum(squeeze(nums(:,3,6:8)),2);
dNsumCurrent=diff([0 NsumCurrent(1:end)']);
Bla=-dNsumCurrent(1:end)'+dNV(1:end)*cm/(1000*dt);
figure(83745);clf;
plot(TT,NRHS(4,1:end)); %   -dNV(1:end)*cm/(1000*dt);
hold on;
plot(TT,-NsumCurrent+StimByItself,'r');

StimByItselfOff=StimByItself;
StimByItselfOff(StimActiveT(1))=0;

NsumCurrent=sum(squeeze(nums(:,3,6:8)),2);
figure(83746);clf;
plot(TT,NRHS(3,1:end)); %   -dNV(1:end)*cm/(1000*dt);
hold on;
plot(TT,-NsumCurrent+StimByItselfOff,'r');

NsumCurrent=sum(squeeze(nums(:,2,6:8)),2);
figure(83747);clf;
plot(TT,NRHS(2,1:end)); %   -dNV(1:end)*cm/(1000*dt);
hold on;
plot(TT,-NsumCurrent+StimByItselfOff,'r');

% TmpMat=OurMat;
% TmpMat(eye(Nx)>0)=diag(OurMat)+cmVec'/(1000*dt);
% 
% TmpStim=cmVec*0;
% TmpStim(InLoc)=100*stamp/Stim.area;
% 
% (TmpMat\(TmpStim)'.*(cmVec./(1000*dt))
%%
mDeriv=(nums(3,5,9)-nums(2,5,9))/dt;
m0=nums(1,5,9);
tminf=nums(3,5,12);
tmtau=nums(3,5,13);

(tminf-m0)/tmtau-mDeriv;


hDeriv=(nums(3,5,10)-nums(2,5,10))/dt;
h0=nums(1,5,10);
thinf=nums(3,5,14);
thtau=nums(3,5,15);

(thinf-h0)/thtau-hDeriv;




[zminf, ~, ~, zmtau]=rates(85);

(zminf-m0)/zmtau-mDeriv;
%%
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
ParamsM=repmat([gnabar_hh,gkbar_hh, nums(1,1,5), el_hh],[Nx 1]);
StatesM=zeros([Nx NSTATES]);
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
Stim.area = pi*diam*L/NSeg;
%% Now running

%dt=0.001;

cmVec = ones(1,Nx).*cm;
cmVec(1)=0;
cmVec(end)=0;
InLoc=4;
OutLoc=4;
NeuronOutLoc=3;
TFinal=10;
Nt=ceil(TFinal./dt);
Ns=sum(NSeg);
Vs=ones(1,Nx)*vinit;
OldVs=Vs;
Vmid=OldVs'*0;
OrigDiag=diag(OurMat);
t=0;
VHot(1)=Vs(OutLoc);
AllVs(:,1)=Vs;
sumCurrents=OldVs*0;
%%
for seg=1:Nx
    [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=InitModel(Vs(seg));
end
AllStates(1,:,:)=StatesM;
NEURONStates=squeeze(nums(1,:,9:11));
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
totalDiff=Vs.*0;

for i=1:(Nt-1)
    t=i*dt;
    
    if (t>stdel && t<=(stdel+stdur+dt*30))
        StimICurr(InLoc) = 100*stamp/Stim.area;
    else
        StimICurr(InLoc)=0;
    end
    StimDiffPrev=StimDiff;
    StimDiff = StimICurr-StimPrev-sumCurrents;
    StimPrev = StimICurr;
    
    
    % Before matrix
    OldSumCurrents=sumCurrents;
    for seg=1:Nx
        [sumCurrents(seg) sumConductivity(seg)]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
    end
    sumConductivity([1 end])=0;
    sumCurrents([1 end])=0;
    OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*dt);%Update matrix
    OurDiag=OurMat(eye(Nx)>0)';
    
    NEURONsumCurrent=sum(squeeze(nums(i+1,:,6:8)),2)';
    NEURONsumConductivity=sum(squeeze(nums(i,:,3:4)),2)';
    NEURONDiag=squeeze(mats(:,4,i))';
    NEURONRHS=squeeze(mats(:,5,i))';
%     NewRHS = -sumCurrents+StimDiff + (Vs-OldVs).*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;

       % NewRHS = -[0 NEURONsumCurrent 0]+StimDiff + (Vs-OldVs).*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;
        NEURONsumCurrentPrev=sum(squeeze(nums(max(1,i),:,6:8)),2)';
        if(i==1)
            NEURONsumCurrentPrev=NEURONsumCurrentPrev*0;
        end
        NEURONsumCurrentDiff=NEURONsumCurrent-NEURONsumCurrentPrev;
        DiffCurrents=sumCurrents-OldSumCurrents;
%        NewRHS = -[0 NEURONsumCurrentDiff 0]+StimDiff+[0 (squeeze(nums(i+1,:,2))-squeeze(nums(max(1,i),:,2))) 0].*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;
%        NewRHS = -DiffCurrents+StimDiff+[0 (squeeze(nums(i+1,:,2))-squeeze(nums(max(1,i),:,2))) 0].*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;
        NewRHS = -[0 NEURONsumCurrentDiff 0]+[0 (squeeze(nums(i+1,:,2))-squeeze(nums(max(1,i),:,2))) 0].*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;
       
%        NewRHS=-DiffCurrents+StimDiff+Vmid'.*(cmVec./(1000*dt));
       
%        NewRHS = Vmid'.*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;

%     NewRHS=-[0 NEURONsumCurrent 0];
%     NewRHS=-sumCurrents+StimDiffPrev;
%    OurDiag=NEURONDiag;
%      NewRHS=NEURONRHS;
    NewRHS=-sumCurrents;
    NewRHS(InLoc)=NewRHS(InLoc)+StimByItself(i);
    NotLoc=[2:(InLoc-1) (InLoc+1):(numel(NewRHS)-1)];
    NewRHS(NotLoc)=NewRHS(NotLoc)+StimByItselfOff(i);
    OurMat(eye(Nx)>0)=OurDiag;
    DiffCurr=sumCurrents(2:end-1)-NEURONsumCurrent;
    DiffRHS=NEURONRHS-NewRHS;
    DiffCond=sumConductivity(2:end-1)-NEURONsumConductivity;
    DiffDiag=NEURONDiag-OurDiag;
%     (NEURONDiag(3)-125)/sumConductivity(2)
    if(sum(abs(DiffCond))>10^-2)
        disp('Cond');
    end
    if(sum(abs(DiffRHS))>10^-4)
        disp('DiffRHS');
    end
    if(sum(abs(DiffDiag./NEURONDiag))>10^-2)
        disp('DiffDiag');
    end
    Vmid=OurMat\NewRHS';
    
    for seg=1:Nx
        [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(dt, Vs(seg)+Vmid(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
    end
    AllStates(i+1,:,:)=StatesM;

    OldVs=Vs;
    
    Vs=Vs+Vmid'; %like 2*Vmid - Vs ???;
    
        
    currNeuronV = nums(min(i+2,end),NeuronOutLoc,2);
    DiffV= currNeuronV'-Vs(OutLoc);
    if(abs(DiffV./nums(i,NeuronOutLoc,2))>10^-1)
        disp('diffV');
    end
    
%     A=OurMat;
%     A(eye(Nx)>0)=squeeze(mats(:,4,i))';
%     A\squeeze(mats(:,5,i))
    
    VHot(i)=Vs(OutLoc);
    AllVs(:,i)=Vs;
end
figure(11);
plot(dt:dt:(TFinal-dt),VHot(1:end));
hold on;
plot(nums(1:end,NeuronOutLoc,1),nums(1:end,NeuronOutLoc,2),'r');
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))

% safsdf
return;
%%
%V - figure;plot(squeeze(nums(:,4,2)))

AA=NRHS(4,1:end)'+NsumCurrent-StimByItself;
max(abs(AA))
figure;plot(TT,AA)

AA=NRHS(4,1:end)'+NsumCurrent.*(~StimActiveTB)-StimByItself.*(StimActiveTB);
max(abs(AA))
figure;plot(TT,AA)


100*stamp/Stim.area
100*stamp/(Stim.area*NSeg)


StimMSumCur=StimByItself-NsumCurrent;
figure;plot((StimByItself))


%stamp = iamps(i);
    if (t>Stim.del && t<=(Stim.del+Stim.dur))
        StimICurr(InLoc) = 100*Stim.amp/Stim.area+NsumCurrent;
    else
        StimICurr(InLoc)=0;
    end
    StimDiff = StimICurr-StimPrev;
    StimPrev = StimICurr;

StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);




plot(Bla,'r');
% 
% figure(182635);clf;
% plot(NRHS(3,3:end)-Bla(3:end-1)')