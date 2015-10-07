%Amit - Main
NeuroGPUInit
cd([BaseP 'Matlab']);
% addpath(genpath('./Amit/'));
%%
close all
clear variables
NeuroGPUInit
clc

FN_Topo=[BaseP 'Neuron/printCell/Amit/Output/64T.csv'];
FN_TopoF=[BaseP 'Neuron/printCell/Amit/Output/64F.csv'];
FN_TopoPP=[BaseP 'Neuron/printCell/Amit/Output/64PP.csv'];
FN_TopoMDL=[BaseP 'Neuron/printCell/Amit/Output/64MDL.csv'];

%%DOCUMENTATION_REF_001
%Indices for all the mechanism funcs throughout the program.
%(global - not ideal, could use function that return the value instead)
global INIT_INDEX 
global CURRENT_INDEX
global STATES_INDEX
INIT_INDEX= 1;
CURRENT_INDEX = 2;
STATES_INDEX = 3;
global NUM_OF_FUNCS_PER_MODEL
NUM_OF_FUNCS_PER_MODEL = 3;

%%DOCUMENTATION_REF_002C
% MainBasicDefinitions;
hocFileData;
% Now automatic:
%FN='neurogpu\Neuron\printCell\Amit\printCellBinaryK64 - 3.hoc';
%ParseHocFile;
% [names values]=readMechanisms(FN);
%%
%fidTopo = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
% fidTopo = fopen('../Neuron/printCell/Output/realCellTopo.csv');
% fidTopo = fopen(FN_Topo);      
[Neuron Sim Stim] = ReadKForkTopology2(FN_Topo);
%fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
% fidFmatrix = '../Neuron/printCell/output/realCellFmatrix.csv';
fidFmatrix = FN_TopoF;
hasF=false;
if(hasF)
    [Mats Traces] = AmitReadFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
end
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
if(hasF)
    save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');
else
    save('realcell','Neuron', 'Sim', 'Stim');
end

%%DOCUMENTATION_REF_003
numOfSegs = sum(Neuron.NSegsMat);
varsPerModelPerSeg = zeros(numOfSegs, NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_PER_SEG);
varsPerModelAllSegs = zeros (NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_ALL_SEGS);
constsPerModelAllSegs = zeros(NUM_OF_MODELS, MAX_NUM_CONSTS_PER_MODEL);
constsAllModelsAllSegs = zeros(1, MAX_NUM_CONSTS_GLOBAL);
%%
dgs = zeros(1, numOfSegs);
%%
%DOCUMENTATION_REF_004C     THE INITIALIZE FUNCTION
[varsPerModelPerSeg, varsPerModelAllSegs, constsPerModelAllSegs,...
    constsAllModelsAllSegs, hasModel, Vs, rhss, D, parentIndexes] = ...
    initialize( varsPerModelPerSeg, varsPerModelAllSegs, constsPerModelAllSegs,...
    constsAllModelsAllSegs, Neuron, ModelsFuncsNames, Sim, numOfSegs, NUM_OF_MODELS);
%%
% load('realcell');
Neuron.HasHH=AmitGetHHsegs(Neuron); 
%Stim.loc = 2;
%Stim.amp=5;
% [OurMat Table]= createMatrixAsNEURONNew(Neuron);
Table = squeeze(Mats(:,2:4,1));
OurMat = TableToMatrix(Table,Neuron);
%Stim.loc=9;
Nx = length(OurMat);
%Traces=Traces(2:end,:,:,:);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
%This is not working on a single compt cellat,Nx,Neuron.NSegsMat, Neuron.Parent,cmVec);

[FN FNP FNM Aux]=CreatAuxiliaryData3(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),Neuron);
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
    TmpGb=[.12 .036 .0003]*0;
    TmpE=-54.3*0;
%     ParamsM=repmat([Neuron.GBars(1,:), Traces(4,1,1,5), Neuron.Es(1,3)],[Nx 1]);%gnabar gkbar gl el
    ParamsM=repmat([TmpGb, Traces(4,1,1,5), TmpE],[Nx 1]);%gnabar gkbar gl el
    fidParamsM=fopen('../Data/ParamsM.mat','wb');
    ParamsMByComp = ParamsM(1,:);
    fwrite(fidParamsM,ParamsMByComp,'float32');
    fclose(fidParamsM);
