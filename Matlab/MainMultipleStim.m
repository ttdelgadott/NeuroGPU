close all
clear variables
clc

fidTopo = fopen('../Neuron/printCell/Output/topo96.csv');
[Neuron] = ReadTopologyMultipleStim(fidTopo);
fidConstants = fopen('../Neuron/printCell/Output/const96.csv');
[Sim Stim] = ReadConstants(fidConstants,Neuron);
% %fidFmatrix = '../Neuron/printCell/output/BTreefmatrixHH.csv';
% fidFmatrix = '../Neuron/printCell/output/realCellFmatrix.csv';
for i = 0:Stim.NStimuli-1
    fidFmatrix = ['../Neuron/printCell/output/FMats96_' num2str(i) '.csv'];
    [Mats Traces] = readFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
    VPerStimuli{i+1}=squeeze(Traces(2:end,1,3,2));
end
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
 save('realcellDEBUG','Neuron', 'Sim', 'Stim','Mats', 'Traces','VPerStimuli');
cdebug_fid = fopen('C:\Users\Roy\Documents\SVN\VS\CN\NeuronC\Debug.dat');


%%
%load('realrealcell');
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
    
    %ParamsM=repmat([Neuron.GBars(1,:), Traces(4,1,1,5), Neuron.Es(1,3)],[Nx 1]);%gnabar gkbar gl el
    index=1;
    ParamsM=zeros(Nx,6);
    for comp=1:length(Neuron.NSegsMat)
        currNSegs = Neuron.NSegsMat(comp);
        ParamsM(index:index+currNSegs-1,1) = ones(currNSegs,1)*Neuron.GBars(comp,1);
        ParamsM(index:index+currNSegs-1,2) = ones(currNSegs,1)*Neuron.GBars(comp,2);
        ParamsM(index:index+currNSegs-1,3) = ones(currNSegs,1)*Neuron.GBars(comp,3);
        ParamsM(index:index+currNSegs-1,4) = ones(currNSegs,1)*Neuron.Es(comp,1);
        ParamsM(index:index+currNSegs-1,5) = ones(currNSegs,1)*Neuron.Es(comp,2);
        ParamsM(index:index+currNSegs-1,6) = ones(currNSegs,1)*Neuron.Es(comp,3);
        index = index+currNSegs;
    end
    fidParamsM=fopen('../Data/ParamsM.mat','wb');
    fwrite(fidParamsM,ParamsM,'float32');
    fclose(fidParamsM);
    StatesM=zeros([Nx NSTATES]);
