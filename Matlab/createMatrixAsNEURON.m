function [A Table]= createMatrixAsNEURON(LengthArr,Diams,NSegs,Ras,Adj)
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
Root=sum(Lasts); % This is wrong - according to topology!

for i=1:nComps % e f d
    CurPartUpper=[-Mids(i) -Lasts(i) Heads(i)];
    CurPartLower=[-Mids(i)/2 -Mids(i)/2 Heads(i)];
    CurPartOuter=[-Lasts(i) -Mids(i) Lasts(i)];
    CurPartMids=[-Mids(i)/2 -Mids(i)/2 Mids(i)];
    CurPart{i}=[CurPartUpper; repmat(CurPartMids,[NSegs(i)-2 1]); CurPartLower; CurPartOuter];
end
Table=[[0 0 Root]; cat(1,CurPart{:})];
%% From table to matrix
A=TableToMatrix(Table);% Use Topology!