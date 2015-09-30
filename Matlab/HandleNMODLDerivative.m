% DERIVATIVE states {  
%         rates(v)
%         m' =  (minf-m)/mtau
%         h' = (hinf-h)/htau
%         n' = (ninf-n)/ntau
% }
DerivLineI=find(strhas(Lines,'DERIVATIVE'));
if(~isempty(DerivLineI))
    StartL=DerivLineI;
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
    FirstLine=['void DerivModel_' ModelName '(float dt, float v' StatesAndParamsStr ') {'];
    Derivs=strcat(AllState,'_d');
    Derivs(1:end-1)=strcat(Derivs(1:end-1),',');
    SecondLinex=[FTYPESTR ' ' [Derivs{:}] ';'];

    TmpVars=setdiff(setdiff(Locals,AllParameters),union(AllOutVars,NeuronS.Condatances));
    LocalsLine='';
    if(~isempty(TmpVars))
        LocalsLine=strcat(TmpVars,',');
        LocalsLine=[FTYPESTR ' ' LocalsLine{:}];
        LocalsLine=[LocalsLine(1:end-1) ';'];
    end

    DerivDeclare=[FirstLine(1:end-1) ';'];
    TmpLines=strcat(regexprep(CurLines,'''','_d'),';');
    AddDerivLines=strcat(AllState,'+=');
    AddDerivLines=strcat(AddDerivLines,AllState);
    AddDerivLines=strcat(AddDerivLines,'_d*dt;');

    C_SUFFIX='.c';
    CurFN=ModFN;
    if(exist([CurFN C_SUFFIX]))
        cFileLines = getLines([CurFN C_SUFFIX]);
    else
        [TmpP TmpN]=fileparts(CurFN);
        cFileLines = getLines([TmpP filesep 'x86_64' filesep TmpN C_SUFFIX]);
    end
    CStartLine=find(strhas(cFileLines,'static int states? ('));
    CEndLine=find(strhas(cFileLines,'return 0;'));
    CEndLine=min(CEndLine(CEndLine>CStartLine))-1;
    CTmpLines=cFileLines(CStartLine+1:CEndLine)';
    if(isempty(CTmpLines))
        CTmpLines={'}'};
    end
    CTmpLines=regexprep(CTmpLines,'_threadargscomma_','');

    % CDerivLinesx=[FirstLine; SecondLinex; Straighten(TmpLines(1:end-1))'; AddDerivLines; TmpLines(end)];
    CDerivLines=[FirstLine; CTmpLines];

    CDerivLines=AddParamsToFuncCall(CDerivLines,FuncNames,InputVarsC,AllParamLineCall);

    CallToDeriv=['DerivModel_' ModelName '(dt, V[seg]' StatesAndParamsStrSeg ');'];

    TmpLinesCu=CTmpLines;
    HasAnyFuncCall=false;
    for i=1:numel(TmpLinesCu)
        for j=1:numel(FuncNames)
            if(hastoken(TmpLinesCu{i},FuncNames{j}))
                HasAnyFuncCall=true;
                TmpLine=TmpLinesCu{i}(1:find(TmpLinesCu{i}==')',1,'last')-1);
    %             TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' ListOfOutVars{j} ');'];
    %             TmpLinesCu{i}=[BeforeFirstLinesC{j} sprintf('\n') TmpLine ',' AllParamLineCallC{j} ');'];
                TmpLinesCu{i}=[TmpLine ',' AllParamLineCallAll ');'];
            end
        end
    end
    if(HasAnyFuncCall)
    %     CDerivLinesCu=[FirstLine; LocalsLine; BeforeFirstLineAll; SecondLinex; Straighten(TmpLinesCu(1:end-1))'; AddDerivLines; TmpLines(end)];
        CDerivLinesCu=[FirstLine; LocalsLine; BeforeFirstLineAll; Straighten(TmpLinesCu)'];
    else
    %     CDerivLinesCu=[FirstLine; LocalsLine; SecondLinex; Straighten(TmpLinesCu(1:end-1))'; AddDerivLines; TmpLinesCu(end)];
        CDerivLinesCu=[FirstLine; LocalsLine; Straighten(TmpLinesCu)'];
    end

    CDerivLinesCu{1}=['__device__ ' regexprep(CDerivLinesCu{1},'void\W*','void Cu')];
else
    CallToDeriv = '';
    CDerivLines = {''};
    CDerivLinesCu = {''};
    DerivDeclare = '';
end