function [hasThisModel vars_MainenKv varsForModelAllSegs consts_MainenKv isElectrodeCurrent] = ...
    AmitInitModel_MainenKv(hasThisModel, vars_MainenKv, varsForModelAllSegs, consts_MainenKv, constsAllModelsAllSegs, Vs,...
    isElectrodeCurrent, nSegs)

Def_VarsPerModelPerSeg_kv;
Def_ConstsPerModelPerSeg_kv;
Def_VarsPerModelAllSegs_kv;
consts_MainenKv(gbar_index) = 0; %cancels out the model practically - QWERTY
%consts_MainenKv(gbar_index) = 175; %5*35
consts_MainenKv(tha_index) = 25;
consts_MainenKv(qa_index) = 9;
consts_MainenKv(Ra_index) = 0.02;
consts_MainenKv(Rb_index) = 0.002;
consts_MainenKv(temp_index) = 23;
consts_MainenKv(q10_index) = 2.3;
consts_MainenKv(celsius_index) = 25; %QWERTY

q10 = consts_MainenKv(q10_index);
celsius = consts_MainenKv(celsius_index);
temp = consts_MainenKv(temp_index);
varsForModelAllSegs(tadj_index) = q10^((celsius - temp)/10);

%initModel of MainenKv
for segInd=2:3
    vars_MainenKv(segInd, n_index) = 0;
    vars_MainenKv(segInd,:) = Amit_trates_MainenKv (vars_MainenKv(segInd,:), consts_MainenKv,...
        Vs(segInd));
    vars_MainenKv(segInd, n_index) = vars_MainenKv(segInd, ninf_index);
end;

for segInd=5:33
    vars_MainenKv(segInd, n_index) = 0;
    vars_MainenKv(segInd,:) = Amit_trates_MainenKv (vars_MainenKv(segInd,:), consts_MainenKv,...
        Vs(segInd));
    vars_MainenKv(segInd, n_index) = vars_MainenKv(segInd, ninf_index);
end;

for segInd=35:63
    vars_MainenKv(segInd, n_index) = 0;
    vars_MainenKv(segInd,:) = Amit_trates_MainenKv (vars_MainenKv(segInd,:), consts_MainenKv,...
        Vs(segInd));
    vars_MainenKv(segInd, n_index) = vars_MainenKv(segInd, ninf_index);
end;


for segInd=2:3
    hasThisModel(segInd) = 1;
end;

for segInd=5:33
    hasThisModel(segInd) = 1;
end;

for segInd=35:63
    hasThisModel(segInd) = 1;
end;