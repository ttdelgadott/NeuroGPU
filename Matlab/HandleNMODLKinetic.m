% KINETIC states {
%         rates(v)
%         ~c1 <-> o (k12,k21)
%         CONSERVE c1+o=1
% }
KineticLineI=find(strhas(Lines,'KINETIC'));
if(~isempty(KineticLineI))
    StartL=KineticLineI;
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
    FirstLine=['void KineticModel_' ModelName '(' StatesAndParamsStr ') {'];
    TmpVars=AllOutVars;
    LocalsLine='';
    if(~isempty(TmpVars))
        LocalsLine=strcat(TmpVars,',');
        LocalsLine=[FTYPESTR ' ' LocalsLine{:}];
        LocalsLine=[LocalsLine(1:end-1) ';'];
    end
    
    
    
    C_SUFFIX='.c';
    CurFN=ModFN;
    if(exist([CurFN C_SUFFIX]))
        cFileLines = getLines([CurFN C_SUFFIX]);
    else
        [TmpP TmpN]=fileparts(CurFN);
        cFileLines = getLines([TmpP filesep 'x86_64' filesep TmpN C_SUFFIX]);
    end
    CStartLine=find(strhas(cFileLines,'CVODE ode begin'));
    CEndLine=find(strhas(cFileLines,'CVODE matsol'))-1;
    CTmpLines=cFileLines(CStartLine+1:CEndLine)';
    if(isempty(CTmpLines))
        CTmpLines={'}'};
    end
    
    CTmpLines=regexprep(CTmpLines,'_threadargscomma_','');
    
    
    CKineticLines=[FirstLine; CTmpLines];
    CKineticLines=AddParamsToFuncCall(CKineticLines,FuncNames,InputVarsC,AllParamLineCall);
    CallToKinetic=['KineticModel_' ModelName '(V[seg]' StatesAndParamsStrSeg ');'];
    
    
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
        CKineticLinesCu=[FirstLine; LocalsLine; BeforeFirstLineAll; Straighten(TmpLinesCu)'];
    else
    %     CDerivLinesCu=[FirstLine; LocalsLine; SecondLinex; Straighten(TmpLinesCu(1:end-1))'; AddDerivLines; TmpLinesCu(end)];
        CKineticLinesCu=[FirstLine; LocalsLine; Straighten(TmpLinesCu)'];
    end

    CKineticLinesCu{1}=['__device__ ' regexprep(CKineticLinesCu{1},'void\W*','void Cu')];
else
    CallToKinetic = '';
    CKineticLines = {''};
    CKineticLinesCu = {''};
    KineticDeclare = '';
end
