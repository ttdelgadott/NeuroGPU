function valueStr = getValueOfVarIfChangedInHocFile(fullVarName, globalCellArr, mdlCellArr)
    valueStr = '';
    valueStr = getValueOfVarIfChangedInHocFileForFid(fullVarName, valueStr, globalCellArr);
    valueStr = getValueOfVarIfChangedInHocFileForFid(fullVarName, valueStr, mdlCellArr);
end

function valueStr = getValueOfVarIfChangedInHocFileForFid(fullVarName,...
    oldValueStr, fileCellArr)
    valueStr = oldValueStr;
    numOfLines = numel(fileCellArr{1});
    firstIndex = 1;
    %find the first line index of variables values in the first section.
    while (firstIndex<=numOfLines)
        
        if (~isnan(fileCellArr{2}(firstIndex)))
            break;
        end
        firstIndex = firstIndex+1;
    end
    for i=firstIndex:numOfLines
        %this conditional makes sure that we only check the first section for
        %values. this part of code will make this function run much faster.
        %but it will need modification when we want to read updates to some
        %variables per section from the hoc file.
        if (isnan(fileCellArr{2}(i)))
           break; 
        end
        %if this is the line of the wanted variable.
        if (strcmp(fullVarName, fileCellArr{1}(i)))
            valueStr = num2str(fileCellArr{2}(i));
            break
        end;
    end
end