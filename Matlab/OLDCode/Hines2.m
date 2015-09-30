uH=diag(A);
bH=B;
for i=2:N
    if(A(i,i-1)~=0) % Normal
        k=i;
    else % junction
        k=find(A((i+1):end,i-1)>0)+i;
    end
    uH(k)=uH(k)-A(k,i-1)*(A(i-1,k)/uH(i-1)); % So far same as paper parallel
    bH(k)=bH(k)-bH(i-1)*A(k,i-1)/uH(i-1); % bH is y
end
HX(N)=bH(N)/uH(N);
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        k=i+1;
    else
        k=find(A((i+1):end,i)>0)+i;
    end
    HX(i)=(bH(i)-HX(k)*A(i,k))/uH(i);
end