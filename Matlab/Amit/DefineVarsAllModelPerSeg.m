
%definition of the vars that are common for all models - this file is
%written in pre process (depending on all the models and hoc file)
function vars = DefineVarsAllModelPerSeg(numOfSegs)
Def_VarsAllModelsPerSeg;
vars = zeros(numOfSegs, 9);
vars(:, nai_index) = 10;
vars(:, nao_index) = 140;
vars(:, ki_index) = 54.4;
vars(:, ko_index) = 2.5;
vars(:, cai_index) = 0.000050;
vars(:, cao_index) = 2;
vars(:, ina_index) = 0;
vars(:, ik_index) = 0;
vars(:, ica_index) = 0;


end

