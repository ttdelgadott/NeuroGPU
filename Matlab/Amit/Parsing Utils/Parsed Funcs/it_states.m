function [varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = it_states(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg)
Def_ConstsPerModelPerSeg_it;
Def_ConstsPerModelAllSegs_it;
Def_VarsPerModelPerSeg_it;
Def_VarsPerModelAllSegs_it;
Def_VarsAllModelsPerSeg;
Def_ConstsAllModelsAllSegs;
[varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg] = it_trates(varsPerModelPerSeg, varsPerModelAllSeg,varsAllModelPerSeg, constsPerModelPerSeg, constsPerModelAllSeg, constsAllModelAllSeg,v+constsPerModelAllSeg(vshift_index));
varsPerModelPerSeg(m_index) = varsPerModelPerSeg(m_index) + mexp*(varsPerModelPerSeg(minf_index)-varsPerModelPerSeg(m_index));
varsPerModelPerSeg(h_index) = varsPerModelPerSeg(h_index) + hexp*(varsPerModelPerSeg(hinf_index)-varsPerModelPerSeg(h_index));
VERBATIM
return 0;
ENDVERBATIM

