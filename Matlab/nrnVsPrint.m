NeuroGPUInitGitHub;
FN=['../UrapNeuron\HodgkinHuxley\Volts\orig_step_soma.dat'];
ntimestep=3168;
stimSize =2;
[NV,err] =nrn_mread(FN,6352);
figure (234)
plot(NV);
