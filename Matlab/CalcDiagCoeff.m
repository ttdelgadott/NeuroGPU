function Sum=CalcDiagCoeff(gVec,IndsOfSons,IndofMe,LengthVec,DiamVec,Rtag)
% We're in row a, clmn b

Sum=0;
for i=1:numel(IndsOfSons)
    Sum=Sum-CalcLeftTermOfCoeff(gVec,IndsOfSons(i),IndofMe,LengthVec,DiamVec,Rtag);
end
Sum=Sum-CalcRightTermOfCoeff(gVec,IndofMe,LengthVec,Rtag);
