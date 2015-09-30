uH=diag(A);
bH=B;
for i=2:N
    if(A(i,i-1)~=0) % Normal
        uH(i)=uH(i)-(A(i,i-1)*A(i-1,i)/uH(i-1)); % So far same as paper parallel
        bH(i)=bH(i)-bH(i-1)*A(i,i-1)/uH(i-1); % bH is y
    else % junction
        k=find(A((i+1):end,i-1)>0)+i;
        uH(k)=uH(k)-A(k,i-1)*(A(i-1,k)/uH(i-1));
        bH(k)=bH(k)-bH(i-1)*A(k,i-1)/uH(i-1);
    end
end
HX(N)=bH(N)/uH(N);
for i=N-1:-1:1
    if(A(i,i+1)~=0)
        HX(i)=(bH(i)-HX(i+1)*A(i,i+1))/uH(i);
    else
        k=find(A((i+1):end,i)>0)+i;
        HX(i)=(bH(i)-HX(k)*A(i,k))/uH(i);
    end
end