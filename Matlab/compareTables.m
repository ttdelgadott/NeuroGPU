function []= compareTables(ind,Table,diags,parents,childs,rhs)
NeuronTable = Table;
NeuronTable(:,1) = parents(:,ind);
NeuronTable(:,2) = childs(:,ind);
NeuronTable(:,3) = diags(:,ind);
%NeuronTable(:,4) = rhs(:,ind);
isError = find(NeuronTable == Table);
if(isError)
    isError
end
