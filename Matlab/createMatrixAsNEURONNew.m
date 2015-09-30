function [A Table]= createMatrixAsNEURONNew(Neuron)
LengthArr = Neuron.Ls;
% LengthArr(1)=100;
% LengthArr(2)=1;
Diams = Neuron.Diams;
NSegs = Neuron.NSegs;
Ras = Neuron.Ras;
Parent = Neuron.Parent;
% LengthArr=[10 100 10];
% Diams=[10 100 10];
% NSegs=[10 10 10];
% Ras=[10 10 10];
%%
HinesC=10000/2;
nComps=numel(LengthArr);
dXs=LengthArr./NSegs;
%% As fmatrix()
Mids=Diams./((dXs.^2).*Ras).*HinesC;
Heads=Mids*3/2;
Lasts=pi*HinesC.*(Diams.^2)./(dXs.*Ras*100);
Root=Lasts(1); % This is wrong - according to topology!

for i=1:nComps % e f d
    CurPartUpper=[-Mids(i) -Lasts(i) Heads(i)];
    childs = find(Parent==i);
    CurPartLower=[-Mids(i)/2 -Mids(i)/2 Heads(i)];
    if(isempty(childs))%Leaf
        CurPartOuter=[-Lasts(i) -Mids(i) Lasts(i)];
    else%Not Leaf
        sumChilds=sum([Lasts(childs); Lasts(i)]);
        CurPartOuter=[-Lasts(i) -Mids(i) sumChilds];
    end
    %CurPartLower=[-Mids(i)/2 -Mids(i)/2 Heads(i)];
    
    CurPartMids=[-Mids(i)/2 -Mids(i)/2 Mids(i)];
    CurPart{i}=[CurPartUpper; repmat(CurPartMids,[NSegs(i)-2 1]); CurPartLower; CurPartOuter];
end
Table=[[0 0 Root]; cat(1,CurPart{:})];

%% From table to matrix
A=TableToMatrix(Table,Neuron);% Use Topology!