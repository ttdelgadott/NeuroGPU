% INITIAL {
% 	rates(v)
% 	m = minf
% 	h = hinf
% 	n = ninf
% }
 Straighten=@(x) reshape(x,[1 numel(x)]);
InitialLineI=find(strhas(Lines,'INITIAL'));
if ~isempty(InitialLineI)
    StartL=InitialLineI;
    EndL=StartL;
    SumP=0;
    while(1)
        SumP=SumP+sum(Lines{EndL}=='{')-sum(Lines{EndL}=='}');
        if(SumP==0)
            break;
        end
        EndL=EndL+1;
    end
end
if(~exist('StatesAndParamsStr'))
    StatesAndParamsStr='';
end
if strhas(Lines(StartL),'}') 
    CurLines = Lines(StartL);
    CurLines =regexp(CurLines,'INITIAL\s*{','split');
    CurLines = CurLines{1};
else
    CurLines=Lines((StartL+1):EndL);
end
FirstLine=['void InitModel_' ModelName '(float v' StatesAndParamsStr ') {'];
InitDeclare=[FirstLine(1:end-1) ';'];
TmpLines=strcat(CurLines,';');
tmpInd = find(strhas(TmpLines,'SOLVE'));
if(tmpInd)
    TmpLines{tmpInd} = '}';
end
CInitLines=[FirstLine; Straighten(TmpLines)'];

CInitLines=AddParamsToFuncCall(CInitLines,FuncNames,InputVarsC,AllParamLineCall);
% CInitLinesCu=AddParamsToFuncCallC(CInitLines,FuncNames,InputVarsC,AllParamLineCallC);
if(~exist('StatesAndParamsStrSeg'))
    StatesAndParamsStrSeg='';
end

CallToInit=['InitModel_' ModelName '(V[seg]' StatesAndParamsStrSeg ');'];
%CallToInitCu=['InitModel_' ModelName '(V[seg]' StatesAndParamsStrSeg ');'];

TmpLinesCu=TmpLines;
VarDefLine='';
HasAnyFuncCall=false;
for i=1:numel(TmpLinesCu)
    for j=1:numel(FuncNames)
        if(hastoken(TmpLinesCu{i},FuncNames{j}))
            HasAnyFuncCall=true;
            TmpLine=TmpLinesCu{i}(1:find(TmpLinesCu{i}==')',1,'last')-1);
%             TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' ListOfOutVars{j} ');'];
%             TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' AllParamLineCallC{j} ');'];
%             TmpLinesCu{i}=[TmpLine ',' AllParamLineCallC{j} ');'];
            TmpLinesCu{i}=[TmpLine ',' AllParamLineCallAll ');'];
        end
    end
end
if(HasAnyFuncCall)
    CInitLinesCu=[FirstLine; BeforeFirstLineAll; Straighten(TmpLinesCu)'];
else
    CInitLinesCu=[FirstLine; Straighten(TmpLinesCu)'];
end
CInitLinesCu{1}=['__device__ ' regexprep(CInitLinesCu{1},'void\W*','void Cu')];