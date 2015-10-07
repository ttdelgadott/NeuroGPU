function Out=AddParamsToFuncCall(In,FuncNames,InputVarsC,AllParamLineCall)
Out=In;
for i=1:numel(Out)
    CurLine=Out{i};
    for j=1:numel(FuncNames)
        FuncCallI=regexp(CurLine,FuncNames{j});
        if(isempty(FuncCallI))
            continue;
        end
        CurEndIs=find(CurLine==')');
        EndI=min(CurEndIs(CurEndIs>FuncCallI));
        Separator=',';
        if(isempty(InputVarsC{j}))
            Separator='';
        end
        Out{i}=[CurLine(1:EndI-1) Separator AllParamLineCall CurLine(EndI:end)];
    end
end
