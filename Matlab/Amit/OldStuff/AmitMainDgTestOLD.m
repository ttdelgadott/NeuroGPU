%Amit - Main

%%
close all
clear variables
clc

%% QWERTY - Amit
%Indices for all the mechanism funcs throughout the program.
%(global - not ideal, could use function that return the value instead)
global INIT_INDEX 
global CURRENT_INDEX
global JACOB_INDEX 
global STATES_INDEX
INIT_INDEX= 1;
CURRENT_INDEX = 2;
JACOB_INDEX = 3;
STATES_INDEX = 4;
NUM_OF_FUNCS_PER_MODEL = 4;

global HH_INDEX;
global STIM_INDEX;
global MAINENNA_INDEX;
HH_INDEX = 1;
STIM_INDEX = 2;
MAINENNA_INDEX = 3;

%%  QWERTY - Amit
%this part is written in pre-proccessing (calculted when translating the
%mod file to the MATLAB/Cuda file). for now it has constant values.
NUM_OF_MODELS = 3;
MAX_NUM_CONSTS_PER_MODEL= 16;
MAX_NUM_CONSTS_PER_SEG = 5;
MAX_NUM_CONSTS_GLOBAL = 10;
MAX_NUM_VARS_PER_MODEL_PER_SEG= 11;
MAX_NUM_VARS_PER_SEG = 5;

%doesn't change in pre-process
ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'AmitInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'AmitNrnCurrent_'};
ModelsFuncsNames(:, JACOB_INDEX) = {'AmitGetDg_'};
ModelsFuncsNames(:, STATES_INDEX) = {'AmitNrnStates_'};

%changes in pre-process
ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'HH');
ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'Stim');
ModelsFuncsNames(3,:) = strcat(ModelsFuncsNames(3,:), 'MainenNa');
%%
%fidTopo = fopen('../Neuron/printCell/Output/BTreeHHTopo.csv');
% fidTopo = fopen('../Neuron/printCell/Output/realCellTopo.csv');
fidTopo = fopen('../Neuron/printCell/Amit/Output/64T.csv');         %QWERTY - new with mainen
%fidTopo = fopen('../Neuron/printCell/Output/64T.csv');              %QWERTY - old
[Neuron Sim Stim] = ReadKForkTopology(fidTopo);                
%fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
% fidFmatrix = '../Neuron/printCell/output/realCellFmatrix.csv';
fidFmatrix = '../Neuron/printCell/Amit/output/64F.csv';              %QWERTY - new with mainen
%fidFmatrix = '../Neuron/printCell/output/64F.csv';                    %QWERTY - old
[Mats Traces] = AmitReadFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');

%% QWERTY - Amit
%QWERTY-delete
global StimNeuronStates; %QWERTY-delete
StimNeuronStates=squeeze(Traces(:,Stim.comp,1,1:19)); 
NeuronData = squeeze(Traces(:,Stim.comp,1,7:7));
global NT;   %QWERTY-delete
NT = 1;

numOfSegs = sum(Neuron.NSegsMat);
varsPerModelPerSeg = zeros(numOfSegs, NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_PER_SEG);
varsPerSeg = zeros (numOfSegs, MAX_NUM_VARS_PER_SEG);
%QWERTY - to check if not any of these consts array are redundant!
constsPerModel = zeros(NUM_OF_MODELS, MAX_NUM_CONSTS_PER_MODEL);
constsPerSeg = zeros(numOfSegs, MAX_NUM_CONSTS_PER_SEG);
constsGlobal = zeros(MAX_NUM_CONSTS_GLOBAL);
%QWERTY - for now every segment has all the models - to do - check which
%segment uses which model and change the matrix accordingly.
hasModel = zeros (numOfSegs, NUM_OF_MODELS);
sumConductivity = zeros(1, numOfSegs);

%THE INITIALIZE FUNCTION
[hasModel, varsPerModelPerSeg, constsPerModel, constsPerSeg, Vs, rhss, D,...
    parentIndexes, isElectrodeCurrent] = ...
    AmitInitialize(Neuron, ModelsFuncsNames, varsPerModelPerSeg, Sim,...
        constsPerModel, constsPerSeg, hasModel, numOfSegs, NUM_OF_MODELS);
