function [Parent Type indToTypeInd] = buildMorphoAsNeuron(gereshes,breaks,dashes,oldType);
Level{1} = 1;
Parent(1) = 0;
Type(1) = oldType(1);
ind=2;
for currLevel=min(gereshes(2:end)):max(gereshes)
    Level{currLevel} = fliplr(find(gereshes==currLevel)); 
end
for currLevel=2:numel(Level)
    levelElms = Level{currLevel};
    potentialPs = find(breaks==currLevel-1);
    if(currLevel == breaks(1))
        potentialPs = find(breaks==currLevel);
    end
    for j=1:numel(levelElms)
        typeInd = levelElms(j);
        indToTypeInd(ind) = typeInd;
        currParentInd = find(potentialPs<typeInd,1,'last');
        currParent = potentialPs(currParentInd);
        Type(ind)=oldType(typeInd);
        newInd = getcompIndex(Type,oldType{currParent}(1:end-5));
        Parent(ind) = newInd;
        ind = ind+1;
    end
    
    
end