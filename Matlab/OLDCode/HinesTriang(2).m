uH=diag(A);
bH=B;
clear HX
BHs=zeros(N);
BHs(:,1)=bH;
Hs=cell(1,N);
Hs{1}=A;
for i=2:N
    if(A(i,i-1)~=0) % Normal
        k=i;
    else % junction
        k=find(A((i+1):end,i-1)>0)+i;
    end
    uH(k)=uH(k)-A(k,i-1)*(A(i-1,k)/uH(i-1)); % So far same as paper parallel
    bH(k)=bH(k)-bH(i-1)*A(k,i-1)/uH(i-1); % bH is y
    Hs{i}=Hs{i-1};
    Hs{i}(k,:)=Hs{i}(k,:)-Hs{i-1}(i-1,:)*A(k,i-1)/uH(i-1);
    BHs(:,i)=bH;
    Ks(i)=k;
end