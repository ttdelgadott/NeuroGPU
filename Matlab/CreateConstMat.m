% Ns=[3 3 3 3 3 3];
% T{1}=[6 5 4 3];
% T{2}=[3 2 1];
function [Adj NSeg A LengthArr Diams Aux] = CreateConstMat(dX)
% NSeg = [10 10 10];
% Parent = [3 3 0];

NSeg = [8 8 8 8];
Parent = [4 4 4 0];

% NSeg = [8 8 8 8]*2;
% Parent = [4 4 4 0];

% NSeg = ones(1,16)*8;
% Parent = NSeg*0+numel(NSeg);
% Parent(end)=0;

NComp=numel(NSeg);
for i=1:NComp
    Adj{i}=find(Parent==i);
end

% LengthArr = Adj;
% Diams = Adj;
%creating fake lengths and diams for the soma
% LengthArr{end} = [];
% Diams{end} = [];
%creating fake lengths and diams in the same topological order as in Adj
for i=1:numel(NSeg)
    for j = 1:NSeg(i)
        LengthArr{i}(j) = dX;
        Diams{i}(j) = 1e-4; 
    end
end
for j = 1:NSeg(end)
     LengthArr{end}(j) = dX;
        Diams{end}(j) = 1e-4; 
end

CN=cumsum(NSeg);
N=sum(NSeg);
SegStartI=[0 CN(1:end-1)]+1;
SegEndI=CN;
SegToComp=zeros(2,N);
for i=1:numel(NSeg)
   SegToComp(1,SegStartI(i):SegEndI(i))=i;
   SegToComp(2,SegStartI(i):SegEndI(i))=1:(SegEndI(i)-SegStartI(i)+1);
end
R2 = 0.3;
gL = 1/15;
Cm = 1;
A=ones(N)*3.5;
B=randi(100,N,1);
[X Y]=meshgrid(1:N,1:N);
A(abs(X-Y)>1)=0;
curri=1;
currj=0;
%connecting segments compartments together and leaving compartments
%unconnected to each other.
for i=1:length(SegToComp)
    matInds = SegToComp(:,i);
    dx = LengthArr{matInds(1)}(matInds(2));
    a = Diams{matInds(1)}(matInds(2));
    lambda2 = (a/(2*R2*gL))/dx^2;
    A(i,i) = 2*lambda2;
    if( i<length(SegToComp))
        A(i+1,i) = -lambda2;
        A(i,i+1) = -lambda2;
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
       if(parentInd ==75 && sonInd ==75)
           disp(A(parentInd,sonInd));
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
As = 4*pi*1e-6;
soma_dx = LengthArr{3}(end);
soma_a = Diams{3}(end);
Asoma = 2*pi*soma_a*soma_dx;
somaLambda = (soma_a/(2*R2*gL))/soma_dx^2;
ro = Asoma/As;
somaLoc = N;
 A(somaLoc,somaLoc) = ro*somaLambda;
 A(somaLoc,somaLoc-1) = -ro*somaLambda;
 A(somaLoc-1,somaLoc) = -somaLambda;

% figure(37434);clf;imagesc(abs(A)>0.001);
% A=A+randn(size(A)).*(A~=0);
RealX=A\B;

Aux = CreatAuxiliaryData2(A,N,NSeg,Parent);