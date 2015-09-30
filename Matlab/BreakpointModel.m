function [sumCurrents sumConductivity]=BreakpointModel(v, m, h, n, gnabar, gkbar, gl, ena,ek,el)
gna=gnabar*m*m*m*h;
ina=gna*(v-ena);
gk=gkbar*n*n*n*n;
ik=gk*(v-ek);
il=gl*(v-el);
sumCurrents= ina+ik+il;
sumConductivity= gk+gna+gl;