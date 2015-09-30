FN='../Neuron\Mainen\FullTest\orig_step.dat';
npoints = 6150;
[NV,err] =nrn_mread(FN,npoints);
plot(NV);
