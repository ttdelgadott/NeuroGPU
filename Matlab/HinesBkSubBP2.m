bPX=zeros(1,N);
% bPX(EndLastLevelsI)=bH(EndLastLevelsI)./uH(EndLastLevelsI);

for CurLevel=Depth:-1:0
    %     Run all independent set for this level, in parallel
    for JumctionI=find(Level==CurLevel) % in parallel
        for i=(SegEndI(JumctionI)):-1:(SegStartI(JumctionI)-1)
            k=KsB(i+1);
            bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
        end
    end
end

% [RealX'; bPX(1:N)]
% 
% max(abs(RealX'-bPX(1:N))./abs(RealX'))
% 
% [max(abs(A*bPX(1:N)'-B)) max(abs(A*RealX-B))]