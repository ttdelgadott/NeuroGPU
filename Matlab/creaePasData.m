folder='../Neuron/Passive/Output/';



for i=40:50

const=[folder 'const' num2str(32*i) '.csv'];
    topo=[folder 'topo' num2str(32*i) '.csv'];
    fmat=[folder 'FMats' num2str(32*i) '_'];
    MainPassive(topo,const,fmat);
end
