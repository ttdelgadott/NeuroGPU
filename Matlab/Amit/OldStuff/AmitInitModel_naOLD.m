function [hasThisModel vars_MainenNa varsForModelAllSegs consts_MainenNa isElectrodeCurrent] = ...
    AmitInitModel_na(hasThisModel, vars_MainenNa, varsForModelAllSegs,...
    consts_MainenNa, constsAllModelsAllSegs, Vs, isElectrodeCurrent, nSegs)

Def_ConstsAllModelsAllSegs;
Def_VarsPerModelPerSeg_na;
Def_ConstsPerModelPerSeg_na;
Def_VarsPerModelAllSegs_na;


%consts_MainenNa(gbar_index) = 0; %cancels out the model practically - QWERTY
consts_MainenNa(gbar_index) = 35000; 
consts_MainenNa(vshift_index) = -10;
consts_MainenNa(tha_index) = -35;
consts_MainenNa(qa_index) = 9;
consts_MainenNa(Ra_index) = 0.182;
consts_MainenNa(Rb_index) = 0.124;
consts_MainenNa(thi1_index) = -50;
consts_MainenNa(thi2_index) = -75;
consts_MainenNa(qi_index) = 5;
consts_MainenNa(thinf_index) = -65;
consts_MainenNa(qinf_index) = 6.2;
consts_MainenNa(Rg_index) = 0.0091;
consts_MainenNa(Rd_index) = 0.024;
consts_MainenNa(temp_index) = 23;
consts_MainenNa(q10_index) = 2.3;

q10 = consts_MainenNa(q10_index);
celsius = constsAllModelsAllSegs(celsius_index);
temp = consts_MainenNa(temp_index);
varsForModelAllSegs(tadj_index) = q10^((celsius - temp)/10);

%initModel of MainenNa
for segInd=2:3
    vars_MainenNa(segInd, m_index) = 0;
    vars_MainenNa(segInd, h_index) = 0;
     [vars_MainenNa(segInd,:), varsForModelAllSegs] = na_trates (vars_MainenNa(segInd,:), ...
         varsForModelAllSegs, consts_MainenNa, constsAllModelsAllSegs, (Vs(segInd)+consts_MainenNa(vshift_index)) );
%     [vars_MainenNa(segInd,:), varsForModelAllSegs] = na_trates (vars_MainenNa(segInd,:), ...
%         varsForModelAllSegs, consts_MainenNa, constsAllModelsAllSegs, Vs(segInd)+consts_MainenNa(vshift_index) );
%     vars_MainenNa(segInd,:) = Amit_trates_MainenNa (vars_MainenNa(segInd,:), consts_MainenNa,...
%         (Vs(segInd)+consts_MainenNa(vshift_index)));      %QWERTY - to be
%         deleted
    vars_MainenNa(segInd, m_index) = vars_MainenNa(segInd, minf_index);
    vars_MainenNa(segInd, h_index) = vars_MainenNa(segInd, hinf_index);
end;

for segInd=5:33
    vars_MainenNa(segInd, m_index) = 0; 
    vars_MainenNa(segInd, h_index) = 0; 
    [vars_MainenNa(segInd,:), varsForModelAllSegs] = na_trates (vars_MainenNa(segInd,:), ...
        varsForModelAllSegs, consts_MainenNa, constsAllModelsAllSegs, (Vs(segInd)+consts_MainenNa(vshift_index)) );
%     vars_MainenNa(segInd,:) = Amit_trates_MainenNa (vars_MainenNa(segInd,:), consts_MainenNa,...
%         (Vs(segInd)+consts_MainenNa(vshift_index)));      %QWERTY - to be
    vars_MainenNa(segInd, m_index) = vars_MainenNa(segInd, minf_index);
    vars_MainenNa(segInd, h_index) = vars_MainenNa(segInd, hinf_index);
end;

for segInd=35:63
    vars_MainenNa(segInd, m_index) = 0;
    vars_MainenNa(segInd, h_index) = 0;
    [vars_MainenNa(segInd,:), varsForModelAllSegs] = na_trates (vars_MainenNa(segInd,:), ...
        varsForModelAllSegs, consts_MainenNa, constsAllModelsAllSegs, (Vs(segInd)+consts_MainenNa(vshift_index)) );
%     vars_MainenNa(segInd,:) = Amit_trates_MainenNa (vars_MainenNa(segInd,:), consts_MainenNa,...
%         (Vs(segInd)+consts_MainenNa(vshift_index)));      %QWERTY - to be
    vars_MainenNa(segInd, m_index) = vars_MainenNa(segInd, minf_index);
    vars_MainenNa(segInd, h_index) = vars_MainenNa(segInd, hinf_index);
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
