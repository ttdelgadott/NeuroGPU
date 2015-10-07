folder='../Neuron/Figure1/Output/';



for i=2:2
%depth = 2^i;
depth =32*3;
const=[folder num2str(depth) 'RCC'  '.csv'];
    topo=[folder num2str(depth) 'RCT'  '.csv'];
    fmat=[folder num2str(depth) 'RCF'];
    MainFigure2(topo,const,fmat);
%     NeuroGPU2(topo,const,fmat);
end
