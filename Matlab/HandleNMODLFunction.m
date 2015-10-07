clear TmpLines
FuncName=strtok( Lines{StartL}(9:(find( Lines{StartL}=='(')-1)));
FFuncNames{i}=FuncName;
FFuncNamesCu{i}=['Cu' FuncName];
FInputVars=regexp(Lines{StartL}(find(Lines{StartL}=='(',1)+1:find(Lines{StartL}==')',1,'last')-1),',','split');
Tmp=strcat('floatx',FInputVars);
Tmp(1:end-1)=strcat(Tmp(1:end-1),',');
TmpLines{1}=[FTYPESTR ' ' FuncName '(' strrep( [Tmp{:}],'floatx','float ') ') {'];
for j=(StartL+1):EndL
    TmpLines{end+1} = [regexprep( Lines{j},[FuncName '\W*='], 'return ') ';'];
end
CFuncLines{i}=TmpLines';
CFuncLinesCu{i}=CFuncLines{i};
CFuncLinesCu{i}{1}=['__device__ ' regexprep(CFuncLinesCu{i}{1},FFuncNames{i},FFuncNamesCu{i})];