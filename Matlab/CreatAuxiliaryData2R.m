%% Ks
function [FN FNP FNM Aux]=CreatAuxiliaryData2R(A,N,NSeg,Parent,cmvec)
CN=cumsum(NSeg);
NComp=numel(NSeg);
Tcount=0;
clear T
for i=1:NComp
    Adj{i}=find(Parent==i);
    if(numel(Adj{i})>0)
        Tcount=Tcount+1;
%         T{Tcount}=[NComp+1-i NComp+1-Adj{i}];
        T{Tcount}=[i Adj{i}];
    end
end
%NSeg = NSeg+1;
%%
% for i=2:N
%     if(A(i,i+1)~=0) % Normal
%         k=i;
%     else % junction
% %         k=find(A(1:(i+1),i-1)>0)+i;
%         k=find(A((i+1):end,i)~=0)+i;
%     end
%     Ks(i)=k;
% end
%% Parent
FatherBase=[];
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)~=0)+i;
    end
    FatherBase(i)=k;
end
Ks=[0 FatherBase];
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
%% Independent sets
Level=NSeg*0;
TB=T;
CurLevel=0;
while(numel(TB)>0)
    CurLevel=CurLevel+1;
    for i=1:numel(TB)
        if(numel(TB{i}>1))
            Level(TB{i}(1))=CurLevel;
        end
    end
    TNs=zeros(numel(TB));
    for i=1:numel(TB)
        TB{i}=TB{i}(Level(TB{i})>=CurLevel);
        TNs(i)=numel(TB{i});
    end
    TB=TB(TNs>1);
    if(length(TB)==1)
        disp ['we have one'];
    end
end
Depth=max(Level);
BranchP=CN(1:end-1)+1;
SegStartI=[0 CN(1:end-1)]+2;
SegEndI=CN;
% which results go to which parentm
for CurLevel=1:Depth
    CurBranches=find(Level==CurLevel);
    for CurB=CurBranches
        Related{CurB}=find(Ks==BranchP(CurB-1));
        %         SegStartI(CurB)=SegStartI(CurB)+1;
    end
end

[RelStarts RelEnds RelCN RelVec]=Cell2Vec(Related);

Aux.Ks=Ks;
Aux.FatherBase=FatherBase;

Aux.Depth=Depth;
Aux.Level=Level;
Aux.SegStartI=SegStartI;
Aux.SegEndI=SegEndI;
Aux.BranchP=BranchP;
Aux.RelVec=RelVec;
Aux.RelStarts=RelStarts;
Aux.RelEnds=RelEnds;
Aux.FIdxsX=FIdxsX;
Aux.LognDepth=LognDepth;
Aux.T=T;
%%
% fid=fopen('TreeData.x','wb');
% fwrite(fid,[N NComp d e f B' Ks RelStarts RelEnds RelCN RelVec LognDepth Depth Level BranchP SegStartI SegEndI] ,'uint16');
% fwrite(fid,FIdxsX ,'uint16');
% fclose(fid);
%% d e f
d=diag(A)';
f=[];
e=0;
for i=1:N-1
    f(i)=A(i,FatherBase(i));
    e(i+1)=A(FatherBase(i),i);
end
f(end+1)=1;
B=rand(N,1);
RealX=A\B;
%%
FN=['..\Data\BasicConst' num2str(N) 'Seg.mat'];
FNP=['..\Data\BasicConst' num2str(N) 'SegP.mat'];
FNM=['..\Data\ParamsMat' num2str(N) '.mat'];
Aux.d=d;
Aux.e=e;
Aux.f=f;
Aux.B=B;
%%
fid=fopen(FN,'wb');
fwrite(fid,numel(Parent),'uint16');
fwrite(fid,N,'uint16');
fwrite(fid,[d e f B'],'float32');
fwrite(fid,Ks,'uint16');
fwrite(fid,RealX,'float32');
fwrite(fid,SegStartI,'uint16');
fwrite(fid,cmvec,'float32');
fclose(fid);
%% 32 data
CompByLevel32=zeros(0,32);

for CurLevel=0:Depth
    CurComps=find(Level==CurLevel); % in parallel
    Longer = ones(1,ceil(numel(CurComps)/32)*32)*CurComps(end);
    Longer(1:numel(CurComps))=CurComps;
    StuffToAdd=reshape(Longer,[32,numel(Longer)/32])';
    CompByLevel32=[CompByLevel32; StuffToAdd];
end
CompDepth32=size(CompByLevel32,1);
%%
Nd32=ceil(N/32);
N32=Nd32*32;
%% Full parallel data
fid=fopen(FNP,'wb');
fwrite(fid,N,'uint16');
fwrite(fid,[d e f B'],'float32');
fwrite(fid,Ks,'uint16');
fwrite(fid,RealX,'float32');
fwrite(fid,[NComp Depth LognDepth RelStarts RelEnds RelVec Level BranchP SegStartI SegEndI],'uint16');
fwrite(fid,FIdxsX ,'uint16');
%% 32 data
fwrite(fid,[Nd32 N32 CompDepth32],'uint16');
fwrite(fid,CompByLevel32' ,'uint16');
fclose(fid);
