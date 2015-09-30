%function returns a map of the vars & consts values per compartment based
%on the global/mdl arrays.
function varValueMap = getVarValueMap (globalCellArr, mdlCellArr)
    varValueMap=struct();
    cellArr{1} = globalCellArr;
    cellArr{2} = mdlCellArr;
    
    for cellArrType=1:2
        numOfLines = numel(cellArr{cellArrType}{1});
        compNames = cellArr{cellArrType}{1}(isnan(cellArr{cellArrType}{2}(:)));
        varNamesWithDuplicates = cellArr{cellArrType}{1}(~isnan(cellArr{cellArrType}{2}(:)));
        numOfComps = numel(compNames);
        varNames = unique(varNamesWithDuplicates);
        numOfVars = numel(varNames);
        
        for varNameInd = 1:numOfVars
            varValueMap.(varNames{varNameInd}) = NaN(1, numOfComps);
        end
        
        compartmentIndex = 0;
        for lineInd=1:numOfLines
            if (isnan(cellArr{cellArrType}{2}(lineInd)))
                compartmentIndex = compartmentIndex + 1;
                continue;
            end
            varName = cellArr{cellArrType}{1}(lineInd);
            varValue = cellArr{cellArrType}{2}(lineInd);
            varValueMap.(varName{1})(compartmentIndex) = varValue;
        end    
    end
    

    
end