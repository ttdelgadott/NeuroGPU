function [current conductance] = BreakPointPass(v,e,g)
conductance =g;
current = g*(v-e);
