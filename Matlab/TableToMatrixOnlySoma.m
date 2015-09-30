function Matrix = TableToMatrixOnlySoma(Table)
%segStart = [1 cumsum(NSegs)];
Nx = length(Table);
Matrix = zeros(Nx);
for i=2:Nx
    Matrix(i-1,i-1)= Table(i-1,3);%diagonal element (NODED)
    Matrix(i,i-1)=Table(i,1);%jacobian element for parent in node equation (ClassicalNODEB)
    Matrix(i-1,i)=Table(i,2);%jacobian element for node in parent equation (ClassicalNODEA)
end
Matrix(end,end) = Table(end,3);