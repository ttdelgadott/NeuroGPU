function [hasThisModel vars_Stim varsForModelAllSegs consts_Stim isElectrodeCurrent] = AmitInitModel_Stim(hasThisModel,...
    vars_Stim, varsForModelAllSegs, consts_Stim, constsAllModelsAllSegs, Vs, isElectrodeCurrent, nSegs)
global STIM_INDEX;
Def_VarsPerModelPerSeg_stim;
Def_ConstsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
%initModel of HH
for segInd=1:nSegs
    vars_Stim(segInd, i_index)= 0;
    vars_Stim(segInd, g_index)= 0;
end;


%QWERTY - originally was in Neuron in hh.c in nrn_alloc - to check if it's
%best to unify it with InitModel (since no real allocation is done here)
isElectrodeCurrent=1;
hasThisModel(2) = 1;
consts_Stim(del_index) = 0.5;
consts_Stim(dur_index) = 1;

consts_Stim(amp_index) = 120;

%taken from the .csv file
consts_Stim(area_index) = pi * 500 * 100 / 2;
% 
% hasModel(19, STIM_INDEX) = 1;
% consts_Stim(19, del_index) = 0.5;
% consts_Stim(19, dur_index) = 1;
% consts_Stim(19, amp_index) = 120;
% consts_Stim(19, area_index) = pi * 500 * 100 / 29;
% 
% hasModel(49, STIM_INDEX) = 1;
% consts_Stim(49, del_index) = 0.5;
% consts_Stim(49, dur_index) = 1;
% consts_Stim(49, amp_index) = 120;
% consts_Stim(49, area_index) = pi * 500 * 100 / 29;