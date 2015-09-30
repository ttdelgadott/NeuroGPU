function [m h n]=InitModel(v)
[minf hinf ninf mtau htau ntau]=rates( v);
m=minf;
h=hinf;
n=ninf;