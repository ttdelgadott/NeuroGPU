function [ind] = getCompIndex(types,comptName)
ind = [];
counter=0;
for i = 1:numel(types)
    if(~isempty(strfind(types{i},comptName)) && (types{i}( numel(comptName)+1) == '('))
        counter = counter+1;
        ind(counter)=i;
    end
end