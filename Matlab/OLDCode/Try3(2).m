RandStream.setDefaultStream(RandStream('mt19937ar','seed',209416));
% rand(1,5)

ReadASCFile;
CreateBookMat6;
CreatAuxiliaryData;
% Solve serial
HinesTriang2;
HinesBkSub2;

% Solve parallel
HinesTriangP2;
HinesBkSubP2;