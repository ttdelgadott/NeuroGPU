%QWERTY - change when adding a model to read from hoc
%should be written in pre-process
function hasModel = getHocFileData(nSegs, nModels)

global HH_INDEX;
global STIM_INDEX;
global MAINENNA_INDEX;
global MAINENKV_INDEX;

hasModel = zeros (nSegs, nModels);
for segInd=2:3
    hasModel(segInd, MAINENNA_INDEX) = 1;
    hasModel(segInd, MAINENKV_INDEX) = 1;
    hasModel(segInd, HH_INDEX) = 1;
end;

for segInd=5:33
    hasModel(segInd, MAINENNA_INDEX) = 1;
    hasModel(segInd, MAINENKV_INDEX) = 1;
    hasModel(segInd, HH_INDEX) = 1;
end;

for segInd=35:63
    hasModel(segInd, MAINENNA_INDEX) = 1;
    hasModel(segInd, MAINENKV_INDEX) = 1;
    hasModel(segInd, HH_INDEX) = 1;
end;

hasModel(2, STIM_INDEX) = 1;