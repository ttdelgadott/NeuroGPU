% N is power of 2
%% LU Decomposition
d=diag(A,0)';
e=[1; diag(A,-1)]';
f=[diag(U,1); 1]';
%%
EF=[0 -e(2:N).*f(1:N-1)]; % in parallel
QIM2=ones(1,N+2); % in parallel
QIM1=[1 d]; % in parallel
QI=[d(1) d(2:N).*d(1:N-1)+EF(2:N)]; % in parallel
for i=2.^(1:log2(N/2))
    TEMP(i-1:N)=QIM1(i:N+1).*QIM1(1:N-i+2)+EF(1:N-i+2).*QIM2(i+1:N+2).*QIM2(1:N-i+2); % in parallel
    QIM1(i+1:N+1)=QI(i:N).*QIM1(1:N-i+1)+EF(1:N-i+1).*QIM1(i+1:N+1).*QIM2(1:N-i+1); % in parallel
    QIM2(i+1:N+2)=TEMP(i-1:N); % in parallel
    QI(i+1:N)=d(i+1:N).*QIM1(i+1:N)+EF(i+1:N).*QIM2(i+1:N); % in parallel
end
% --
PU=QI(1:end)./[1 QI(1:end-1)]; % (16)
PPM=[0 e(2:end)./PU(1:end-1)]; % (2)
% [PU; u]
%% After LU decomposition
% L is  [1 0 0]
%       [m 1 0]
%       [0 m 1]
% U is  [u f 0]
%       [0 u f]
%       [0 0 u]
% (3) Ly=b -> y1=b1, yi=bi-mi*y(i-1)
% initialize
PY=B; % in parallel
PM=-m; % in parallel
for i=2.^(0:log2(N/2))
    %     disp([1 i]);
    OldPY=PY;
    OldPM=PM;
    for j=(i+1):N % in parallel
        PY(j)=OldPY(j)+OldPY(j-i)*PM(j);
        PM(j)=OldPM(j)*OldPM(j-i);
    end
end
% [PY y']
%%
% (4) Ux=y -> xN=yN/uN, xi=(yi-x(i+1)*fi)/ui
% initialize
PX=PY'./u; % in parallel
PF=-f./u; % in parallel
for i=2.^(0:log2(N/2))
    %     disp([1 i]);
    OldPX=PX;
    OldPF=PF;
    for j=1:(N-i) % in parallel
        PX(j)=OldPX(j)+OldPX(j+i)*PF(j);
        PF(j)=OldPF(j)*OldPF(j+i);
    end
end
% [RealX'; PX]
%% Other way, like lower trdiagonal
% (4) Ux=y -> xN=yN/uN, xi=(yi-x(i+1)*fi)/ui
% initialize
f=[diag(A,1); 1];
PX=PY./u'; % in parallel
PF=-f./u'; % in parallel
PX=PX(end:-1:1);
PF=PF(end:-1:1);
for i=2.^(0:log2(N/2))
    %     disp([1 i]);
    OldPX=PX;
    OldPF=PF;
    for j=(i+1):N % in parallel
        PX(j)=OldPX(j)+OldPX(j-i)*PF(j);
        PF(j)=OldPF(j)*OldPF(j-i);
    end
end
PX=PX(end:-1:1);
PF=PF(end:-1:1);