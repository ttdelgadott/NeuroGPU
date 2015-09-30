% clc;clear all;
mainStruct = CreateBaseStructure();
% ASC = 'A160706.ASC';
% ASC='SImpleSpindle.ASC';
ASC = '../Data/Cells/simple.ASC';

[Adj,Coords,Type,Parent,NSeg] = ReadASCFile(ASC);
[Lengths Diams] = CalcLengthAndDiams(Coords,Type,Parent);
% plotNeuron(Coords,Lengths,Diams);
%% Make smaller
CombineSegments; % Not a function!
%%
for i=1:numel(NSeg)
    RandLenForThisCompartement=rand*0+4.3;
    RandDiamForThisCompartement=rand*0+1.3;
    Lengths{i}=max(RandLenForThisCompartement,min(Lengths{i},RandLenForThisCompartement+rand*0));
    Diams{i}=max(RandDiamForThisCompartement,min(Diams{i},RandDiamForThisCompartement+rand*0));

    Lengths{i}=Lengths{i}*(10^(-4));
    Diams{i}=Diams{i}*(10^(-4));
    
%     Lengths{i}=(Lengths{i}*0+5)*(10^(-4));
%     Diams{i}=(Diams{i}*0+1)*(10^(-4));
    
%     Lengths{i}=(Lengths{1}*0+5)*(10^(-4));
%     Diams{i}=(Diams{1}*0+1)*(10^(-4));
%     NSeg(i)=NSeg(1);
end
% figure;plot([Diams{:}])
% figure;plot([Lengths{:}])

% [A N SegStartI R2 gL] = createMatrixNew(Lengths,Diams,NSeg,Adj);
[A N SegStartI R2 gL] = createMatrix(Lengths,Diams,NSeg,Adj);
% A=-A;
mainStruct(1).Stim.loc{2}=1;
[A] = insertStimulus(Lengths,Diams,R2,gL,mainStruct(1).Stim.loc,A,Type,SegStartI,1);
[FN FNP Aux] = CreatAuxiliaryData2(A,N,NSeg,Parent);
%%
% CudaFile =  'C:\Users\Roy\Documents\Visual Studio 2010\Projects\CudaNeuron\CudaStuff.cu';
% kForILP=N/32;
TestAux(A,Aux);
%%

 g = struct('K', 36, 'Na', 120, 'Cl', 1/15); 
stim = struct('t1',10,'t2',12,'amp',1e-2,'loc',10,'Tfin',50);
 dt = 0.01;
 pinc =4;
 
  dx = .0005;
A3 = 2*pi*Diams{2}(1)*dx; % Diameter at stim locaion
Cm = 1;

[t,Vhot] = stEfork3(g,stim,pinc,A, A3, Cm, NSeg, Aux)

% fid = fopen('C:\Users\Roy\Documents\Academics\NeuroGPU\Gilad2\VHotC.dat', 'rb');
% CNt=fread(fid,1,'uint16');
% CVHot=fread(fid,CNt,'float32');
% fclose(fid);
% 
figure(34);plot(t,Vhot,'b')

