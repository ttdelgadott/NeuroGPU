%parseVariablesForInitmodelNewWithCellArrs

%I think this scrip just turned completely redundant since we can use the regular parseAllTypesVariables
% even for initModel since the special consts/vars parsing is done from
% files in parseNrnInitModel
indexlines = getLines(fileName);
modFilePrefix = regexp(fileName, '.*_([^_]*)\..*','tokens');
modFilePrefix = modFilePrefix{1};
% globalFileName = ['..' filesep '..' filesep '..' filesep '..' filesep 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64GLOBAL.csv'];
% globalLines = getLines(globalFileName);
% mdlFileName = ['..' filesep '..' filesep '..' filesep '..' filesep 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64MDL.csv'];
% mdlLines = getLines(mdlFileName);

for i=1:numel(indexlines)
    if (~isempty(strfind(indexlines{i}, '_index')))
        [mat tok ext] = regexp(indexlines{i}, '(\w*) *_index *=', 'match', ...
        'tokens', 'tokenExtents');
        varName = tok{1};
        %fullVarName = [varName '_' modFilePrefix];
%        fullVarName = strcat(varName, '_', modFilePrefix);
        %['\<' char(variableName) '\>'] - exactly the variableName -
        %meaning that if variableName = 'el' than words like 'model' won't
        %count
%        valueStr = getValueOfVarIfChangedInHocFile(fullVarName, globalCellArr, mdlCellArr);
        %$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$QWERTY$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$delete_useless_assignment_since_all_is_Assigned_through_the_global/mdlFile
        %if there is a value in one of the csv file update it in the
        %assignment lines
% % %         if (~isempty(valueStr))
% % %             if strcmp(variableType,CONSTS_PER_MODEL_PER_SEG_STR)
% % %                 %expression is 'variable = ...'
% % %                 expression = ['\<' char(varName) '\> *=.*'];
% % %                 replacment = [variableType '(:, ' char(varName) '_index) = ' char(valueStr) ';'];
% % %                 lines=regexprep(lines, ['\<' char(varName) '\> *=.*'],...
% % %                 [variableType '(:, ' char(varName) '_index) = ' char(valueStr) ';'])';
% % %             else
% % %                 lines=regexprep(lines, ['\<' char(varName) '\> *=.*'],...
% % %                 [variableType '(' char(varName) '_index) = ' char(valueStr) ';'])';
% % %             end
% % %         end
        
        %replace any variable references left untouch.
        if strcmp(variableType,CONSTS_PER_MODEL_PER_SEG_STR)
            lines=regexprep(lines, ['\<' char(varName) '\>'],...
            [variableType '(:, ' char(varName) '_index)'])';
        else
            lines=regexprep(lines, ['\<' char(varName) '\>'],...
            [variableType '(' char(varName) '_index)'])';
        end
        
        
    end;
end;

