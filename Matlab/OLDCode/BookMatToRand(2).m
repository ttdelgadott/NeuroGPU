N=size(A,1);
A2=randi(10,N);
B=randi(10,N,1);
A(A~=0)=A2(A~=0);
RealX=A\B;