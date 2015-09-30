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

%First finish HH by our, only then fork.
fidTopo = fopen('../Neuron/printCell/Output/forkTopo.csv');
[Neuron Sim Stim] = readTopology(fidTopo);
fidFmatrix = '../neuron/printCell/output/forkData.csv';
[Table Traces] = readFmatrixFork(fidFmatrix,Neuron);
[OurMat Table ]= createMatrixAsNEURONNew(Neuron);
%Table =addCms(Table,cm,dt);
%compareTables(1,Table,diags,parents,childs,rhs);
%% Now running



Nx = length(OurMat);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
InLoc=7;
OutLoc=7;
Nt=ceil(Sim.Tfinal(1)/Sim.dt);
Ns=sum(Neuron.NSegs);
Vs =Sim.Vs(1);
for i=1:numel(Neuron.NSegs)
    Vs = [Vs,ones(1,Neuron.NSegs(i)+1).*Sim.Vs(i)];
end
OldVs=Vs;
OrigDiag=diag(OurMat);
t=0;
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
Stim.area = pi*Neuron.Diam(Stim.Comp)*Neuron.L(Stim.Comp)/Neuron.NSegs(Stim.Comp);
for i=1:Nt
    if(i==7)
        i
    end
    t=i*Sim.dt;
    if t>=Stim.del && t<(Stim.del+Stim.dur)
        StimICurr(InLoc) = 100* Stim.amp/Stim.area;
    else
        StimICurr(InLoc)=0;
    end
    %deltaVs=Vs-OldVs; %(plus minus)
    
    % Update diagonal
    %NewDiag=OrigDiag%+something like cms/dt;
    %NewDiag = diag(OurMat)'; %+ g's
    NewRHS = (Vs-OldVs).*(cmVec./(1000*dt));%current %Stimulus + something with deltaVs*cms/dt;
    Stim = zeros(Nx,1);
    Stim(InLoc) = 1;
    EffectOfStimOnVs=OurMat\Stim;
    CurrentCurrentAtLoc=NewRHS(InLoc);
    WantedCurrentAtLoc= 100*stamp/(pi*diam*L/NSegs);
	DeltaCurrent=WantedCurrentAtLoc-CurrentCurrentAtLoc;
    NeededStimNow = DeltaCurrent/EffectOfStimOnVs;
    Stim=zeros(asjdlkasd);
    Stim(InLoc)=NeededStimNow;
    NewRHS(InLoc)=Stim(InLoc);
    if(t>1)

        
    end
    OldVs=Vs;
    if(i>1)
        NeuronRHS = rhs(:,i-1);
    end
    Diff= NeuronRHS'-NewRHS;
    if(sum(abs(Diff))>0.001)
        disp('asdasd');
    end
    NewRHS = NeuronRHS';
    OurMat(1:Nx+1:end) = OrigDiag' +cmVec./(1000*dt);%Update matrix
    
    Vmid=-OurMat\NewRHS';
    Vs=Vs-Vmid'; %like 2*Vmid - Vs ???;
    currNeuronV = neuronV(i);
    VHot(i)=Vs(OutLoc);
    AllVs(:,i)=Vs;
end
figure(11);
plot(0:dt:TFinal-dt,VHot);
figure(22);
plot(neuronT(2:end),neuronV(2:end),'r');
figure(33)
plot(neuronT(2:end),(neuronV(2:end)-VHot'))
%See VHot?
%%
%HH! (see stEfork, but use gk of NEURON)
 %   use the NMODL stuff of MainM
    
    