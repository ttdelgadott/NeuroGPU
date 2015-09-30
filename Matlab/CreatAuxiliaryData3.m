%% Ks
function [FN FNP FNM Aux]=CreatAuxiliaryData3(A,N,NSeg,Parent,Neuron,cmVec,FN_TopoList)
%% Parent
FTYPESTR='float';

FatherBase=[];
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)~=0)+i;
    end
    FatherBase(i)=k;
end

d=diag(A)';
f=[];
e=0;
for i=1:N-1
    f(i)=A(i,FatherBase(i));
    e(i+1)=A(FatherBase(i),i);
end
f(end+1)=0;
% for seg=1:N
%     Ksx(seg)=  getParentInd(Neuron,seg);
%    
% end
Ksx = getParentFromNeuron(FN_TopoList);
Ks=[0 N+1-Ksx(N+2-(2:end))];
Aux.Ks=Ks;
FatherBase=Ks(2:end);
%
Father=[FatherBase numel(FatherBase)+2 numel(FatherBase)+2];
FIdxsX=[];
for i=1:ceil(log2(N))+3
    CurF=1:numel(Father);
    for j=1:2^(i-1)
        CurF=Father(CurF);
    end
    FIdxsX(i,:)=CurF;
end
if ~isempty(find(all(FIdxsX==FIdxsX(end),2),1))
    FIdxsX=FIdxsX(1:find(all(FIdxsX==FIdxsX(end),2),1)-1,:);
end
LognDepth=size(FIdxsX,1);

FIdxsX=FIdxsX(:,1:N);

Aux.FIdxsX=FIdxsX;
Aux.LognDepth=LognDepth;
%%
Nx=N;
ParentUsed=zeros(1,Nx);
for seg=1:Nx
    if(seg==1)
        parentIndex=1;
    else
        parentIndex =Nx+1-Aux.Ks(Nx+2-seg);
    end
    ParentUsed(parentIndex)=ParentUsed(parentIndex)+1;
    SonNoVec(seg)=ParentUsed(parentIndex);
end
% Should check if that works on real cell!
SonNoVec(1)=0;
        
Aux.SonNoVec=SonNoVec;
if max(SonNoVec)>2
    exception = MException('SonNoVec>2');
    disp('error max(SonNoVec)>2 ');
    throw(exception);
end
%% Independent sets
MakeTreeFromParentVec;


Aux.Depth=Depth;
Aux.Level=Level;
Aux.FLevel=FLevel;
Aux.SegStartI=SegStartI;
Aux.SegEndI=SegEndI;
Aux.Fathers=Fathers;

Aux.RelVec=RelVec;
Aux.RelStarts=RelStarts;
Aux.RelEnds=RelEnds;

