%constsPerSegDefine
%definition of the constants that are common for all models - this file is
%written in pre process (depending on all the models)
function commonConstsPerSeg = AmitDefineCommonConstsPerSeg(commonConstsPerSeg)
AmitCommonConstsIndicesDef;
commonConstsPerSeg(:, ena_index) = 50;
commonConstsPerSeg(:, ek_index) = -77;

