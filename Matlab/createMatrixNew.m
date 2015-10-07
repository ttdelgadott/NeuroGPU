function [A N SegStartI R2 gL]= createMatrixNew(LengthArr,Diams,NSeg,Adj)
R2 = 0.3;
Rtag=R2;
gL = 1/15;
LengthVec=[LengthArr{:}];
DiamsVec=[Diams{:}];
gVec=DiamsVec*0+gL;

CN=cumsum(NSeg);
N=sum(NSeg);
SegStartI=[0 CN(1:end-1)]+1;
SegEndI=CN;
% SegToComp=zeros(2,N);
% for i=1:numel(NSeg)
%     SegToComp(1,SegStartI(i):SegEndI(i))=i;
%     SegToComp(2,SegStartI(i):SegEndI(i))=1:(SegEndI(i)-SegStartI(i)+1);
% end
A=zeros(N);
% [X Y]=meshgrid(1:N,1:N);
% A(abs(X-Y)>1)=0;
%connecting segments compartments together and leaving compartments
%unconnected to each other.
for i=1:numel(Diams)
    %     matInds = SegToComp(:,i);
    for j=1:numel(Diams{i})
        CurInd=SegStartI(i)+j-1;
        if(j>1)
            A(CurInd,CurInd) = CalcDiagCoeff(gVec,CurInd-1,CurInd,LengthVec,DiamsVec,Rtag);
        else
            A(CurInd,CurInd) = CalcDiagCoeff(gVec,[],CurInd,LengthVec,DiamsVec,Rtag);
        end
        if( j<numel(Diams{i}))
            A(CurInd+1,CurInd) = CalcSubDiagCoeff(gVec,CurInd,CurInd+1,LengthVec,DiamsVec,Rtag);
            A(CurInd,CurInd+1) = CalcSuperDiagCoeff(gVec,CurInd,LengthVec,Rtag);
        end
    end
    %case it is the first segment in the compartment disconect it from the
    %previous segment
    %     if(matInds(2)==1)
    % %         A(i,i) = aa;
    %         if(i>1)
    %             A(i-1,i) = 0;
    %             A(i,i-1) = 0;
    %         end
    %     end
end
%connecting between compartments
for i=1:numel(NSeg)
    adjs = Adj{i};
    parentInd = SegStartI(i);
    if(numel(adjs)>0)
        for j=1:numel(adjs)
            sonInd = SegEndI(adjs(j));
            A(parentInd,sonInd)=CalcSuperDiagCoeff(gVec,sonInd,LengthVec,Rtag);
            A(sonInd,parentInd)=CalcSubDiagCoeff(gVec,sonInd,parentInd,LengthVec,DiamsVec,Rtag);
        end
    end
    A(parentInd,parentInd)=CalcDiagCoeff(gVec,adjs,parentInd,LengthVec,DiamsVec,Rtag);
end
% %insert stimulus
