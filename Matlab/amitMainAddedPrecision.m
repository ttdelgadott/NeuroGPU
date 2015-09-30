%Amit - Main
% cd('C:\Users\AmitM\Documents\neurogpu\Matlab');
% addpath(genpath('./Amit/'));
% cd('C:\Users\AmitM\Documents\neurogpu\Matlab');
%%
close all
clear variables
clc

NeuroGPUInit;
cd ([BaseP 'Matlab']);

%%DOCUMENTATION_REF_001
%Indices for all the mechanism funcs throughout the program.
%(global - not ideal, could use function that return the value instead)
global INIT_INDEX 
global CURRENT_INDEX
global STATES_INDEX
INIT_INDEX= 1;
CURRENT_INDEX = 2;
STATES_INDEX = 3;
NUM_OF_FUNCS_PER_MODEL = 3;

FN_Topo=[BaseP 'Neuron/printCell/Amit/Output/64T.csv'];
FN_TopoF=[BaseP 'Neuron/printCell/Amit/Output/64F.csv'];
FN_TopoPP=[BaseP 'Neuron/printCell/Amit/Output/64PP.csv'];
FN_TopoMDL=[BaseP 'Neuron/printCell/Amit/Output/64MDL.csv'];

%%DOCUMENTATION_REF_002C
%MainBasicDefinitions;      QWERTY - new
% Now automatic:
hocFileData;
%FN='neurogpu\Neuron\printCell\Amit\printCellBinaryK64 - 3.hoc';
%ParseHocFile;
% [names values]=readMechanisms(FN);
%%
%fidTopo = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
% fidTopo = fopen('../Neuron/printCell/Output/realCellTopo.csv');
fidTopo = fopen(FN_Topo);      
[Neuron Sim Stim] = ReadKForkTopology(fidTopo);
%fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
% fidFmatrix = '../Neuron/printCell/output/realCellFmatrix.csv';
%fidFmatrix = 'neurogpu/Neuron/printCell/Amit/output/64F.csv';  

[Mats Traces] = AmitReadFmatrixForkHH(FN_TopoF,Neuron); % Traces cannot be 4D exactly when different NSegs
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');

%%DOCUMENTATION_REF_003
numOfSegs = sum(Neuron.NSegsMat);
% varsPerModelPerSeg = zeros(numOfSegs, NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_PER_SEG); QWERTY
% varsPerModelAllSegs = zeros (NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_ALL_SEGS);
% constsPerModelAllSegs = zeros(NUM_OF_MODELS, MAX_NUM_CONSTS_PER_MODEL);
% constsAllModelsAllSegs = zeros(1, MAX_NUM_CONSTS_GLOBAL);

%%
dgs = zeros(1, numOfSegs);

%%
%DOCUMENTATION_REF_004C     THE INITIALIZE FUNCTION
% [varsPerModelPerSeg, varsPerModelAllSegs, constsPerModelAllSegs,...QWERTY
%     constsAllModelsAllSegs, Vs, rhss, D, parentIndexes] = ...
%     initialize(varsPerModelPerSeg, varsPerModelAllSegs, constsPerModelAllSegs,...
%     constsAllModelsAllSegs, Neuron, ModelsFuncsNames, Sim, numOfSegs, NUM_OF_MODELS, hasModel);

[constsAndVars, Vs, rhss, D, parentIndexes] = initialize(Neuron, ...
    ModelsFuncsNames, Sim, numOfSegs, NUM_OF_MODELS, hasModel);
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

[FN FNP FNM Aux]=CreatAuxiliaryData3(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),Neuron,cmVec);

%TestAux(rot90(OurMat,2),Aux)
%%
TT=squeeze(Traces(:,1,3,1));

NRHS=squeeze(Mats(:,5,:));

%NsumCurrent=squeeze(sum(Traces(:,:,3,6:8),4)); Amit - deleted from f
%matrix
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
if(NSTATES>0)
    %ParamsM=repmat([Neuron.GBars(1,:), Traces(4,1,1,5),
    %Neuron.Es(1,3)],[Nx 1]);%gnabar gkbar gl el    Amit - deleted it since
    %not available.
    fidParamsM=fopen('../Data/ParamsM.mat','wb');
