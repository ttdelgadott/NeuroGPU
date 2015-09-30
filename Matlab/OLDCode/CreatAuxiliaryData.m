%% Ks
for i=2:N
    if(A(i,i-1)~=0) % Normal
        k=i;
    else % junction
        k=find(A((i+1):end,i-1)>0)+i;
    end
    Ks(i)=k;
end
%% Parent
FatherBase=[];
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)>0)+i;
    end
    FatherBase(i)=k;
end
%
Father=[FatherBase numel(FatherBase)+2 numel(FatherBase)+2];
FIdxsX=[];
for i=1:log2(N)
    CurF=1:numel(Father);
    for j=1:2^(i-1)
        CurF=Father(CurF);
    end
    FIdxsX(i,:)=CurF;
end
FIdxsX=FIdxsX(1:find(all(FIdxsX==FIdxsX(end),2),1),:);
LognDepth=size(FIdxsX,1);
%% d e f
d=diag(A)';
f=[];
e=0;
for i=1:N-1
    f(i)=A(i,FatherBase(i));
    e(i+1)=A(FatherBase(i),i);
end
f(end+1)=1;
%% Independent sets
Level=Ns*0;
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
%%
fid=fopen('TreeData.x','wb');
fwrite(fid,[N NComp d e f B' Ks RelStarts RelEnds RelCN RelVec LognDepth Depth Level BranchP SegStartI SegEndI] ,'uint16');
fwrite(fid,FIdxsX ,'uint16');
fclose(fid);