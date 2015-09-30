function Out=randi(imax,N,M)
if(nargin==3)
    N=[N M];
else
    if(nargin==1)
        N=1;
    end
    if(numel(N)==1)
        N=[N N];
    end
end
Out=ceil(imax*rand([N(1),N(2)])) ;