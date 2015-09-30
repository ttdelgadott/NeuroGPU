function [sumCurrents, sumConducts, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = NrnCurrent_stim (t, v, varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_stim;
Def_ConstsPerModelAllSegs_stim;
Def_VarsPerModelPerSeg_stim;
Def_VarsPerModelAllSegs_stim;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
sumCurrents = 0.;
if ( t < constsPerModelPerSeg(:, del_index) + constsPerModelPerSeg(:, dur_index)  && t >= constsPerModelPerSeg(:, del_index) )
varsPerModelPerSeg(i_index) = constsPerModelPerSeg(:, amp_index) ;
else
varsPerModelPerSeg(i_index) = 0.0 ;
end
sumCurrents = sumCurrents - varsPerModelPerSeg(i_index);
sumConducts = 0.;
sumConducts = sumConducts - varsPerModelPerSeg(i_index);
sumCurrents = sumCurrents*100/constsPerModelPerSeg(:, area_index);

