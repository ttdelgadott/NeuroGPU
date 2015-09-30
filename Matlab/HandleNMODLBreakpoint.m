% BREAKPOINT {
%         SOLVE states METHOD cnexp
%         gna = gnabar*m*m*m*h
% 	ina = gna*(v - ena)
%         gk = gkbar*n*n*n*n
% 	ik = gk*(v - ek)
%         il = gl*(v - el)
% }

BreakLineI=find(strhas(Lines,'BREAKPOINT'));
StartL=BreakLineI;
EndL=StartL;
SumP=0;
while(1)
    SumP=SumP+sum(Lines{EndL}=='{')-sum(Lines{EndL}=='}');
    if(SumP==0)
        break;
    end
    EndL=EndL+1;
end
CurLines=Lines((StartL+1):EndL);
SolveLine=CurLines(strhas(CurLines,'SOLVE'));
[Tmp RestLine]=strtok(SolveLine);
[SolveWhat RestLine]=strtok(RestLine);
[Tmp RestLine]=strtok(RestLine);
SolveMethod=strtok(RestLine);
if(~strcmp(SolveMethod,'cnexp'))
    disp(['Solve method not cnexp! in ' ModelName]);
end
CurLines=CurLines(~strhas(CurLines,'SOLVE'));
CurLines=regexprep(CurLines,'\s*','');

FirstLine=['void BreakpointModel_' ModelName '(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v' StatesAndParamsStr ') {'];
BreakPointDeclare=[FirstLine(1:end-1) ';'];
TmpLines=strcat(CurLines,';');
TmpVars=setdiff(NeuronS.Range,union(AllParameters,AllState));
SecondLine=strcat(union(TmpVars,NeuronS.Condatances),',');
SecondLine=[FTYPESTR ' ' SecondLine{:}];
SecondLine=[SecondLine(1:end-1) ';'];
% BreakOutVars=[{NeuronS.UseIon(:).write} NeuronS.NonspecificCurrent];
BreakOutVars={NeuronS.Writes NeuronS.NonspecificCurrent};
BreakOutVars=BreakOutVars(cellNumel(BreakOutVars)>0);
BreakOutVars=cat(1,BreakOutVars{:});
BreakOutVars=setdiff(BreakOutVars,union(AdditionalWritesC,NeuronS.WritesNoCurrents));
ThirdLine='';
if(~isempty(BreakOutVars))
    ThirdLine=strcat(BreakOutVars,',');
    ThirdLine=[FTYPESTR ' ' ThirdLine{:}];
    ThirdLine=[ThirdLine(1:end-1) ';'];
end
CurrentNames=intersect(strcat('i',{NeuronS.UseIon.name}),NeuronS.Writes);
BeforeLastLine='';
if(~isempty(CurrentNames))
    BeforeLastLine=['sumCurrents+= ' CurrentNames{1} ';'];
end
% BeforeLastLine=strcat(BreakOutVars,'+');
% BeforeLastLine=['sumCurrents= ' BeforeLastLine{:}];
% BeforeLastLine=[BeforeLastLine(1:end-1) ';'];

ConductivityNames=intersect(strcat('g',{NeuronS.UseIon.name}),union(AllAssigned,'g'));
BeforeLastLine2='';
if(~isempty(ConductivityNames))
    BeforeLastLine2=['sumConductivity+= ' ConductivityNames{1} ';'];
end
% BeforeLastLine2=strcat(TmpVars,'+');
% BeforeLastLine2=['sumConductivity= ' BeforeLastLine2{:}];
% BeforeLastLine2=[BeforeLastLine2(1:end-1) ';'];

ReadReversal=intersect(NeuronS.Reversals,NeuronS.Read);
ReadReversalWrite={};
if(~isempty(ReadReversal))
    ReadReversalWrite=intersect({[ReadReversal{1}(2:end) 'i'],[ReadReversal{1}(2:end) 'o']},AllWrites);
end
NernstLines={};
if(~isempty(ReadReversalWrite))
    NernstLines{1}=[FTYPESTR ' ' ReadReversal{1} ';'];
    iStr=[ReadReversal{1}(2:end) 'i'];
    oStr=[ReadReversal{1}(2:end) 'o'];
    if(~ismember(iStr,NeuronS.Read))
        iStr=['DEF_' iStr];
    end
    if(~ismember(oStr,NeuronS.Read))
        oStr=['DEF_' oStr];
    end
    ZStr='1.';
    if(strcmp(ReadReversal{1}(2:end),'ca'))
        ZStr='2.';
    end
    NernstLines{2}=[ReadReversal{1} ' = nernst(' iStr ',' oStr ',' ZStr ');'];
end

CBreakLines=[FirstLine; Straighten(NernstLines)'; Straighten(TmpLines(1:end-1))'; BeforeLastLine; BeforeLastLine2; TmpLines(end) ];
CBreakLinesCu=[FirstLine; Straighten(strrep(NernstLines,'nernst','Cunernst'))'; SecondLine; ThirdLine; Straighten(TmpLines(1:end-1))'; BeforeLastLine; BeforeLastLine2; TmpLines(end) ];

CBreakLines=AddParamsToFuncCall(CBreakLines,FuncNames,InputVarsC,AllParamLineCall);
CBreakLinesCu=AddParamsToFuncCall(CBreakLinesCu,FuncNames,InputVarsC,AllParamLineCall);
CBreakLinesCu{1}=['__device__ ' regexprep(CBreakLinesCu{1},'void\W*','void Cu')];

CallToBreak=['BreakpointModel_' ModelName '(sumCurrents, sumConductivity, V[seg]' StatesAndParamsStrSeg ');'];
CallToBreakDv=['BreakpointModel_' ModelName '(sumCurrentsDv, sumConductivityDv, V[seg]+0.001' StatesAndParamsStrSeg ');'];