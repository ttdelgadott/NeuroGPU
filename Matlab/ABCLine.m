function [Aline Bline Cline] = ABCLine(firstPoint,lastPoint)
slope = (lastPoint(2)-firstPoint(2))/(lastPoint(1)-firstPoint(1));
Aline=slope;
Bline=-1;
Cline = (-slope*firstPoint(1) + firstPoint(2));
% blabla