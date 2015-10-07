Adj={1}; 
close all

%First finish HH by our, only then fork.
[conductances nums mats diags parents childs rhs NSeg L diam Ra cm dt stdel stdur stamp vinit gnabar_hh gkbar_hh ek ena el_hh] = readFmatrixHHSoma();
%  1 2     3          4         5        6    7      8        9      10->11
% ,t,v(0),gk_hh(0),gna_hh(0),gl_hh(0),ik(0),ina(0),il_hh(0),m_hh(0),h_hh(0),n_hh(0),minf,mtau)
[OurMat Table]= createMatrixAsNEURON(L,diam,NSeg,Ra,Adj);
%Table =addCms(Table,cm,dt);
%compareTables(1,Table,diags,parents,childs,rhs);
Nx = length(OurMat);
%%
mDeriv=(nums(3,5,9)-nums(2,5,9))/dt;
m0=nums(1,5,9);
tminf=nums(3,5,12);
tmtau=nums(3,5,13);

(tminf-m0)/tmtau-mDeriv


hDeriv=(nums(3,5,10)-nums(2,5,10))/dt;
h0=nums(1,5,10);
thinf=nums(3,5,14);
thtau=nums(3,5,15);

(thinf-h0)/thtau-hDeriv




[zminf, ~, ~, zmtau]=rates(85);

(zminf-m0)/zmtau-mDeriv
%%
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
ParamsM=repmat([gnabar_hh,gkbar_hh, nums(1,1,5), el_hh],[Nx 1]);
StatesM=zeros([Nx NSTATES]);
%% Now running

%dt=0.001;

cmVec = ones(1,Nx).*cm;
cmVec(1)=0;
cmVec(end)=0;
InLoc=7;
OutLoc=7;
TFinal=2;
Nt=ceil(TFinal./dt);
Ns=sum(NSeg);
Vs=ones(1,Nx)*vinit;
OldVs=Vs;
OrigDiag=diag(OurMat);
t=0;
v0s = ones(1,Nx)*vinit;
%%
for seg=1:Nx
    [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=InitModel(Vs(seg));
end
AllStates(1,:,:)=StatesM;
NEURONStates=squeeze(nums(1,:,9:11))
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
totalDiff=Vs.*0;
% for i=1:(Nt)
    i=1
    t=i*dt;
    % Before matrix
    for seg=1:Nx
        [sumCurrents(seg) sumConductivity(seg)]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
    end
    sumConductivity([1 end])=0;
    sumCurrents([1 end])=0;
    TmpVec2=-sumCurrents;
    OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*dt);%Update matrix
    OurDiag=OurMat(eye(Nx)>0)'
    NEURONsumCurrent=sum(squeeze(nums(1,:,6:8)),2)';
    NEURONsumConductivity=sum(squeeze(nums(1,:,3:4)),2)';
    NEURONDiag=squeeze(mats(:,4,1))';
    NEURONRHS=squeeze(mats(:,5,1))';
    NEURONRHS-TmpVec2
    sumConductivity(2:end-1)-NEURONsumConductivity
    NEURONDiag-OurDiag
    (NEURONDiag(3)-125)/sumConductivity(2)
    Vmid=OurMat\TmpVec2';
    Vs=Vs+2*Vmid'; %like 2*Vmid - Vs ???;
    
    for seg=1:Nx
        [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(dt, Vs(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
    end
    
    
    currNeuronV = neuronV(i);
    DiffV= currNeuronV'-Vs;
    DiffDiag = diag(OurMat) - diags(:,i);
    
    totalDiff = totalDiff+sum(abs(DiffV));
    
    if(sum(abs(DiffDiag))>0.001)
        disp('asdasd');
    end
    VHot(i)=Vs(OutLoc);
    AllVs(:,i)=Vs;
% end
figure(11);
plot(dt:dt:TFinal,VHot);
% figure(22);
hold on;
plot(neuronT,neuronV,'r');
figure(33)
plot(neuronT,(neuronV-VHot'))
%See VHot?
%%
%HH! (see stEfork, but use gk of NEURON)
 %   use the NMODL stuff of MainM
    
    