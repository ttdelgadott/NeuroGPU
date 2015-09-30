function [H ell tau dx A3 Cm N Aux]=BuiltMatrixByMe()
 dx = .0005;
 [Adj NSeg A LengthArr Diams Aux] = CreateConstMat(dx);
 H=A;
 for i = 1:numel(LengthArr)
     ell(i) = sum(LengthArr{i});
 end
gL = 1/15;
Cm = 1;
tau = Cm/gL;

N = NSeg;
A3 = 2*pi*Diams{2}(1)*dx; % Diameter at stim locaion
 
