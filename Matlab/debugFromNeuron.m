function [t v m h n] = debugFromNeuron()
%outFile.printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,",v,m_hh,h_hh, n_hh, minf_hh, hinf_hh ,ninf_hh, ntau_hh, mtau_hh, htau_hh, gna_hh, gk_hh, ena, ek, gl_hh, el_hh)
mat = importdata('../Neuron/SimpleHH/neuronModel.csv');
t=mat(:,1);
v=mat(:,2);
m=mat(:,3);
h=mat(:,4);
n=mat(:,5);
