function TestAux(A,Aux)
N=size(A,1);
% B=rand(N,1);
A(eye(N)>0)=A(eye(N)>0)+rand(N,1)*10;
%%
% d=Aux.d;
e=Aux.e;
f=Aux.f;
B=Aux.B;
Ks=Aux.Ks;

d=diag(A);
HinesTriang2;
HinesBkSub2;
RealX=A\B;
SumErr=max(abs(RealX'-HX(1:N))./abs(RealX'));
% [max(abs(A*HX(1:N)'-B)) max(abs(A*RealX-B))]

Depth=Aux.Depth;
FatherBase=Aux.FatherBase;
Level=Aux.Level;
SegStartI=Aux.SegStartI;
SegEndI=Aux.SegEndI;
BranchP=Aux.BranchP;
RelVec=Aux.RelVec;
RelStarts=Aux.RelStarts;
RelEnds=Aux.RelEnds;
FIdxsX=Aux.FIdxsX;
LognDepth=Aux.LognDepth;

  
% Solve parallel
HinesTriangP2;
uHP=uHP';
HinesBkSubP2;

[RealX'; PX(1:N)]
SumErr=SumErr+max(abs(RealX'-PX(1:N))./abs(RealX'));
[max(abs(A*PX(1:N)'-B)) max(abs(A*RealX-B))]

HinesBkSubBP2;
[RealX'; bPX(1:N)]
max(abs(RealX'-bPX(1:N))./abs(RealX'))
[max(abs(A*bPX(1:N)'-B)) max(abs(A*RealX-B))]