a = 1e-4*[1 1 1];
% ell = [2.5 2.5 2.5]/100;
% dx = .0001;

ell=[4 4 3];
dx=1;

N = ell/dx;
A3 = 2*pi*a(3)*dx;
As = 4*pi*1e-6;
rho = A3/As;
R2 = 0.3;
gL = 1/15;
Cm = 1;
tau = Cm/gL;
lam = a/(2*R2*gL)/dx^2;   % lambda^2
r = a/a(3);
Hd = [2*lam(1)*ones(1,N(1)) 2*lam(2)*ones(1,N(2)) 2*lam(3)*ones(1,N(3)+1)];
Hd(1) = lam(1);
Hd(N(1)+1) = lam(2);
Hd(N(1)+N(2)+1) =  lam*r';
Hd(end) = rho*lam(3);
Hlen = length(Hd);

Hu = [-lam(1)*ones(1,N(1)-1) 0 -lam(2)*ones(1,N(2)) -lam(3)*ones(1,N(3))];
Hl = [-lam(1)*ones(1,N(1)-1) 0 -lam(2)*ones(1,N(2)-1) -r(2)*lam(2) -lam(3)*ones(1,N(3))];
Hl(end) = rho*Hl(end);

H = spdiags( [[Hl 0]' Hd' [0 Hu]'], -1:1, Hlen, Hlen);

H(N(1)+N(2)+1,N(1)) = -r(1)*lam(1);
H(N(1),N(1)+N(2)+1) = -lam(1);
Ns=N;
H=-full(H);
A=H;