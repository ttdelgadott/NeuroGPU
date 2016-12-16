function [allPPs availablePPs] = parsePPOutput(FN)
fid = fopen(FN);
availablePPs = {};
counter = 1
secname = fgetl(fid);
while ischar(secname)
    allParamsLine = fgetl(fid);
    if(~isempty(allParamsLine))
        [ppName rest] = strtok(allParamsLine,',');
        loc = strtok(rest,',');
        allPPs(counter).sec = secname;
        allPPs(counter).ppname = ppName;
        allPPs(counter).loc = loc;
        counter = counter+1;
        availablePPs{end+1} = ppName;
    end
    secname = fgetl(fid);
    
    
end
