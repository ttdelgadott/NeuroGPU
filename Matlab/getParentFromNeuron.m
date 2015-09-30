function parent = getParentFromNeuron(FN)
parent = dlmread(FN,' ');
parent = parent(2:end-1,:)+1;
parent = parent(:,2)';
parent(1)=0;