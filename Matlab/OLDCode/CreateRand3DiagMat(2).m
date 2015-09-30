N=2^3;
A=randi(10,N);
B=randi(10,N,1);
[X Y]=meshgrid(1:N,1:N);
A(abs(X-Y)>1)=0;
RealX=A\B;