HX(N)=bH(N)/uH(N);
for i=N-1:-1:1
    k=Ks(i+1);
    HX(i)=(bH(i)-HX(k)*A(i,k))/uH(i);
end
[RealX'; HX]
