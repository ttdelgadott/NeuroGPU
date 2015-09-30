function [x] = getxbetweenpoints(p1,p2,y)
[a b c] = ABCLine(p1,p2);
x= (-b*y-c)/a;