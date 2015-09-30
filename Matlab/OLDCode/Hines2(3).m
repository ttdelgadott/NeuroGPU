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
HX(N)=bH(N)/uH(N);
Hs2=cell(1,N);
Hs2{1}=Hs{end};
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)>0)+i;
    end
    HX(i)=(bH(i)-HX(k)*A(i,k))/uH(i);
    Ks2(i)=k;
    Hs2{N+1-i}=Hs2{N-i};
    Hs2{N+1-i}(i,:)=Hs2{N+1-i}(i,:)-Hs2{N-i}(k,:)*A(i,k)/uH(k);
end
[RealX'; HX]
figure(1231);clf;
for i=1:N
    subplot(3,6,i);
    imagesc(abs(Hs{i})>0.000001);
end
figure(1232);clf;
for i=1:N
    subplot(3,6,i);
    imagesc(abs(Hs2{i})>0.000001);
end