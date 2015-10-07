function [nodeb Ind]= getNODEB(Mat,seg)
Ind=seg-1;
nodeb = Mat(seg,Ind);
if (nodeb ==0)
    Ind = find(Mat(seg,1:seg-1));
end
nodeb = Mat(seg,Ind);