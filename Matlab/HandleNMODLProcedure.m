% PROCEDURE rates(v(mV)) {  :Computes rate and other constants at current v.
%                       :Call once from HOC to initialize inf at resting v.
%         LOCAL  alpha, beta, sum, q10
%         TABLE minf, mtau, hinf, htau, ninf, ntau DEPEND celsius FROM -100
%         TO 100 WITH 200
% UNITSOFF
%         q10 = 3^((celsius - 6.3)/10)
%                 :"m" sodium activation system
%         alpha = .1 * vtrap(-(v+40),10)
%         beta =  4 * exp(-(v+65)/18)
%         sum = alpha + beta
% 	mtau = 1/(q10*sum)
%         minf = alpha/sum
%                 :"h" sodium inactivation system
%         alpha = .07 * exp(-(v+65)/20)
%         beta = 1 / (exp(-(v+35)/10) + 1)
%         sum = alpha + beta
% 	htau = 1/(q10*sum)
%         hinf = alpha/sum
%                 :"n" potassium activation system
%         alpha = .01*vtrap(-(v+55),10)
%         beta = .125*exp(-(v+65)/80)
% 	sum = alpha + beta
%         ntau = 1/(q10*sum)
%         ninf = alpha/sum
% }
clear CProcLines
ProcedureLines=find(strhas(Lines,'PROCEDURE'));
nProcs=numel(ProcedureLines);
CProcLines=cell(1,nProcs);
CProcLinesCu=cell(1,nProcs);
FuncNames=cell(1,nProcs);
InputVarsC=cell(1,nProcs);
BeforeFirstLinesC=cell(1,nProcs);
ProcDeclare=cell(1,nProcs);
ProcDeclareCu=cell(1,nProcs);
for i=1:nProcs
    StartL=ProcedureLines(i);
    EndL=min(EndLines(EndLines>StartL));
    CurLines=Lines((StartL+1):EndL);
    CLocalLine='';
    LocalVars=cell(0);
    LocalLineF=find(strhas(CurLines,'LOCAL'));
    if(~isempty(LocalLineF))
        LocalLine=CurLines{LocalLineF};
        LocalVarLine=LocalLine((strfind(LocalLine,'LOCAL')+6):end);
        LocalVarLine=regexprep(LocalVarLine,'\s*','');
        LocalVars=regexp(LocalVarLine,',','split');
        CLocalLine=[FTYPESTR ' ' LocalVarLine ';'];
    end
    
    EqualLinesF=find(strhas(CurLines,'='));
    UpdatedVars=cell(0);
    for j=EqualLinesF
        UpdatedVars=[UpdatedVars fliplr(strtok(fliplr(CurLines{j}(1:(find(CurLines{j}=='=',1)-1)))))];
    end
    UpdatedVars=unique(UpdatedVars);
    OutVars=setdiff(UpdatedVars,LocalVars);
    OutVarsC{i}=OutVars;
    
    ProcedureLine=Lines{StartL};
    ProcedureLine=ProcedureLine(strfind(ProcedureLine,'PROCEDURE')+10:end);
    FuncName=strtok(strrep(ProcedureLine,'(',' '));
    FuncNames{i}=FuncName;
    RestLine=ProcedureLine(strfind(ProcedureLine,'(')+1:end);
    RestLine= regexprep(RestLine,'\(.*?\)','');
    RestLine=RestLine(1:(find(RestLine==')',1)-1));
    InputVars=regexp(RestLine,',','split');
    InputVarsC{i}=InputVars;
    FirstLine=['void ' FuncName '('];
    for k=1:numel(InputVars)
        Tmp='';
        if(k>1)
            Tmp=',';
        end
        FirstLine=[FirstLine Tmp FTYPESTR ' ' InputVars{k}];
    end
    BeforeFirstLine='';
    for k=1:numel(OutVars)
        Tmp='';
        if(k>1)
            Tmp=',';
        end
        BeforeFirstLine=[BeforeFirstLine Tmp OutVars{k}];
    end
    ListOfOutVars{i}=BeforeFirstLine;
    BeforeFirstLine=[FTYPESTR ' ' BeforeFirstLine ';'];
    FirstLine=[FirstLine AllParamLineDeclare ') {'];
    FLines=CurLines(~strhas(CurLines,'(UNITSOFF|LOCAL|TABLE)'));
    FLines=strcat(FLines,';');
    Straighten=@(x) reshape(x,[1 numel(x)]);
    
    if(~isempty(LocalLineF))
        LocalLine=CurLines{LocalLineF};
        CLocalLine=[FTYPESTR ' ' LocalLine((strfind(LocalLine,'LOCAL')+6):end) ';'];
    end
    BeforeFirstLinesC{i}=BeforeFirstLine;
    CProcLines{i}=[FirstLine; CLocalLine; Straighten(FLines)'];
    
    ProcDeclare{i}=[FirstLine(1:end-1) ';'];
    OutVarsNoGlobals=setdiff(OutVars,NeuronS.Global);
    Tmp=strcat(OutVarsNoGlobals,',');
    Tmp=cat(2,Tmp{:});

    SeparatorStr=',';
    if(isempty(OutVarsNoGlobals))
        SeparatorStr='';
    end

    AllParamLineCallC{i}=[AllParamLineCall SeparatorStr Tmp(1:end-1)];
    ProcDeclareCu{i}=[ProcDeclare{i}(1:find(ProcDeclare{i}==')')-1) '|X|X|' ');'];
    FirstLineCu=[ProcDeclareCu{i}(1:end-1) ' {'];

    CProcLinesCu{i}=[FirstLineCu; CLocalLine; Straighten(FLines)'];
end

AllOutVars={};
for i=1:nProcs
    AllOutVars=union(AllOutVars,OutVarsC{i});
end
AllOutVars=setdiff(AllOutVars,NeuronS.Global);
TmpStr='';
for ii=1:numel(AllOutVars)
    TmpStr=[TmpStr FTYPESTR ' &' AllOutVars{ii} ','];
end
TmpStr=TmpStr(1:end-1);
SeparatorStr=',';
if(isempty(TmpStr))
    SeparatorStr='';
end
TmpKin = strcat(AllOutVars,',');
Tmp=strcat(AllOutVars,',');
Tmp=cat(2,Tmp{:});
TmpKin = cat(2,TmpKin{:});
SeparatorStr=',';
if(isempty(AllOutVars))
    SeparatorStr='';
end
AllParamLineCallAllForKin = [AllParamLineCall SeparatorStr TmpKin(1:end-1)];
AllParamLineCallAll=[AllParamLineCall SeparatorStr Tmp(1:end-1)];

BeforeFirstLineAll='';
for k=1:numel(AllOutVars)
    Tmp='';
    if(k>1)
        Tmp=',';
    end
    BeforeFirstLineAll=[BeforeFirstLineAll Tmp AllOutVars{k}];
end
ListOfOutVarsAll=BeforeFirstLineAll;
BeforeFirstLineAll=[FTYPESTR ' ' BeforeFirstLineAll ';'];
    

for i=1:nProcs
    ProcDeclareCu{i}=gstrcat('__device__ ',strrep(ProcDeclareCu{i},'|X|X|',[SeparatorStr TmpStr]));
    ProcDeclareCu{i}=regexprep(ProcDeclareCu{i},'void\W*','void Cu');
    ProcDeclareCu{i}=regexprep(ProcDeclareCu{i},'\W*\(',['_' ModelName '\(']);

    CProcLines{i}(2:end)=AddParamsToFuncCall(CProcLines{i}(2:end),FuncNames,InputVarsC,AllParamLineCall);
    %CProcLinesCu{i}(2:end)=AddParamsToFuncCall(CProcLinesCu{i}(2:end),FuncNames,InputVarsC,AllParamLineCall);
    
    CProcLinesCu{i}{1}=gstrcat('__device__ ',strrep(CProcLinesCu{i}{1},'|X|X|',[SeparatorStr TmpStr]));
    CProcLinesCu{i}{1}=regexprep(CProcLinesCu{i}{1},'void\W*','void Cu');
    CProcLinesCu{i}{1}=regexprep(CProcLinesCu{i}{1},'\W*\(',['_' ModelName '\(']);
end

for k=1:nProcs
    TmpLinesCu=CProcLinesCu{k}(2:end);
    for i=1:numel(TmpLinesCu)
        for j=1:numel(FuncNames)
            if(hastoken(TmpLinesCu{i},FuncNames{j}))
                TmpLine=TmpLinesCu{i}(1:find(TmpLinesCu{i}==')',1,'last')-1);
                %             TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' ListOfOutVars{j} ');'];
%                 TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' AllParamLineCallC{j} ');'];
                TmpLinesCu{i}=[TmpLine ',' AllParamLineCallC{j} ');'];
            end
        end
    end
    CProcLinesCu{k}(2:end)=TmpLinesCu;
end