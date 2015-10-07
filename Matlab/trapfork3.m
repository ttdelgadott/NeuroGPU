%
%  Gabbiani & Cox, Mathematics for Neuroscientists
%
% trapezoid on the fork
%
%  usage:   trapfork(dt,stim,pinc)
%
%               stim.t1 = start of current pulse (ms)
%               stim.t2 = end of current pulse (ms)
%               stpim.amp = amplitude of current pulse (micro amps)
%               stim.loc = location of current pulse (compartment num)
%               stim.Tfin = stopping time (ms)
% example:      
%       stim = struct('t1',1,'t2',2,'amp',1e-4,'loc',50,'Tfin',10)
%        dt = 0.1,    pinc = 4 
%
% or, for a pair of stimuli
%
% stim = struct('t1',[1 2],'t2',[2 3],'amp',1e-4*[1 1],...
%               'loc',[100 350],'Tfin',10)
%
%  or for say s=10 inputs over time Tfin=60
%  t1 = round(Tfin*rand(1,s));   t2 = t1+1;
%  loc = round(750*rand(1,10));    % our fork has 751 compartments
%  stim = struct('t1',t1,'t2',t2,'amp',1e-4*ones(1,s),'loc',loc,'Tfin',Tfin)
%

function trapfork3(dt,stim,pinc)

%  [H ell tau dx A3 Cm N]=BuiltMatrixByBook();
[H ell tau dx A3 Cm N]=BuiltMatrixByMe();


Hlen=size(H,1);

% What we need from this point:
% H
% Hlen
% ell


I = speye(Hlen);

Bb = I+(I+H)*(dt/tau/2); 
[L,U] = lu(Bb); 

x3 = 0:dx:ell(3);
x1 = ell(3):dx:ell(3)+ell(1);
x2 = ell(3):dx:ell(3)+ell(2);

v = zeros(Hlen,1);         % initial conditions
rhs = zeros(Hlen,1);

t = 0;
tcnt = 0;
x = linspace(0,ell(3)+max(ell(1:2)),Hlen);
figure(1)
plot3(x,t*ones(Hlen,1),v)
hold on

%eloc = round(Hlen*1e-4*stim.loc/sum(ell));
eloc = stim.loc;
Nt = ceil(stim.Tfin/dt);

vhot = zeros(1,Nt);

stim.amp = stim.amp*(dt/2)/A3/Cm;

f0 = stim.amp.*(t>stim.t1).*(t<stim.t2);
t = dt;
f1 = stim.amp.*(t>stim.t1).*(t<stim.t2);

r = zeros(Hlen,1);
r(eloc) = (f0 + f1)';
v1=[];v2=[];v3=[];
for j=2:Nt,

    v = U \ ( L \ r );

    vhot(j) = v(Hlen);
    
        
    if mod(j,pinc) == 0
         v1 = fliplr(v(1:N(1))');
         v2 = fliplr(v(N(1)+1:N(1)+N(2))');
         v3 = fliplr(v(N(1)+N(2):end)');
%           v3 = fliplr(v(N(1)+N(2)+1:end)');
         plot3(x3,t*ones(size(x3)),v3,'r')
         plot3(x2,t*ones(size(x2)),[v3(end) v2],'r')
         plot3(x1,t*ones(size(x1)),[v3(end) v1],'k')
%         plot3(xAll,t*ones(size(xAll)),[vAll(end) v1],'k')
    end
    p40 = find([v1 v2 v3]>0.00004);
    if(~isempty(p40))
        p40;
    end
   
    t = j*dt;
    f0 = f1;
    f1 = stim.amp.*(t>stim.t1).*(t<stim.t2);
    if(f1>0)
        'fff';
    end
    r = 2*v - r;
    r(eloc) = r(eloc) + (f0 + f1)';
end

xlabel('x (cm)','fontsize',14)
ylabel('t (ms)','fontsize',14)
zlabel('v (mV)','fontsize',14)
axis tight
hold off
