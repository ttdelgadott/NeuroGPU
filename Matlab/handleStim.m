function current = handleStim(stim,seg,t)
current=0;
    if(t>=stim.del && t<stim.del+stim.dur && stim.loc == seg)
        current = 100*stim.amp/stim.area;
    end