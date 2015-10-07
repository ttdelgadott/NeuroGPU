function [H ell tau dx A3  N]=BuiltMatrixByMe2()
 [Adj NSeg A LengthArr Diams ] = CreateConstMat();
 H=A;
 dx = .0001;
 for i = 1:numel(LengthArr)
     ell(i) = sum(LengthArr{i});
 end
gL = 1/15;
Cm = 1;
tau = Cm/gL;

N = NSeg;
A3 = 2*pi*Diams{2}(1)*dx;
 
