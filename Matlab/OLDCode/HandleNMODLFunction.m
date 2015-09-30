clear TmpLines
FuncName=strtok( Lines{StartL}(9:(find( Lines{StartL}=='(')-1)));
TmpLines{1}=[FTYPESTR ' ' Lines{StartL}(9:end)];
for j=(StartL+1):EndL
    TmpLines{end+1} = [regexprep( Lines{j},[FuncName '='], 'return ') ';'];
end
CFuncLines{i}=TmpLines';