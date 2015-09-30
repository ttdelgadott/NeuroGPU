function Matrix = TableToMatrix(Table,Neuron)
%code from section.h
% double	_a;			/* effect of node in parent equation */
% double	_b;			/* effect of parent in node equation */
%segStart = [1 cumsum(NSegs)];
Nx = length(Table);
Matrix = zeros(Nx);
Matrix(1,1)=Table(1,3);
for i=2:Nx
    Matrix(i,i)= Table(i,3);%diagonal element (NODED)
    Matrix(i,i-1)=Table(i,1);%jacobian element for parent in node equation (ClassicalNODEB)
    Matrix(i-1,i)=Table(i,2);%jacobian element for node in parent equation (ClassicalNODEA)
end
Matrix(end,end) = Table(end,3);

%OffDiagonal
CN = cumsum( Neuron.NSegsMat);
SegStart = [1 CN(1:end-1)']+1;
LastSeg = CN;
for currComp = 1:numel(Neuron.Parent)
    if ~(Neuron.Parent(currComp) == currComp-1)%means that the previous compartment is not the parent so we need to update offdiagonal elements!
        matInd = SegStart(currComp);
        parentInd = LastSeg(Neuron.Parent(currComp));
        Matrix(matInd,matInd-1)=0;%jacobian element for parent in node equation (ClassicalNODEB)
        Matrix(matInd-1,matInd)=0;%jacobian element for node in parent equation (ClassicalNODEA)
        Matrix(matInd,parentInd) = Table(matInd,1);
        Matrix(parentInd,matInd) =  Table(matInd,2);
    end
end


