close all
clear variables
% Sim should have only one Vs
% and cm?

clc

%First finish HH by our, only then fork.
fidVHot = fopen('../Data/VHotC.dat');
fidTopo = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
[Neuron Sim Stim] = ReadKForkTopology(fidTopo);
fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
[Mats Traces] = readFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
Nx = length(OurMat);
Traces=Traces(2:end,:,:,:);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
[FN FNP FNM Aux]=CreatAuxiliaryData2(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),cmVec);

TestAux(rot90(OurMat,2),Aux)
%%
TT=squeeze(Traces(:,1,3,1));



StimByItself=TT*0;
StimActiveTB=TT>=Stim.del & TT<=(Stim.del+Stim.dur);
StimActiveT=find(StimActiveTB);
StimByItself(StimActiveT(1))=100*Stim.amp/Stim.area;
StimByItself(StimActiveT(2:end))=100*Stim.amp/(Stim.area*sum(Neuron.NSegs)); % Probaly will not work with different diams, etc... - check Alon


NRHS=squeeze(Mats(:,5,:));

NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
figure(83745);clf;
plot(TT,NRHS(4,1:end));
hold on;
plot(TT,-NsumCurrent(:,1)+StimByItself,'r');

StimByItselfOff=StimByItself;
StimByItselfOff(StimActiveT(1))=0;

NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
figure(83746);clf;
plot(TT,NRHS(16,1:end));
hold on;
plot(TT,-NsumCurrent(:,1)+StimByItselfOff,'r');


%%
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
ParamsM=repmat([Neuron.GBars(1,:), Traces(1,1,1,5), Neuron.Es(1,3)],[Nx 1]); % BAD - By comp
fidParamsM=fopen('../Data/ParamsM.mat','wb');
ParamsMByComp = ParamsM(1,:);
fwrite(fidParamsM,ParamsMByComp,'float32');
fclose(fidParamsM);
StatesM=zeros([Nx NSTATES]);
%% Now running
InLoc=Stim.loc;
Nt=ceil(Sim.Tfinal./Sim.dt);
Ns=sum(Neuron.NSegs);
Vs=ones(1,Nx)*Sim.Vs(1);
OldVs=Vs;
Vmid=OldVs'*0;
OrigDiag=diag(OurMat);
t=0;
VHot(1)=Vs(InLoc);
AllVs(:,1)=Vs;
sumCurrents=OldVs*0;
%%
for seg=1:Nx
    [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=InitModel(Vs(seg));
end
AllStates(1,:,:)=StatesM;
NEURONStates=squeeze(Traces(1,:,:,9:11));
%%
for i=1:(Nt-1)
    t=i*Sim.dt;
    for seg=1:Nx
        [sumCurrents(seg) sumConductivity(seg)]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
    end
    sumConductivity(cmVec==0)=0;
    sumCurrents(cmVec==0)=0;
    OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*Sim.dt);%Update matrix
    OurDiag=OurMat(eye(Nx)>0)';
    
    NEURONsumCurrent=sum(squeeze(Traces(i,:,:,6:8)),3)';
    NEURONsumConductivity=sum(squeeze(Traces(i,:,:,3:4)),3)';
    NEURONDiag=squeeze(Mats(:,4,i))';
    NEURONRHS=squeeze(Mats(:,5,i))';
    
    NewRHS=-sumCurrents; 
    NewRHS(InLoc)=NewRHS(InLoc)+StimByItself(i);
    NotLoc=setdiff(1:Nx,[InLoc find(cmVec==0)]);
    NewRHS(NotLoc)=NewRHS(NotLoc)+StimByItselfOff(i);

%     Vmid=OurMat\NewRHS';
    
    Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(NewRHS)))';
    for seg=1:Nx
        [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(Sim.dt, Vs(seg)+Vmid(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
    end
    AllStates(i+1,:,:)=StatesM;
    
    OldVs=Vs;
    
    Vs=Vs+Vmid'; %like 2*Vmid - Vs ???;
            
    VHot(i)=Vs(InLoc);
    AllVs(:,i)=Vs;
end
figure(11);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),VHot(1:end));
hold on;
plot(squeeze(Traces(:,Stim.comp,3,1)),squeeze(Traces(:,Stim.comp,3,2)),'r');
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
figure(22);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,:));
hold on;
plot(squeeze(Traces(:,2,3,1)),squeeze(Traces(:,2,3,2)),'r');
figure(45);
fidVHot = fopen('../Data/VHotC.dat');

NVHotC = fread(fidVHot, 1, 'uint16');
VHotC = fread(fidVHot, NVHotC, 'float32');
plot(VHotC);

