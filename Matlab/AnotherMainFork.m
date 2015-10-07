% LengthArr=[10 100 10];
% Diams=[10 100 10];
% NSegs=[10 10 10];
% Ras=[10 10 10];
% 
% Adj={3 1 2}; % fork.

%Start with just soma!, not with fork!
% LengthArr=[10 ];
% Diams=[10 ];
% NSegs=[10 ];
% Ras=[10 ];
Adj={1}; 
close all
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
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
totalDiff=Vs.*0;
for i=2:(Nt)
    if(i==7)
        49
    end
    t=i*Sim.dt;
    %stamp = iamps(i);
    if (t>Stim.del && t<=(Stim.del+Stim.dur))
        StimICurr(InLoc) = 100*Stim.amp/Stim.area;
    else
        StimICurr(InLoc)=0;
    end
    StimDiff = StimICurr-StimPrev;
    StimPrev = StimICurr;
    %deltaVs=Vs-OldVs; %(plus minus)
    
    % Update diagonal
    %NewDiag=OrigDiag%+something like cms/dt;
    %NewDiag = diag(OurMat)'; %+ g's
    NewRHS = StimDiff + (Vs-OldVs).*(cmVec./(1000*Sim.dt));%current %Stimulus + something with deltaVs*cms/dt;
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
    if(sum(abs(DiffV))>0.001)
        disp('VVVVVVVVVV');
    end
    DiffDiag = diag(OurMat) - Mats(:,4,min(200,i));
    
    totalDiff = totalDiff+sum(abs(DiffV));
    
    if(sum(abs(DiffDiag))>0.001)
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
    
    