function [lengths,diams] = getCompLengthDiam(compt,prev)
curr = compt{1};
diams(1) = curr(4);
lengths(1) = sqrt(sum((prev(1:3)-curr(1:3)).^2));
i=1;
if(lengths(i)>10)
    disp(['Length of ' num2str(i) ' is ' num2str(lengths(i))]);
end
for i = 2:numel(compt)
    prev=curr;
    curr = compt{i};
    diams(i) = curr(4);
    lengths(i) = sqrt(sum((prev(1:3)-curr(1:3)).*(prev(1:3)-curr(1:3))));
    if(lengths(i)>10)
        disp(['Length of ' num2str(i) ' is ' num2str(lengths(i))]);
    end
end