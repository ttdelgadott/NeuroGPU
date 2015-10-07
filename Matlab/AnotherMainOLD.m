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
[diags parents childs rhs NSegs L diam Ra cm dt stdel stdur stamp vinit neuronI neuronV neuronT iamps] = readFmatrixCapSoma();
[OurMat Table]= createMatrixAsNEURON(L,diam,NSegs,Ra,Adj);
%Table =addCms(Table,cm,dt);
%compareTables(1,Table,diags,parents,childs,rhs);
%% Now running

%dt=0.001;

Nx = length(OurMat);
cmVec = ones(1,Nx).*cm;
cmVec(1)=0;
cmVec(end)=0;
InLoc=7;
OutLoc=7;
TFinal=2;
Nt=ceil(TFinal./dt);
Ns=sum(NSegs);
Vs=ones(1,Nx)*vinit;
OldVs=Vs;
OrigDiag=diag(OurMat);
t=0;
v0s = ones(1,Nx)*vinit;
%%
StimICurr=zeros(1,Nx);%all zeros% but Stim(InLoc)=StimAmp/some area;
StimDiff=zeros(1,Nx);
StimPrev=zeros(1,Nx);
for i=1:Nt
    if(i==50)
        i
    end
    t=i*dt;
    stamp = iamps(i);
    if t>=stdel && t<(stdel+stdur)
        StimICurr(InLoc) = 100*stamp/(pi*diam*L/NSegs);
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
    NeededStimNow=DeltaCurrent/EffectOfStimOnVs
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
    
    