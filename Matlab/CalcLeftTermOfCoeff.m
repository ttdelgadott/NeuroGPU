function Out=CalcLeftTermOfCoeff(gVec,Inda,Indb,LengthVec,DiamVec,Rtag)

Out=DiamVec(Inda)/(LengthVec(Inda)*LengthVec(Indb)*2*DiamVec(Indb)*gVec(Indb)*Rtag);