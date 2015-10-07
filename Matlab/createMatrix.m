function [A N SegStartI R2 gL]= createMatrix(LengthArr,Diams,NSeg,Adj)
R2 = 0.3;
gL = 1/15;
CN=cumsum(NSeg);
N=sum(NSeg);
SegStartI=[0 CN(1:end-1)]+1;
SegEndI=CN;
SegToComp=zeros(2,N);
for i=1:numel(NSeg)
   SegToComp(1,SegStartI(i):SegEndI(i))=i;
   SegToComp(2,SegStartI(i):SegEndI(i))=1:(SegEndI(i)-SegStartI(i)+1);
end
A=ones(N);
[X Y]=meshgrid(1:N,1:N);
A(abs(X-Y)>1)=0;
%connecting segments compartments together and leaving compartments
%unconnected to each other.
%for i=1:length(SegToComp)
for i=1:size(SegToComp,2)
    matInds = SegToComp(:,i);
    dx = LengthArr{matInds(1)}(matInds(2));
    a = Diams{matInds(1)}(matInds(2));
    lambda2 = (a/(2*R2*gL))/dx^2;
    A(i,i) = 2*lambda2;
    if( i<length(SegToComp))
        A(i+1,i) = -lambda2;
        A(i,i+1) = -lambda2;
        if(lambda2==0)
           disp('WARNING 0 in MAT X~~~~~');
        end
        if(~isfinite(lambda2))
           disp('WARNING INF in MAT X~~~~~');
       end
    end
    %case it is the first segment in the compartment disconect it from the
    %previous segment
    if(matInds(2)==1)
        A(i,i) = lambda2;
        if(i>1)
            A(i-1,i) = 0;
            A(i,i-1) = 0;
        end
    end 
end
%connecting between compartments
for i=1:numel(NSeg)
   adjs = Adj{i};
   if(numel(adjs)>0)
   parentInd = SegStartI(i);
   parent_dx = LengthArr{i}(1);
   parent_a = Diams{i}(1);
   parentLambda = (parent_a/(2*R2*gL))/parent_dx^2;
   c=parentLambda;
   for j=1:numel(adjs) 
       sonInd = SegEndI(adjs(j));
       son_dx = LengthArr{adjs(j)}(end);
       son_a = Diams{adjs(j)}(end);
       sonLambda = (son_a/(2*R2*gL))/son_dx^2;
       r= son_a/parent_a;
       if(sonLambda==0 || r==0)
           disp('WARNING 0 in MAT~~~~~');
       end
       if(~isfinite(sonLambda) || ~isfinite(r))
           disp('WARNING INF in MAT~~~~~');
       end
       A(parentInd,sonInd)=-r*sonLambda;
       A(sonInd,parentInd)=-sonLambda;
       c = c+r*sonLambda;
       if(parentInd ==1 && sonInd ==1)
           disp(A(parentInd,sonInd));
       end
   end
   A(parentInd,parentInd)=c;
   end
end
%insert stimulus
