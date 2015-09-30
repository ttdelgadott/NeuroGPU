folder='../Neuron/Trees/Output/';



for i=2:2
%depth = 2^i;
depth =32*i;
const=[folder 'const' num2str(depth) '.csv'];
    topo=[folder 'topo' num2str(depth) '.csv'];
    fmat=[folder 'FMats' num2str(depth) '_'];
         MainFigure2(topo,const,fmat);
  %  NeuroGPU2(topo,const,fmat);
end
