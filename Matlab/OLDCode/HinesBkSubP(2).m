%%
FatherBase=[];
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)>0)+i;
    end
    FatherBase(i)=k;
end
%%
Father=[FatherBase numel(FatherBase)+2 numel(FatherBase)+2];
FIdxsX=[];
for i=1:log2(N)
    CurF=1:numel(Father);
    for j=1:2^(i-1)
        CurF=Father(CurF);
    end
    FIdxsX(i,:)=CurF;
end
%%
f=[];
for i=1:N-1
    f(i)=A(i,FatherBase(i));
end
f(end+1)=1;
u=uH';
PY=bH;
%%
PX=PY'./u; % in parallel
PF=-f./u; % in parallel
PF(numel(Father))=1;
PX(numel(Father))=0;

for i=1:log2(N)
    %     disp([1 i]);
    OldPX=PX;
    OldPF=PF;
    for j=1:N % in parallel
        NextID=FIdxsX(i,j);
        PX(j)=OldPX(j)+OldPX(NextID)*PF(j);
        PF(j)=OldPF(j)*OldPF(NextID);
    end
end
[RealX'; PX(1:N)]