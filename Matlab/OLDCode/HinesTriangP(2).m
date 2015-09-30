%%
% Divide to independent levels
ISets{i}=[1 2 4 5];
ISets{2}=[3];
% assign junctions to sons, by level
Juncs{1}{1}=[3 1 2];
Juncs{2}{1}=[6 5 4 3];
Depth=2;
%%
for Level=1:depth
%     Run all independent set for this level, in parallel
    for JumctionI=1:NJunction(Level) % in parallel
%         sum relevant resuls
    end
end
%%
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