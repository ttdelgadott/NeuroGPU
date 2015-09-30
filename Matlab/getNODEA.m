function [nodea Ind] = getNODEA(Mat,seg)
Ind=seg-1;
nodea = Mat(Ind,seg);
if (nodea == 0)
    Ind = find(Mat(1:seg-1,seg));
end
nodea = Mat(Ind,seg);