end
%% Now running
InLoc=Stim.loc;
Nt=ceil(Sim.Tfinal./Sim.dt);
Ns=sum(Neuron.NSegs);
OldVs=Vs;
Vmid=OldVs'*0;
OrigDiag=diag(OurMat); 
t=0;
VHot(1)=Vs(InLoc);
AllVs(:,1)=Vs;
sumCurrents=OldVs*0;
% end
%%
%AllStates(1,:,:) = varsPerModelPerSeg(:, MAINENNA_INDEX, :);
NEURONStates=squeeze(Traces(1,:,:,9:11));
global MyData;
MyData = zeros(1,Nx);
NeuronData = squeeze(Traces(:,Stim.comp,1,7:7));
% Aux = debugAux(Aux);
tic;
for i=1:(Nt)
    t=(i-1)*Sim.dt;
    if(mod(t*100,10)<1)
        disp(t);
    end
    AllVs(:,i)=Vs;
    VHot(i)=Vs(InLoc);
    rhss = zeros(1,Nx);
    D = zeros(1,Nx);
    %DOCUMENTATION_REF_005C
    [rhss dgs varsPerModelPerSeg] = nrnRhs (rhss, dgs, t, Vs, hasModel, varsPerModelPerSeg, varsPerModelAllSegs,...
        constsPerModelAllSegs, constsAllModelsAllSegs, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);

    dgs(cmVec==0)=0;
    for seg=2:Nx
        parentIndex = parentIndexes(seg); 
        dv = Vs(parentIndex)-Vs(seg);
        rhss(1,seg) =rhss(1,seg) -Aux.f(Nx+1-seg)*dv;
        rhss(1,parentIndex) =rhss(1,parentIndex) +Aux.e(Nx+2-seg)*dv;
    end

    for seg=2:Nx
        D(seg) = dgs(seg)+cmVec(seg)/(1000*Sim.dt);
    end
    
    
    for seg=2:Nx
        D(seg) = D(seg)-Aux.f(Nx+1-seg);
        parentIndex = parentIndexes(seg);        
        D(parentIndex)= D(parentIndex) -Aux.e(Nx+2-seg);
    end
    
    allRhss(i,:)=rhss(1,:);
    
    %     sumConductivity(cmVec==0)=0;
    %     sumCurrents(cmVec==0)=0;
    %OurMat(eye(Nx)>0)=OrigDiag'+sumConductivity+cmVec./(1000*Sim.dt);%Update matrix
    OurMat(eye(Nx)>0)=D;
    OurDiag=OurMat(eye(Nx)>0)';
    Diags(i,:)=OurDiag;
    
%         [OurDiagX Vmid2] = solveByNeuron(Nx,Aux,OurDiag,rhss,Neuron);
    Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(rhss)));
%     VmidP = fliplr(SolveByUsP(Aux,fliplr(OurDiag),fliplr(rhss)));
    
    VmidToUse=Vmid;
    Vmids(:,i)=VmidToUse;
    VsNew = Vs+VmidToUse;
    %DOCUMENTATION_REF_006C
    [varsPerModelPerSeg varsPerModelAllSegs] = deriveModels(Sim.dt, VsNew, hasModel, varsPerModelPerSeg, varsPerModelAllSegs,...
        constsPerModelAllSegs, constsAllModelsAllSegs, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);

      %AllStates(i+1,:,:) = varsPerModelPerSeg(:, MAINENNA_INDEX, :);
    %     OldVs=Vs;
    Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;
end
toc;
%%
figure(1111);clf;subplot(1,2,1);
plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),allRhss(1:end,Stim.loc+1),'LineWidth',4);
hold on;
plot(squeeze(Traces(2:end,1,3,1)),NRHS(Stim.loc,1:end),'r','LineWidth',2);
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
subplot(1,2,2);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,2:end),'LineWidth',4);
hold on;
plot(squeeze(Traces(2:end,1,3,1)),squeeze(Traces(2:end,1,3,2)),'r','LineWidth',2);