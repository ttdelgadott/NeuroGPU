close all
clear variables
clc
% 
% % % %fidTopo = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
% % % fidTopo = fopen('../Neuron/printCell/Output/realCellTopo.csv');
% fidTopo = fopen('../Neuron/printCell/Output/64T.csv');
% [Neuron Sim Stim] = ReadKForkTopology(fidTopo);
% % % %fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
% % % fidFmatrix = '../Neuron/printCell/output/realCellFmatrix.csv';
% fidFmatrix = '../Neuron/printCell/output/64F.csv';
% [Mats Traces] = readFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
% [OurMat Table]= createMatrixAsNEURONNew(Neuron);
% save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');
% cdebug_fid = fopen('C:\Users\Roy\Documents\SVN\VS\CN\NeuronC\Debug.dat');
% 

%%
load('realcell');
Neuron.HasHH=getHHsegs(Neuron);
% Stim.loc = 2;
%Stim.amp=5;
% [OurMat Table]= createMatrixAsNEURONNew(Neuron);
Table = squeeze(Mats(:,2:4,1));
OurMat = TableToMatrix(Table,Neuron);
%Stim.loc=9;
Nx = length(OurMat);
%Traces=Traces(2:end,:,:,:);
Neuron.Cms = createCmvec(Neuron.Cms,Neuron.NSegs);
% for seg=1:Nx
%     parentInds(seg) = getParentInd(Neuron,seg)
% end
% Neuron.ParentInds = parentInds;

%This is not working on a single compt cell
% [FN FNP FNM Aux]=CreatAuxiliaryData2R(OurMat,Nx,Neuron.NSegsMat, Neuron.Parent,cmVec);

[FN FNP FNM Aux]=CreatAuxiliaryData3(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),Neuron);
cmVec = Aux.Cms;
%TestAux(rot90(OurMat,2),Aux)
%%
TT=squeeze(Traces(:,1,3,1));

NRHS=squeeze(Mats(:,5,:));

NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4));
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
if(NSTATES>0)
    ParamsM=repmat([Neuron.GBars(1,:), Traces(4,1,1,5), Neuron.Es(1,3)],[Nx 1]);%gnabar gkbar gl el
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
Vs=Sim.Vs';
OldVs=Vs;
Vmid=OldVs'*0;
OrigDiag=diag(OurMat);
t=0;
% VHot(1)=Vs(InLoc);
AllVs(:,1)=Vs;
sumCurrents=OldVs*0;
% end
%%
for seg=1:Nx
    if(~Aux.boolHasHH(seg))
        continue;
    end
    [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=InitModel(Vs(seg));
end
AllStates(1,:,:)=StatesM;
NEURONStates=squeeze(Traces(1,:,:,9:11));
StimNeuronStates =squeeze(Traces(:,Stim.comp,1,9:11));
% Aux = debugAux(Aux);
rhss = zeros(1,Nx);
for i=1:Nt
    t=(i-1)*Sim.dt;
    AllVs(:,i)=Vs;
    VHot(i)=Vs(InLoc);
    rhss = zeros(1,Nx);
    D = zeros(1,Nx);
    for seg=1:Nx%ATTENTION the indices here have offset of +1 regarding to the ones in nrn_rhs at treeset.c
        if(seg==1)
            parentIndex=1;
        else
            parentIndex =Nx+1-Aux.Ks(Nx+2-seg);
        end
        Eidx=min(Nx,Nx+2-seg);
        
%         isHH = ~isempty(find(Neuron.HasHH==seg));
        isHH=Aux.boolHasHH(seg);
        if(isHH)
            [sumCurrentsDv(seg) sumConductivityDv(seg)]=BreakpointModel(Vs(seg)+0.001, StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
            [sumCurrents(seg) sumConductivity(seg)]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
            gHH = sumCurrentsDv(seg);
            rhsHH=sumCurrents(seg);
            gHH = (gHH-rhsHH)/0.001;
        else
            rhsHH=0;
            gHH=0;
        end
%         rhsStim = handleStim(Stim,seg,t);
        current=0;
        if(t>=Stim.del && t<Stim.del+Stim.dur && Stim.loc == seg)
            current = 100*Stim.amp/Stim.area;
        end

        if(t>=Stim.del)
            aa=5;
        end
        if(seg>1)
            rhss(seg)=rhss(seg)+current;
            rhss(seg)=rhss(seg)-rhsHH;
            if(~isHH)
                sumConductivity(seg)=0;
            end
            %         parentIndex = getParentInd(Neuron,seg);
            
            dv = Vs(parentIndex)-Vs(seg);
            rhss(1,seg) =rhss(1,seg) -Aux.f(Nx+1-seg)*dv;
            rhss(1,parentIndex) =rhss(1,parentIndex) +Aux.e(Eidx)*dv;
            % Taking care of the Diam
            
            D(seg) = sumConductivity(seg)+cmVec(seg)/(1000*Sim.dt);
            D(seg) = D(seg)-Aux.f(Nx+1-seg);
            %         parentIndex = getParentInd(Neuron,seg);
            D(parentIndex)=D(parentIndex) -Aux.e(Eidx); % Constant!!!
        end
    end
    
    for 
        D(parentIndex)=D(parentIndex) -Aux.e(Eidx); % Constant!!!
    end
    
    
    allRhss(i,:)=rhss(1,:);
    Diags(i,:)=D;
    
    if(t>1.49)
%         disp(t);%continue from here there is a problem that rhs are different.
    end
%     Crhs = fread(cdebug_fid, Nx, 'float32');
%     Cd = fread(cdebug_fid, Nx, 'float32');
%     
%     if(max(abs(rhss-Crhs')./max(1,rhss))>1e-6)
%         disp('Diff RHS');
%     end
%     if(max(abs(D-Cd')./D)>1e-7)
%         disp('Diff D');
%     end
    [OurDiag Vmid] = solveByNeuron(Nx,Aux,D,rhss,Neuron);
%         Vmid = fliplr(SolveByUs(Aux,fliplr(D),fliplr(rhss)));
%     VmidP = fliplr(SolveByUsP(Aux,fliplr(D),fliplr(rhss)));
    
    VmidToUse=Vmid;
    
    Vmids(:,i)=VmidToUse;
%     CVMid = fread(cdebug_fid, Nx, 'float32');
    Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;
    
    for seg=1:Nx
        isHH=Aux.boolHasHH(seg);
        if(isHH)            [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(Sim.dt, Vs(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
        end
    end
    AllStates(i+1,:,:)=StatesM;
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
fidVHot = fopen('../Data/VHotC.dat');
NVHotC = fread(fidVHot, 1, 'uint16');
VHotC = fread(fidVHot, NVHotC, 'float32');
fclose(fidVHot);
hold on;
plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),VHotC,'g');

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