%     ParamsMByComp = ParamsM(1,:);                 Amit - deleted it since
%                   I changed the topology matrix that is printed
%     fwrite(fidParamsM,ParamsMByComp,'float32');
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
%NEURONStates=squeeze(Traces(1,:,:,9:11)); Amit - deleted from F matrix.
global MyData;
MyData = zeros(1,Nx);

%NeuronData = squeeze(Traces(:,Stim.comp,1,4:4));   AMIT-to be deleted, not
%generic, reads i_na.

% Aux = debugAux(Aux);
tic;
for i=1:(Nt)
    t=((i-1)*Sim.dt);
    if(i == 11)
        disp('aaa');
    end
    if(t>0.48)
        disp(t);%I think there is a problem with the stim check it out!!
    end
    AllVs(:,i)=Vs;
    VHot(i)=Vs(InLoc);
    rhss = zeros(1,Nx);
    D = zeros(1,Nx);
    %DOCUMENTATION_REF_005C
%     [rhss dgs varsPerModelPerSeg] = nrnRhs (rhss, dgs, t, Vs, hasModel, varsPerModelPerSeg, varsPerModelAllSegs,...
%         constsPerModelAllSegs, constsAllModelsAllSegs, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);
    [rhss dgs constsAndVars] = nrnRhsPrecision (rhss, dgs, t, Vs, hasModel,...
        constsAndVars, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);

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
    
    Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(rhss)));
    Vmid = fliplr(OurMat\rhss')';
    
    VmidToUse=Vmid;
    Vmids(:,i)=VmidToUse;
    VsNew = Vs+VmidToUse;
    %DOCUMENTATION_REF_006C
%     [varsPerModelPerSeg varsPerModelAllSegs] = deriveModels(Sim.dt, VsNew, hasModel, varsPerModelPerSeg, varsPerModelAllSegs,...
%         constsPerModelAllSegs, constsAllModelsAllSegs, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);
    [constsAndVars] = deriveModels(Sim.dt, VsNew, hasModel, constsAndVars,...
        ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);

      %AllStates(i+1,:,:) = varsPerModelPerSeg(:, MAINENNA_INDEX, :);
    
    %     OldVs=Vs;
    
    Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;
    
    
end
toc;
%figure(11);
plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),allRhss(1:end,Stim.loc+1));
hold on;
plot(squeeze(Traces(2:end,1,3,1)),NRHS(Stim.loc,1:end),'r');
% figure(33)
% plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
figure(22);
plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,2:end));
hold on;
plot(squeeze(Traces(2:end,1,3,1)),squeeze(Traces(2:end,1,3,2)),'r');
%
% figure(46);clf;                           /QWERTY
% fidVHot = fopen('../Data/VHotC.dat');
% NVHotC = fread(fidVHot, 1, 'uint16');
% VHotC = fread(fidVHot, NVHotC, 'float32');
% fclose(fidVHot);
% plot(VHotC);

%
% AD=1:19;
%
% Aux2.e=(0:18)*2+1;
% Aux2.f=(0:18)*3+1;
% BRHS=(0:18)*4+1;
% Aux2.Ks=Aux.Ks;
% VV=(SolveByUs(Aux2,AD,BRHS))';
% ourStates = squeeze(AllStates(:,2,:));
% figure(56);
% subplot(3,1,1);
% plot(ourStates(:,1));
% hold on
% plot(StimNeuronStates(:,9),'r');

% subplot(3,1,2);
% plot(ourStates(:,2));
% hold on
% plot(StimNeuronStates(:,10),'r');
% 
% subplot(3,1,3);
% plot(MyData(1,:));
% hold on
% plot(NeuronData(:,1),'r');

% subplot(3,1,3);       %QWERTY
% plot(ourStates(:,3));
% hold on
% plot(StimNeuronStates(:,3),'r');