%%
LastLevelsI=find(Level==max(Level));
EndLastLevelsI=SegEndI(LastLevelsI);
KsB=Ks;
KsB(EndLastLevelsI+1)=EndLastLevelsI;
Aux.KsB=KsB;
%%
% fid=fopen('TreeData.x','wb');
% fwrite(fid,[N NComp d e f B' Ks RelStarts RelEnds RelCN RelVec LognDepth Depth Level BranchP SegStartI SegEndI] ,'uint16');
% fwrite(fid,FIdxsX ,'uint16');
% fclose(fid);
%%
FN=['..\Data\BasicConst' num2str(N) 'Seg.mat'];
FNP=['..\Data\BasicConst' num2str(N) 'SegP.mat'];
FNM=['..\Data\ParamsMat' num2str(N) '.mat'];
Aux.d=d;
Aux.e=e;
Aux.f=f;
%%
% boolHasHH = zeros(1,N);
% boolHasHH(Neuron.HasHH)=1;
% Aux.boolHasHH=boolHasHH;
Aux.Cms=Neuron.Cms;
fid=fopen(FN,'wb');
% fwrite(fid,numel(Parent),'uint16');
fwrite(fid,N,'uint16');
% fwrite(fid,sum(Neuron.NSegs),'uint16');
fwrite(fid,[e f],'double');
fwrite(fid,Ks,'uint16');
% fwrite(fid,RealX,FTYPESTR);
% fwrite(fid,SegStartI,'uint16');
fwrite(fid,Aux.Cms,FTYPESTR);
fwrite(fid,Neuron.HasHH,'uint16');

% fwrite(fid,Neuron.ParentInds-1,'uint16');
fclose(fid);
%% 32 data
CompByLevel32=zeros(0,32);
CompByFLevel32=zeros(0,32);

for CurLevel=0:Depth
    CurComps=find(Level==CurLevel); % in parallel
    nComps(CurLevel+1)=numel(CurComps);
    Longer = ones(1,ceil(numel(CurComps)/32)*32)*CurComps(end);
    Longer(1:numel(CurComps))=CurComps;
    StuffToAdd=reshape(Longer,[32,numel(Longer)/32])';
    StartPoint=size(CompByLevel32,1)+1;
    CompByLevel32=[CompByLevel32; StuffToAdd];
    EndPoint=size(CompByLevel32,1);
    LRelated{CurLevel+1}=StartPoint:EndPoint;

    nRoundForThisLevel(CurLevel+1)=size(CompByLevel32,1);
    if(CurLevel<Depth)
        CurComps=find(FLevel==(CurLevel+1)); % in parallel
        nFComps(CurLevel+1)=numel(CurComps);
        Longer = ones(1,ceil(numel(CurComps)/32)*32)*CurComps(end);
        Longer(1:numel(CurComps))=CurComps;
        StuffToAdd=reshape(Longer,[32,numel(Longer)/32])';
        StartPoint=size(CompByFLevel32,1)+1;
        CompByFLevel32=[CompByFLevel32; StuffToAdd];
        EndPoint=size(CompByFLevel32,1);
        FLRelated{CurLevel+1}=StartPoint:EndPoint;
    end
end

[LRelStarts LRelEnds LRelCN LRelVec]=Cell2Vec(LRelated);
if(Depth==0)
    FLRelStarts=[];
    FLRelEnds=[];
    FLRelCN=[];
    FLRelVec=[];
else
    [FLRelStarts FLRelEnds FLRelCN FLRelVec]=Cell2Vec(FLRelated);
end

Aux.LRelStarts=LRelStarts;
Aux.LRelEnds=LRelEnds;
Aux.FLRelStarts=FLRelStarts;
Aux.FLRelEnds=FLRelEnds;
CompDepth32=size(CompByLevel32,1);
CompFDepth32=size(CompByFLevel32,1);
Aux.CompByLevel32=CompByLevel32;
Aux.CompByFLevel32=CompByFLevel32;
%%
NComps = length(NSeg);
CompsMid = zeros(1,NComps);
for i=1:NComps
    CompsMid(i) = Neuron.SegStart(i) + floor(Neuron.NSegs(i)/2);
    
end

CompsMid(1) = CompsMid(1)+1;
Nd32=ceil(N/32);
N32=Nd32*32;
nFathers=numel(Fathers);
nCallForFather=numel(CallForFathers);
Aux.nCallForFather = nCallForFather;
% %% Full parallel data
fid=fopen(FNP,'wb');
fwrite(fid,N,'uint16');
fwrite(fid,NComps,'uint16');
fwrite(fid,[e f],'double');
fwrite(fid,Ks,'uint16');
fwrite(fid,Neuron.SegToComp-1,'uint16');
%fwrite(fid,CompsMid-1,'uint16');
fwrite(fid,cmVec,FTYPESTR);
fwrite(fid,size(Neuron.HasHH,1),'uint16');
fwrite(fid,Neuron.HasHH','uint16');
fwrite(fid,SonNoVec,'uint16');
fwrite(fid,[Depth LognDepth nFathers nCallForFather RelStarts RelEnds RelVec SegStartI SegEndI],'uint16');
fwrite(fid,Aux.Fathers,'uint16');
fwrite(fid,FIdxsX' ,'uint16');

% %% 32 data
% fwrite(fid,[Nd32 N32 CompDepth32],'uint16');
fwrite(fid,CompDepth32 ,'uint16');
fwrite(fid,CompFDepth32 ,'uint16');
fwrite(fid,CompByLevel32' ,'uint16');
fwrite(fid,CompByFLevel32' ,'uint16');
Aux.CompDepth = CompDepth32;
Aux.CompFDepth = CompFDepth32;
fwrite(fid,numel(Aux.LRelStarts),'uint16');
fwrite(fid,Aux.LRelStarts-1,'uint16');
fwrite(fid,Aux.LRelEnds-1,'uint16');
fwrite(fid,numel(Aux.FLRelStarts),'uint16');
fwrite(fid,Aux.FLRelStarts-1,'uint16');
fwrite(fid,Aux.FLRelEnds-1,'uint16');

fwrite(fid,Aux.KsB-1,'uint16');

fclose(fid);