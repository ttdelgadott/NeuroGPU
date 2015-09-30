RandStream.setDefaultStream(RandStream('mt19937ar','seed',209416));
% rand(1,5)

% ReadASCFile;Ns=NSeg;
%Ns=Ns*0+3;
% CreateBookMat6;

[Adj NSeg A LengthArr Diams Aux] = CreateConstMat(.0005);


Ks=Aux.Ks;
FatherBase=Aux.FatherBase;

Level=Aux.Level;
Depth=Aux.Depth;
SegStartI=Aux.SegStartI;
SegEndI=Aux.SegEndI;
BranchP=Aux.BranchP;
RelVec=Aux.RelVec;
RelStarts=Aux.RelStarts;
RelEnds=Aux.RelEnds;
FIdxsX=Aux.FIdxsX;
LognDepth=Aux.LognDepth;

d=diag(A)';

N=numel(d);

f=[];
e=0;
for i=1:N-1
    f(i)=A(i,FatherBase(i));
    e(i+1)=A(FatherBase(i),i);
end
f(end+1)=1;

% B=randi(100,size(A,1),1)-1500;
load('asd.mat');
% CreatAuxiliaryData;
% Solve serial
HinesTriang2;
HinesBkSub2;

% Solve parallel
HinesTriangP2;
HinesBkSubP2;