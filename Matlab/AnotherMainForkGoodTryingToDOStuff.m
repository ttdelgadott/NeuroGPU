close all
clear variables
clc

%First finish HH by our, only then fork.
fidTopo = fopen('../Neuron/printCell/Output/forkTopo.csv');
[Neuron Sim Stim] = readTopology(fidTopo);
fidFmatrix = '../neuron/printCell/output/forkData.csv';
[Mats Traces] = readFmatrixFork(fidFmatrix,Neuron);
[OurMat Table ]= createMatrixAsNEURONNew(Neuron);
%Table =addCms(Table,cm,dt);
%compareTables(1,Table,diags,parents,childs,rhs);
%% Now running



Nx = length(OurMat);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
InLoc=4;
OutLoc=4;
Nt=ceil(Sim.Tfinal(1)/Sim.dt);
Ns=sum(Neuron.NSegs);
Vs =Sim.Vs(1);
for i=1:numel(Neuron.NSegs)
    NeuronVsLoc(i)=numel(Vs)+ceil(Neuron.NSegs(i)/2);
    Vs = [Vs,ones(1,Neuron.NSegs(i)+1).*Sim.Vs(i)];
end
OldVs=Vs;
OrigDiag=diag(OurMat);
t=0;
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
Stim.area = pi*Neuron.Diams(Stim.comp)*Neuron.Ls(Stim.comp)/Neuron.NSegs(Stim.comp);
%%
StimByItself=TT*0;
StimActiveTB=TT>=Stim.del & TT<=(Stim.del+Stim.dur);
StimActiveT=find(StimActiveTB);
StimByItself(StimActiveT(1))=100*Stim.amp/Stim.area;
StimByItself(StimActiveT(2:end))=100*Stim.amp/(Stim.area*sum(Neuron.NSegs)); % Probaly will not work with different diams, etc... - check Alon
StimByItselfOff=StimByItself;
StimByItselfOff(StimActiveT(1))=0;
% StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
% StimDiff=zeros(1,Nx);
% StimPrev=zeros(1,Nx);
NSumCurrent =  Traces(:,:,1);
totalDiff=Vs.*0;
for i=2:(Nt)
    if(i==7)
        49
    end
    t=i*Sim.dt;

%     if (t>Stim.del && t<=(Stim.del+Stim.dur))
%         StimICurr(InLoc) = 100*Stim.amp/Stim.area;
%     else
%         StimICurr(InLoc)=0;
%     end
%     StimDiff = StimICurr-StimPrev;
%     StimPrev = StimICurr;
% NewRHS = StimByItself + StimDiff + (Vs-OldVs).*(cmVec./(1000*Sim.dt));%current %Stimulus + something with deltaVs*cms/dt;
    sumCurrents = NSumCurrent(i,:);
    NewRHS=ones(1,Nx)-sumCurrents; 
    NewRHS(InLoc)=NewRHS(InLoc)+StimByItself(i);
    NotLoc=setdiff(1:Nx,[InLoc find(cmVec==0)]);
    NewRHS(NotLoc)=NewRHS(NotLoc)+StimByItselfOff(i);
    OldVs=Vs;
    NeuronRHS = Mats(:,5,min(200,i-1));
    %NewRHS = NeuronRHS'; % DEBUG DEBUG
    DiffRHS= NeuronRHS'-NewRHS;
    if(sum(abs(DiffRHS))>0.001)
        disp('RHSRHSRHSRHS');
    end
     
    OurMat(eye(Nx)>0) = OrigDiag' +cmVec./(1000*Sim.dt);%Update matrix
    %OurMat(eye(Nx)>0) = Mats(:,4,i); % DEBUG DEBUG
    Vmid=-OurMat\NewRHS';
    Vs=Vs-Vmid'; %like 2*Vmid - Vs ???;
%     t,v(0.5),i_cap(0.5),st.amp
    currNeuronV = Traces(i,:,2);
    DiffV= currNeuronV-Vs(NeuronVsLoc);
    if(sum(abs(DiffV))>0.1)
        disp('VVVVVVVVVV');
    end
    DiffDiag = diag(OurMat) - Mats(:,4,min(200,i));
    
    totalDiff = totalDiff+sum(abs(DiffV));
    
    if(sum(abs(DiffDiag))>0.01)
        disp('DiagDiagDiagDiagDiag');
    end
    VHot(i)=Vs(OutLoc);
    AllVs(:,i)=Vs;
end
figure(11);
plot(Sim.dt:Sim.dt:Sim.Tfinal,VHot);
hold on;
plot(Sim.dt:Sim.dt:Sim.Tfinal,Traces(2:end,1,2),'r');
% figure(33)
% plot(neuronT,(neuronV-VHot'))

%See VHot?
%%
%HH! (see stEfork, but use gk of NEURON)
 %   use the NMODL stuff of MainM
RHSs = squeeze(Mats(:,5,:));
    