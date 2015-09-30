% HX(N)=bH(N)/uH(N);
% for i=N-1:-1:1
%     k=Ks(i+1);
%     HX(i)=(bH(i)-HX(k)*A(i,k))/uH(i);
% end
% [RealX'; HX]

HX(N)=bH(N)/uH(N);
for i=N-1:-1:1
    k=Ks(i+1);
    HX(i)=(bH(i)-HX(k)*f(i))/uH(i);
end
% RealX=A\B;
% [RealX'; HX]

% max(abs(RealX'-HX(1:N))./abs(RealX'))
% 
% [max(abs(A*HX(1:N)'-B)) max(abs(A*RealX-B))]