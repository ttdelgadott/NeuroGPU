function Out=SolveByUsP(Aux,NewDiag,NewB)

e=Aux.e;
f=Aux.f;
B=NewB;
Ks=Aux.Ks;

d=NewDiag;
N=numel(Ks);

Level=Aux.Level;
FLevel=Aux.FLevel;
Depth=Aux.Depth;
SegStartI=Aux.SegStartI;
SegEndI=Aux.SegEndI;
RelVec=Aux.RelVec;
RelStarts=Aux.RelStarts;
RelEnds=Aux.RelEnds;
FIdxsX=Aux.FIdxsX;
LognDepth=Aux.LognDepth;
Fathers=Aux.Fathers;

LRelStarts=Aux.LRelStarts;
LRelEnds=Aux.LRelEnds;
FLRelStarts=Aux.FLRelStarts;
FLRelEnds=Aux.FLRelEnds;
CompByFLevel32=Aux.CompByFLevel32;
CompByLevel32=Aux.CompByLevel32;

% Solve serial
% HinesTriang2;
% HinesBkSub2;
% Out=HX;

% MakeTreeFromParentVec;

% 
% Solve parallel
 HinesTriangP2Ks;
% HinesTriangP2Ks32;
% HinesBkSubP2;
% Out=PX(1:N);

% % Alternative BkSub
KsB=Aux.KsB;
uH=uHP';
bH=bHP;
HinesBkSubBP2;
Out=bPX;