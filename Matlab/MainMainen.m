close all
clear variables
clc

 fidTopo = fopen('../Neuron/Mainen/OutPut/MainenPassiveTopo.csv');
 [Neuron Sim Stim] = ReadTopologyMainenPas(fidTopo);
  fidFmatrix ='../Neuron/Mainen/OutPut/MainenPassiveFM.csv';

 [Mats Traces] = readFmatrixMainenPas(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
 [OurMat Table]= createMatrixAsNEURONNew(Neuron);
 save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');

%%
% load('realcell');
Neuron.HasHH=getHHsegs(Neuron);
%Stim.amp=5;
% [OurMat Table]= createMatrixAsNEURONNew(Neuron);
Table = squeeze(Mats(:,2:4,1));
OurMat = TableToMatrix(Table,Neuron);
%Stim.loc=9;
Nx = length(OurMat);
%Traces=Traces(2:end,:,:,:);
Neuron.Cms = createCmvec(Neuron.Cms,Neuron.NSegs);
cmVec = Neuron.Cms;
for seg=1:Nx
    parentInds(seg) = getParentInd(Neuron,seg);
end
Neuron.ParentInds = parentInds;

%This is not working on a single compt cell
% [FN FNP FNM Aux]=CreatAuxiliaryData2R(OurMat,Nx,Neuron.NSegsMat, Neuron.Parent,cmVec);

[FN FNP FNM Aux]=CreatAuxiliaryData2(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),Neuron);

%TestAux(rot90(OurMat,2),Aux)
%%
TT=squeeze(Traces(:,1,3,1));

NRHS=squeeze(Mats(:,5,:));

%NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
NSTATES=0;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
ParamsM=repmat([Neuron.GBars(1,:)],[Nx 1]);%gnabar gkbar gl el
fidParamsM=fopen('../Data/ParamsM.mat','wb');
ParamsMByComp = ParamsM(1,:);
fwrite(fidParamsM,ParamsMByComp,'float32');
fclose(fidParamsM);
if(NSTATES>0)
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
for i=1:numel(Neuron.HasHH)
    seg=Neuron.HasHH(i);
    InitModelPass(Vs(seg));
end
rhss = zeros(1,Nx);
for i=1:(Nt)
    t=(i-1)*Sim.dt;
    AllVs(:,i)=Vs;
    VHot(i)=Vs(InLoc);
    rhss = zeros(1,Nx);
    D = zeros(1,Nx);
    for seg=2:Nx%ATTENTION the indices here have offset of +1 regarding to the ones in nrn_rhs at treeset.c
        isHH = ~isempty(find(Neuron.HasHH==seg));
        if (isHH)
            [sumCurrentsPass(seg) sumConductivityPass(seg)]=BreakpointModelPass(Vs(seg),Neuron.Es(seg,1),ParamsM(seg,1));
            [sumCurrentsPassDv(seg) sumConductivityPassDv(seg)]=BreakpointModelPass(Vs(seg)+0.001,Neuron.Es(seg,1),ParamsM(seg,1));
            gPas = sumCurrentsPassDv(seg);
            rhsPas=sumCurrentsPass(seg);
            gPas = (gPas-rhsPas)/0.001;
        else
            rhsPas=0;
            gPas=0;
        end
        rhsStim = handleStim(Stim,seg,t);
        rhss(seg)=rhss(seg)+rhsStim;
        rhss(seg)=rhss(seg)-rhsPas;
    %end
    sumConductivityPass(cmVec==0)=0;
    %for seg=2:Nx
        
        %sumCurrents(cmVec==0)=0;
        parentIndex = getParentInd(Neuron,seg);
        % parentIndex =  Nx+1-Aux.Ks(Nx+2-(seg));
        
        %rhss(seg) = handleStim(Stim,seg,t) - sumCurrents(seg);
        
        dv = Vs(parentIndex)-Vs(seg);
        %         rhss(1,seg) =rhss(1,seg) -getNODEB(OurMat,seg)*dv;
        %         AllNodeBs(seg)=getNODEB(OurMat,seg);
        rhss(1,seg) =rhss(1,seg) -Aux.f(Nx+1-seg)*dv;
        %         rhss(1,parentIndex) =rhss(1,parentIndex) +getNODEA(OurMat,seg)*dv;
        rhss(1,parentIndex) =rhss(1,parentIndex) +Aux.e(Nx+2-seg)*dv;
        
        %         AllNodeAs(seg)=getNODEA(OurMat,seg);
        %         sumCurrents(seg) =sumCurrents(seg)+current;
        %         if(cmVec(seg)==0)
        %             rhss(seg)=0;
        %         end
        D(seg) = sumConductivityPass(seg)+cmVec(seg)/(1000*Sim.dt);
        D(seg) = D(seg)-Aux.f(Nx+1-seg);
        parentIndex = getParentInd(Neuron,seg);
        % parentIndex =  Nx+1-Aux.Ks(Nx+2-(seg));
        D(parentIndex)=D(parentIndex) -Aux.e(Nx+2-seg);
    end
    
    allRhss(i,:)=rhss(1,:);
    
    %     sumConductivity(cmVec==0)=0;
    %     sumCurrents(cmVec==0)=0;
    %OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*Sim.dt);%Update matrix
    OurMat(eye(Nx)>0)=D;
    OurDiag=OurMat(eye(Nx)>0)';
    Diags(i,:)=OurDiag;
    
    if(t>1.49)
        disp(t);%continue from here there is a problem that rhs are different.
    end
    %     [OurDiagX Vmid2] = solveByNeuron(Nx,Aux,OurDiag,rhss,Neuron);
%     Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(rhss)));
    VmidP = fliplr(SolveByUsP(Aux,fliplr(OurDiag),fliplr(rhss)));
    
    VmidToUse=VmidP;
    Vmids(:,i)=VmidToUse;
        for j=1:numel(Neuron.HasHH)
            seg=Neuron.HasHH(j);
            DerivModelPass();
        end
    
    %     OldVs=Vs;
    
    Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;
    
    
end
figure(11);
plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),allRhss(1:end,Stim.loc));
hold on;
plot(squeeze(Traces(2:end,1,3,1)),NRHS(Stim.loc,1:end),'r');
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
figure(22);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,2:end));
hold on;
plot(squeeze(Traces(2:end,1,3,1)),squeeze(Traces(2:end,1,3,2)),'r');
%
figure(46);clf;
fidVHot = fopen('../Data/VHotC.dat');
NVHotC = fread(fidVHot, 1, 'uint16');
VHotC = fread(fidVHot, NVHotC, 'float32');
fclose(fidVHot);
plot(VHotC);

%
% AD=1:19;
%
% Aux2.e=(0:18)*2+1;
% Aux2.f=(0:18)*3+1;
% BRHS=(0:18)*4+1;
% Aux2.Ks=Aux.Ks;
% VV=(SolveByUs(Aux2,AD,BRHS))';
ourStates = squeeze(AllStates(:,2,:));
figure(56);
subplot(3,1,1);
plot(ourStates(:,1));
hold on
plot(StimNeuronStates(:,1),'r');

subplot(3,1,2);
plot(ourStates(:,2));
hold on
plot(StimNeuronStates(:,2),'r');

subplot(3,1,3);
plot(ourStates(:,3));
hold on
plot(StimNeuronStates(:,3),'r');