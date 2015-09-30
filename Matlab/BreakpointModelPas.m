function [sumCurrents sumConductivity]=BreakpointModelPas(v,g,e)
sumCurrents=g*(v-e);
sumConductivity =g;
