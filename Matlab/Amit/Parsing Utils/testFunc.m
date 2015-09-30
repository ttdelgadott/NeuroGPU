clc;
%cd('C:\Users\Roy\Documents\NeuroGPU2_2\Neuron\printCell\Amit\');

% AddTopoToHoc ('printCellBinaryK64 - 6.hoc');
%cd('C:\Users\AmitM\Documents\neurogpu\Matlab\Amit\Parsing Utils\Parsed Funcs');
%parseHocFile ('printCellBinaryK64 - 6.hoc');
%parseHocFile ('printCellBinaryK64 - 3.hoc'); 
%filesep = '\\';
%parseHocFile ('hhcatrials.hoc');
NeuroGPUInit;
parseHocFile (fullfile(BaseP,'Neuron','printCell','Amit','runModel.hoc'));
%parseHocFile ('cc_run.hoc');
%parseHocFile ('topTest.hoc');
%parseHocFile ('caonly.hoc');
%%parseHocFile ([BaseP './Neuron/printCell/ForC/k/ktrials.hoc']);