stim = struct('t1',1,'t2',2,'amp',1e-4,'loc',50,'Tfin',10)
 dt = 0.1;
 pinc = 4;
 trapfork(dt,stim,pinc)

%CreateBookMat;

%B=randi(10,N,1);
%RealX=A\B;