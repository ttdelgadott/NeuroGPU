function [ constsAndVars ] = nernstCa( constsAndVars )
%supposed to calculate the nernst potential for all ions, but right now
%does so only for ca.
Def_ConstsAllModelsAllSegs;
Def_VarsAllModelsPerSeg;

ktf = (1000.*8.3134*(constsAndVars.constsAllModelAllSeg(celsius_index) +...
    273.15)/constsAndVars.constsAllModelAllSeg(FARADAY_index));

%na
%right now cai/cao is defined as a variable per segment but eca a variable for all
%segments. this creates a bit redundancy - since only one eca should be
%calculated. we need to pick one cai/cao of a certain segment (that is a valid
%segment) and use it to calculate eca. the second segment should always be
%a valid segment (the first is always an invalid segment).

eca = nernst(ktf, constsAndVars.varsAllModelPerSeg(2, cai_index), constsAndVars.varsAllModelPerSeg(2, cao_index), 2);
constsAndVars.constsAllModelAllSeg(eca_index) = eca;
end

function reversalPotential = nernst (ktf, ci, co, z)
    if (z == 0)
        reversalPotential = 0;
        return;
    end
    if (ci <= 0) 
         reversalPotential = 1e6;
         return;
    end
    if (co <= 0)
        reversalPotential = -1e6;
        return;
    end
    reversalPotential = ktf/z*log(co/ci);
end

