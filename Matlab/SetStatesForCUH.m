
StateSetStr = '';
for currState = 1:(nBasicStates+nExtraStates)
    currStateStr = sprintf('ModelStates_ ## VARILP [%d]=0; ',currState-1);
    StateSetStr = strcat(StateSetStr,currStateStr);
end