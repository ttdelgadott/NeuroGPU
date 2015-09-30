mainStruct = CreateBaseStructure();
Mega=10^6;
Nano=10^-9;
Giga=10^9;
Mili=10^-3;
Micro=10^-6;
Kilo=10^3;
% 1. Load Matrix
clc
ASCFN = '../Data/Cells/simple.ASC';
% ASC='SImpleSpindle.ASC';
[Adj,Diams,Lengths,Type,Parent,NSeg] = ReadFromNeuron();
%[Adj,Coords,Type,Parent,NSeg] = ReadASCFile(ASCFN);
%[Lengths Diams] = CalcLengthAndDiams(Coords,Type,Parent);
% CombineSegments;a
% for i=1:numel(Lengths)
%     Lengths{i}=Lengths{i}*Mili*100;
%     Diams{i}=Diams{i}*Mili;
%     
%     Lengths{i}=Lengths{i}*0+mean(Lengths{i});
%     Diams{i}=Diams{i}*0+mean(Diams{i});
%     
%     
%     RandLenForThisCompartement=rand*0+4.3;
%     RandDiamForThisCompartement=rand*0+1.3;
%     Lengths{i}=max(RandLenForThisCompartement,min(Lengths{i},RandLenForThisCompartement+rand*0));
%     Diams{i}=max(RandDiamForThisCompartement,min(Diams{i},RandDiamForThisCompartement+rand*0));
% 
%     Lengths{i}=Lengths{i}*(10^(-4));
%     Diams{i}=Diams{i}*(10^(-4));
% end
% Ls=importdata('neuronlengths.csv');
% for i=1:numel(Lengths)
%     Lengths{i}=Ls.data(i,4);
%     Diams{i}=Ls.data(i,3);
% end
[A N SegStartI R2 gL] = createMatrix(Lengths,Diams,NSeg,Adj);
stim = mainStruct(1).Stim;
stim.comptLoc{2}=1;
gL=0.0003;
stim.loc = N; % SegStartI(getCompIndex(Type,stim.comptLoc{1}))+ceil(stim.comptLoc{2}*NSeg(getCompIndex(Type,stim.comptLoc{1})));
%%
As = 4*pi*1e-6;%electrode area???
% [A] = insertStimulus(Lengths,Diams,R2,gL,stim.comptLoc,A,Type,SegStartI,As);
stim.amp=stim.amp*Mega;
% A=-A;
%N=NSeg;
%% 2. Load Parameters
% load(modelParams.mat); Getting params and NSTATES
NSTATES=3;
% gnabar = .12 (S/cm2)	<0,1e9>
% gkbar = .036 (S/cm2)	<0,1e9>
% gl = .0003 (S/cm2)	<0,1e9>
% el = -54.3 (mV)
ParamsM=repmat([.12,.036,gL, -54.3],[N 1]);
StatesM=zeros([N NSTATES]);
%% Init
V=-70*ones(1,N);
for seg=1:N
    [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=InitModel(V(seg));
end
TFinal=50;
Cm =1 ;
dt=0.01;
stimArea=3.1416/1000000;
Nt = ceil(TFinal/dt);
VHot = zeros(Nt,1);
VHot(1) = V(stim.loc);
dOrig = diag(A);
%% Running the model
for i=1:Nt
    t=i*dt;
    % Before matrix
    for seg=1:N
        if (V(seg)>1E5 ||V(seg)<-1E5)
           disp(['v becomes non physiological' num2str(V(seg))]);
        end
        [sumCurrents sumConductivity]=BreakpointModel(V(seg), StatesM(seg,1), StatesM(seg,2), StatesM(seg,3), ParamsM(seg,1), ParamsM(seg,2), ParamsM(seg,3), ParamsM(seg,4));
        TmpVec2(seg)=sumCurrents;
%         if(seg==stim.loc && t>stim.t1 && t<stim.t2)
%             TmpVec2(seg)=TmpVec2(seg)+stim.amp/stimArea;
%         end
        %outFile.printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f",1v,2m_hh,3h_hh, 4n_hh,5ina,6ik,7il_hh,8i,9minf_hh, 10hinf_hh ,11ninf_hh, 12ntau_hh, 13mtau_hh, 14htau_hh, 15gna_hh, 16gk_hh, 17ena, 18ek, 19gl_hh, 20el_hh)
        A(seg,seg)=dOrig(seg)+sumConductivity+ 2*Cm/dt;
        if (seg ==N)
            td(i) = t;
            vd(i) = V(N);
            md(i) = StatesM(N,1);
            hd(i) = StatesM(N,2);
            nd(i) = StatesM(N,3);
            
            
        end
    end
    
    Vmid=A\(2*Cm*V'/dt+TmpVec2');
    VV = 2*Vmid' - V;
    V = 2*Vmid' - V;
    % Output
    VHot(i) = V(stim.loc);
    for seg=1:N
        [StatesM(seg,1) StatesM(seg,2) StatesM(seg,3)]=DerivModel(dt, V(seg),  StatesM(seg,1), StatesM(seg,2), StatesM(seg,3));
    end
end
%%
figure(833);clf;
plot((1:Nt)*dt,VHot,'r')
figure(801);clf
plot(tneuron,hneuron);
hold on
plot(td,hd,'r');
