function [sumCurrents sumConducts] = NrnCurrent_Stim (t, v, varsForThisModel, varsForAllModels, constsForThisModel, constsForAllModels)
AmitModelConstsIndicesDef_Stim;
AmitModelVarsIndicesDef_Stim;
AmitCommonConstsIndicesDef;
sumCurrents = 0.;
if ( t < constsForThisModel(del_index) + constsForThisModel(dur_index)  && t >= constsForThisModel(del_index) )
varsForThisModel(i_index) = 100* constsForThisModel(amp_index)/ constsForThisModel(area_index);
else
varsForThisModel(i_index) = 0.0 ;
end
sumCurrents = sumCurrents - varsForThisModel(i_index);
sumConducts = 0.;
sumConducts = sumConducts - varsForThisModel(g_index);

