close all
clear variables
clc
%First finish HH by our, only then fork.

fidTopo = fopen('../Neuron/printCell/Output/ForkTopoHH.csv');
[Neuron Sim Stim] = ReadKForkTopology(fidTopo);
fidFmatrix = '../Neuron/printCell/output/fmatrixForkHH.csv';
[Mats Traces] = readFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
% [OurMat Table]= createMatrixAsNEURONNew(Neuron);

% save('BTreeHHTopo','Neuron', 'Sim', 'Stim','Mats', 'Traces');
%%
% load('BTreeHHTopo');
% Stim.amp=Stim.amp*100;
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
% Table = squeeze(Mats(:,2:4,1));
% OurMat = TableToMatrix(Table,Neuron);

Nx = length(OurMat);
Traces=Traces(2:end,:,:,:);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
%This is not working on a single compt cell
[FN FNP FNM Aux]=CreatAuxiliaryData2(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),cmVec);

%TestAux(rot90(OurMat,2),Aux)
%%
TT=squeeze(Traces(:,1,3,1));

NRHS=squeeze(Mats(:,5,:));

NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
% figure(83745);clf;
% plot(TT,NRHS(4,1:end));
% hold on;
% plot(TT,-NsumCurrent(:,1),'r');
% 
% NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
% figure(83746);clf;
% plot(TT,NRHS(4,1:end));
% hold on;
% plot(TT,-NsumCurrent(:,1),'r');
%%
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
if(NSTATES>0)
    ParamsM=repmat([Neuron.GBars(1,:), Traces(1,1,1,5), Neuron.Es(1,3)],[Nx 1]); % BAD - By comp
    fidParamsM=fopen('../Data/ParamsM.mat','wb');
    ParamsMByComp = ParamsM(1,:);
    fwrite(fidParamsM,ParamsMByComp,'float32');
    fclose(fidParamsM);
    StatesM=zeros([Nx NSTATES]);
end
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
fid=fopen('C:\Users\Roy\Documents\NeuroGPU\VS\CN\NeuronC\debug.dat','rb');
for i=1:500
    Crhs(:,i)=fread(fid,Nx,'float');
    Cd(:,i)=fread(fid,Nx,'float');
    CVMids(:,i)=fread(fid,Nx,'float');
end
fclose(fid);

for i=1:(Nt-1)
    rhss = zeros(1,Nx);
    t=(i-1)*Sim.dt;
    
    
    for seg=2:Nx%ATTENTION the indices here have offset of +1 regarding to the ones in nrn_rhs at treeset.c
        if(NSTATES>0)
            [sumCurrents(seg) sumConductivity(seg)]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
        end
        sumConductivity(cmVec==0)=0;
        sumCurrents(cmVec==0)=0;
%         parentIndex = getParentInd(Neuron,seg);
        parentIndex =  Nx+1-Aux.Ks(Nx+2-(seg));
        parentIndexs(seg)=parentIndex;
        rhss(1,seg) = handleStim(Stim,seg,t) - sumCurrents(seg);
        dv = Vs(parentIndex)-Vs(seg);
%         rhss(1,seg) =rhss(1,seg) -getNODEB(OurMat,seg)*dv;
%         AllNodeBs(seg)=getNODEB(OurMat,seg);
        rhss(1,seg) =rhss(1,seg) -Aux.f(Nx+1-seg)*dv;
%         rhss(1,parentIndex) =rhss(1,parentIndex) +getNODEA(OurMat,seg)*dv;
        rhss(1,parentIndex) =rhss(1,parentIndex) +Aux.e(Nx+2-seg)*dv;
%         AllNodeAs(seg)=getNODEA(OurMat,seg);
%         sumCurrents(seg) =sumCurrents(seg)+current;
    end
    allRhss(i,:)=rhss(1,:);
%     sumConductivity(cmVec==0)=0;
%     sumCurrents(cmVec==0)=0;
    OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*Sim.dt);%Update matrix
    OurDiag=OurMat(eye(Nx)>0)';
    Diags(i,:)=OurDiag;
    
%     NEURONsumCurrent=sum(squeeze(Traces(i,:,:,6:8)),3)';
%     NEURONsumConductivity=sum(squeeze(Traces(i,:,:,3:4)),3)';
%     NEURONDiag=squeeze(Mats(:,4,i))';
%     NEURONRHS=squeeze(Mats(:,5,i))';
%     
%     NewRHS=-sumCurrents; 
   % NewRHS(InLoc)=NewRHS(InLoc)+StimByItself(i);
   % NotLoc=setdiff(1:Nx,[InLoc find(cmVec==0)]);
   %NewRHS(NotLoc)=NewRHS(NotLoc)+StimByItselfOff(i);

%     Vmid=OurMat\rhss';
    
   Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(rhss)))';
   Vmids(:,i)=Vmid;
    if(NSTATES>0)
        for seg=1:Nx
            [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(Sim.dt, Vs(seg)+Vmid(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
        end
        AllStates(i+1,:,:)=StatesM;
    end

%     OldVs=Vs;
    
    Vs=Vs+Vmid'; %like 2*Vmid - Vs ???;
            
    VHot(i)=Vs(InLoc);
    AllVs(:,i)=Vs;
end
figure(11);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),allRhss(1:end,Stim.loc));
hold on;
plot(squeeze(Traces(:,Stim.comp,3,1)),NRHS(Stim.loc,1:end),'r');
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
figure(22);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,:));
hold on;
plot(squeeze(Traces(:,1,3,1)),squeeze(Traces(:,1,3,2)),'r');
%%
figure(45);clf;
fidVHot = fopen('../Data/VHotC.dat');
NVHotC = fread(fidVHot, 1, 'uint16');
VHotC = fread(fidVHot, NVHotC, 'float32');
fclose(fidVHot);
plot(VHotC);

%%
AD=1:19;

Aux2.e=(0:18)*2+1;
Aux2.f=(0:18)*3+1;
BRHS=(0:18)*4+1;
Aux2.Ks=Aux.Ks;
VV=(SolveByUs(Aux2,AD,BRHS))';