end
%% Now running
InLoc=Stim.loc;
Nt=ceil(Sim.Tfinal./Sim.dt);
Ns=sum(Neuron.NSegs);
for stimulus =1:Stim.NStimuli
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

    del = Stim.del(stimulus);
    amp = Stim.amp(stimulus);
    dur = Stim.dur(stimulus);
    loc = Stim.loc;
    stimArea = Stim.area;
    rhss = zeros(1,Nx);
    for i=1:Nt
        t=(i-1)*Sim.dt;
        AllVs(:,i)=Vs;
        VHot(i)=Vs(InLoc);
        rhss = zeros(1,Nx);
        Ds = zeros(1,Nx);
        TmpParentVec=zeros(1,Nx);
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
                [sumCurrents sumConductivity]=BreakpointModel(Vs(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4), ParamsM(seg,5), ParamsM(seg,6));
                [sumCurrentsDv sumConductivityDv]=BreakpointModel(Vs(seg)+0.001, StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4), ParamsM(seg,5), ParamsM(seg,6));
                gHH = sumCurrentsDv;
                rhsHH=sumCurrents;
                gHH = (gHH-rhsHH)/0.001;
            else
                rhsHH=0;
                gHH=0;
            end
    %         rhsStim = handleStim(Stim,seg,t);
            current=0;
            if(t>=del && t<del+dur && loc == seg)
                current = 100*amp/stimArea;
            end

    %         if(seg>1)
    %             rhss(seg)=rhss(seg)+current;
                rhs=current;
                rhs=rhs-rhsHH;
                if(~isHH)
                    sumConductivity=0;
                end
                %         parentIndex = getParentInd(Neuron,seg);

                dv = Vs(parentIndex)-Vs(seg);
                rhs =rhs -Aux.f(Nx+1-seg)*dv;
                % Taking care of the Diam

                D = sumConductivity+cmVec(seg)/(1000*Sim.dt);
                D = D-Aux.f(Nx+1-seg);
                %         parentIndex = getParentInd(Neuron,seg);
    %             TmpParentVec(seg)=parentIndex;

                % Taking care of the parent
                if(seg==1)
                    rhs=0;
                    D=0;
                end
                
                rhss(Nx-seg+1)=rhs;
                Ds(Nx-seg+1)=D;
        end
        for seg=1:Nx

            if(seg==1)
                parentIndex=1;
            else
                parentIndex =Nx+1-Aux.Ks(Nx+2-seg);
            end
            dv = Vs(parentIndex)-Vs(seg);
            Eidx=min(Nx,Nx+2-seg);

                SonNo=Aux.SonNoVec(seg);
                if(SonNo==1)
                    rhss(1,Nx-parentIndex+1) =rhss(1,Nx-parentIndex+1) +Aux.e(Eidx)*dv;
                    Ds(Nx-parentIndex+1)=Ds(Nx-parentIndex+1) -Aux.e(Eidx); % Constant!!!
                end
                if(SonNo==2)
                    rhss(1,Nx-parentIndex+1) =rhss(1,Nx-parentIndex+1) +Aux.e(Eidx)*dv;
                    Ds(Nx-parentIndex+1)=Ds(Nx-parentIndex+1) -Aux.e(Eidx); % Constant!!!
                end
    %             for ii=3:12
    %                 if(SonNo==ii)
    %                     rhss(1,Nx-parentIndex+1) =rhss(1,Nx-parentIndex+1) +Aux.e(Eidx)*dv;
    %                     Ds(Nx-parentIndex+1)=Ds(Nx-parentIndex+1) -Aux.e(Eidx); % Constant!!!
    %                 end
    %             end

    %         end

        end

        allRhss(i,:)=rhss(1,:);
        Diags(i,:)=Ds;

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
       % [OurDiag Vmid] = solveByNeuron(Nx,Aux,D,rhss,Neuron);
    %    Vmid = fliplr(SolveByUs(Aux,fliplr(D),fliplr(rhss)));
       VmidP = SolveByUs(Aux,Ds,rhss);
        for seg=1:Nx
            VmidToUse(seg) = VmidP(Nx-seg+1);
        end
        %VmidToUse=VmidP;

        Vmids(:,i)=VmidToUse;
    %     CVMid = fread(cdebug_fid, Nx, 'float32');
        Vs=Vs+VmidToUse; %like 2*Vmid - Vs ???;

        for seg=1:Nx
            isHH=Aux.boolHasHH(seg);
            if(isHH)            
                [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(Sim.dt, Vs(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
            end
        end
        AllStates(i+1,:,:)=StatesM;
    end
    
    % figure(33)
    % plot(nums(3:end,NeuronOutLoc,1),(nums(3:end,NeuronOutLoc,2)-VHot'))
    figure(22);
    plot(Sim.dt:Sim.dt:(Sim.Tfinal-Sim.dt),AllVs(Stim.loc,2:end));
    hold on;
    plot(squeeze(Traces(2:end,1,3,1)),VPerStimuli{stimulus},'r');
    
%     fidVHotP = fopen('../Data/VHotP.dat');
%     NVHotP = fread(fidVHotP, 1, 'uint16');
%     VHotP = fread(fidVHotP, NVHotP, 'float32');
%     fclose(fidVHotP);
%     hold on;
%     plot(Sim.dt:Sim.dt:(Sim.Tfinal),VHotP((stimulus-1)*Nt+1:(stimulus)*Nt),'black');
    ylim([-200,100]);
end
figure(11);
plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),allRhss(1:end,Stim.loc));
hold on;
 plot(squeeze(Traces(2:end,1,3,1)),NRHS(Stim.loc,1:end),'r');
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
% 
% fidVHot = fopen('../Data/VHotC.dat');
% NVHotC = fread(fidVHot, 1, 'uint16');
% VHotC = fread(fidVHot, NVHotC, 'float32');
% fclose(fidVHot);
% hold on;
% plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),VHotC,'g');
% 
% %
% fidVHotP = fopen('../Data/VHotP.dat');
% NVHotP = fread(fidVHotP, 1, 'uint16');
% VHotP = fread(fidVHotP, NVHotP, 'float32');
% fclose(fidVHotP);
% hold on;
% plot(0:Sim.dt:(Sim.Tfinal-Sim.dt),VHotP,'black');