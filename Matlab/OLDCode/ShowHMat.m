function I=ShowHMat(M,K)
% M=abs(Hs2{i})>0.000001;
% K=4;
A=ones(size(M));
[X Y]=meshgrid(1:size(M,1),1:size(M,2));
A(abs(X-Y)>1)=2;
if(K(1)>0)
    A(K(1),:)=3;
end;
if(K(2)>0)
    A(K(2),:)=5;
end;
A(M>0.000001)=4;
CCode=[0 0 0; 0 0 1; 0 1 0; 1 0 0; 1 1 0];
I=ind2rgb(A,CCode);
imshow(I);