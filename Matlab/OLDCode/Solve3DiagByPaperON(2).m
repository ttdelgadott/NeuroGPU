%% From Paper, O(N)
% d(i)=A(i,i)
% f(i)=A(i,i+1)
% e(i)=A(i-1,i)
% Forward sweep
U=A;
U(X<Y)=0; % remove lower half
u(1)=A(1,1);
for i=2:N
    u(i)=A(i,i)-(A(i,i-1)*A(i-1,i)/u(i-1));
end
U(X==Y)=u;

L=eye(N);
m(2)=A(2,1)/A(1,1);
for i=3:N
    m(i)=A(i,i-1)/u(i-1);
end
L(Y-X==1)=m(2:end);

y(1)=B(1);
for i=2:N
    y(i)=B(i)-m(i)*y(i-1);
end
% Back substitution
NX(N)=y(N)/u(N);
for i=N-1:-1:1
    NX(i)=(y(i)-NX(i+1)*A(i,i+1))/u(i);
end