%%
% load('realcell');
Neuron.HasHH=AmitGetHHsegs(Neuron); 
%Stim.loc = 2;                       /QWERTY?
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
    ParamsM=repmat([Neuron.GBars(1,:), Traces(4,1,1,5), Neuron.Es(1,3)],[Nx 1]);%gnabar gkbar gl el
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
AllStates(1,:,:) = varsPerModelPerSeg(:, MAINENNA_INDEX, :);
global MyData;
MyData = zeros(1,Nx);
NEURONStates=squeeze(Traces(1,:,:,9:11));

% Aux = debugAux(Aux);
tic;

for i=1:(Nt)
    NT = i;     %%QWERTY-delete
    t=(i-1)*Sim.dt;
    if(t>0.48)
        disp(t);%I think there is a problem with the stim check it out!!
    end
    AllVs(:,i)=Vs;
    VHot(i)=Vs(InLoc);
    rhss = zeros(1,Nx);
    D = zeros(1,Nx);
    [rhss sumConductivity varsPerModelPerSeg] = AmitNrnRhs (rhss, sumConductivity, t, Vs, hasModel, varsPerModelPerSeg, varsPerSeg,...
        constsPerModel, constsPerSeg, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);
    %rhss(1,:) = NRHS(Stim.loc,NT);   %QWERTY-delete
    
    %sumConductivity = sumConductivity * 2 * 10^-4; %QWERTY-delete

    sumConductivity(cmVec==0)=0;
    for seg=2:Nx
        parentIndex = parentIndexes(seg); 
        dv = Vs(parentIndex)-Vs(seg);
        rhss(1,seg) =rhss(1,seg) -Aux.f(Nx+1-seg)*dv;
        rhss(1,parentIndex) =rhss(1,parentIndex) +Aux.e(Nx+2-seg)*dv;
    end

    for seg=2:Nx
        D(seg) = sumConductivity(seg)+cmVec(seg)/(1000*Sim.dt);
    end
%     D = AmitNrnJacob (D, hasModel, varsPerModelPerSeg, varsPerSeg,...
%         constsPerModelPerSeg, constsPerSeg, ModelsFuncsNames,...
%         isElectrodeCurrent, NUM_OF_MODELS, numOfSegs);
    
    
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
    
    if(t>1.49)
        disp(t);%continue from here there is a problem that rhs are different.
    end
%         [OurDiagX Vmid2] = solveByNeuron(Nx,Aux,OurDiag,rhss,Neuron);
    Vmid = fliplr(SolveByUs(Aux,fliplr(OurDiag),fliplr(rhss)));
%     VmidP = fliplr(SolveByUsP(Aux,fliplr(OurDiag),fliplr(rhss)));
    
    VmidToUse=Vmid;
    Vmids(:,i)=VmidToUse;
    VsNew = Vs+VmidToUse; %QWERTY-new
    varsPerModelPerSeg = AmitDeriveModels(Sim.dt, VsNew, hasModel, varsPerModelPerSeg, varsPerSeg,...
        constsPerModel, constsPerSeg, ModelsFuncsNames, NUM_OF_MODELS, numOfSegs);

      AllStates(i+1,:,:) = varsPerModelPerSeg(:, MAINENNA_INDEX, :);  %QWERTY
    
    %     OldVs=Vs;
    
    Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;
    
    
end
toc;
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
ourStates = squeeze(AllStates(:,2,:));
figure(56);
subplot(3,1,1);
plot(ourStates(:,1));
hold on
plot(StimNeuronStates(:,9),'r');

subplot(3,1,2);
plot(ourStates(:,2));
hold on
plot(StimNeuronStates(:,10),'r');

% subplot(3,1,3);
% plot(ourStates(:,3));
% hold on
% plot(StimNeuronStates(:,11),'r');

% subplot(3,1,3);       %QWERTY
% plot(ourStates(:,3));
% hold on
% plot(StimNeuronStates(:,3),'r');