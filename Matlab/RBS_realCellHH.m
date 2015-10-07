folder='../Neuron/printCell/Output/';



for i=3:3
%depth = 2^i;
depth =32*i;
const=[folder  num2str(depth) 'RCC' '.csv'];
    topo=[folder  num2str(depth) 'RCT' '.csv'];
    fmat=[folder  num2str(depth) 'RCF_'];
     MainFigure2(topo,const,fmat);
   %NeuroGPU2(topo,const,fmat);
end
