% Ns=[5 5];
% T=cell(0);

% Ns=[4 4 4];
% T{1}=[3 2 1];

% Ns=[3 3 3 3 3 3 3 3];
% T{1}=[6 5 4 3];
% T{2}=[3 2 1];

NComp = numel(Ns);

CN=cumsum(Ns);
N=sum(Ns);
A=randi(100,N);
B=randi(100,N,1);
[X Y]=meshgrid(1:N,1:N);
A(abs(X-Y)>1)=0;
for i=1:numel(Ns)-1
    A(CN(i),CN(i)+1)=0;
    A(CN(i)+1,CN(i))=0;
end
for i=1:numel(T)
    for j=1:numel(T{i})-1
        A(CN(T{i}(1)-1)+1,CN(T{i}(j+1)))=randi(10);
        A(CN(T{i}(j+1)),CN(T{i}(1)-1)+1)=randi(10);
    end
end
% figure(37434);clf;imagesc(abs(A)>0.001);
RealX=A\B;