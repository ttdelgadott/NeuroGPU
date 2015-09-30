function [dist] = calcDistFromTarget(cords, target)
for i=1:length(cords)
    curr = cords{i};
    dist(i) = sqrt(sum((curr(1:3)-target(1:3)).*(curr(1:3)-target(1:3))));
end