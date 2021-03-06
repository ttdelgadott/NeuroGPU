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
    tmpkin= strcat('float rhs[', num2str(length(AllState)),'];') ;
    tmpkin2 = strcat('float y[', num2str(length(AllState)), '];');
    tmpkin3 = strcat('float matq[', num2str(length(AllState)), '][', num2str(length(AllState)),'];');

    % CDerivLinesx=[FirstLine; SecondLinex; Straighten(TmpLines(1:end-1))'; AddDerivLines; TmpLines(end)];
    CDerivLines=[FirstLine;tmpkin; tmpkin2; tmpkin3; CTmpLines];

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
if KineticFlg
    kinName = strtrim(kinName);
    FirstLine=['void DerivModel_' ModelName '(float dt, float v' StatesAndParamsStr ') {'];
    Derivs=strcat(AllState,'_d');
    Derivs(1:end-1)=strcat(Derivs(1:end-1),',');
    SecondLinex=[FTYPESTR ' ' [Derivs{:}] ';'];
    TmpVars=setdiff(setdiff(Locals,AllParameters),union(AllOutVars,NeuronS.Condatances));
    DerivDeclare=[FirstLine(1:end-1) ';'];
    TmpLines=strcat(regexprep(CurLines,'''','_d'),';');
%     AddDerivLines=strcat(AllState,'+=');
%     AddDerivLines=strcat(AddDerivLines,AllState);
%     AddDerivLines=strcat(AddDerivLines,'_d*dt;');
    C_SUFFIX='.c';
    CurFN=ModFN;
    if(exist([CurFN C_SUFFIX]))
        cFileLines = getLines([CurFN C_SUFFIX]);
    else
        [TmpP TmpN]=fileparts(CurFN);
        cFileLines = getLines([TmpP filesep 'x86_64' filesep TmpN C_SUFFIX]);
    end
    CStartLine=find(strhas(cFileLines,[kinName,'? ('])); 
    CEndLine=find(strhas(cFileLines,'return _reset;'))+1;
    CEndLine=min(CEndLine(CEndLine>CStartLine))+1;
    CTmpLines=cFileLines(CStartLine+1:CEndLine)';
    if(isempty(CTmpLines))
        CTmpLines={'}'};
    end
    CTmpLines=regexprep(CTmpLines,'return _reset;','');
    CTmpLines=regexprep(CTmpLines,'_threadargscomma_','');
    CTmpLines=regexprep(CTmpLines,'-_dt1.*','0;');
    CTmpLines=strrep(CTmpLines,'/*CONSERVATION*/',['backwards_euler(dt,3,',num2str(length(AllState)),',rhs,y,matq);']);
    CDerivLines=[FirstLine; CTmpLines; {'}'}];
    if (KineticFlg)
        CDerivLines=AddParamsToFuncCall(CDerivLines,FuncNames,InputVarsC,AllParamLineCallAllForKin);
    else
        CDerivLines=AddParamsToFuncCall(CDerivLines,FuncNames,InputVarsC,AllParamLineCall);
    end
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
                if(KineticFlg)
                    TmpLinesCu{i}=[TmpLine ',' AllParamLineCallAllForKin ');'];
                else
                    TmpLinesCu{i}=[TmpLine ',' AllParamLineCallAll ');'];
                end
            end
        end
    end
    TmpLinesCu{end+1} = '}';
    tmpkin= strcat('float rhs[', num2str(length(AllState)),'];') ;
    tmpkin2 = strcat('float y[', num2str(length(AllState)), '];');
    tmpkin3 = strcat('float matq[', num2str(length(AllState)), '][', num2str(length(AllState)),'];');
    addKineticsStuff = {};
    for jj = 0:(length(AllState)-1)
        addKineticsStuff{end+1} =strcat('y[',num2str(jj),'] = ' ,AllState{jj+1} ,';'); 
    end
    if(HasAnyFuncCall)
    %     CDerivLinesCu=[FirstLine; LocalsLine; BeforeFirstLineAll; SecondLinex; Straighten(TmpLinesCu(1:end-1))'; AddDerivLines; TmpLines(end)];
        CDerivLinesCu=[FirstLine; BeforeFirstLineAll; tmpkin; tmpkin2; tmpkin3; Straighten( addKineticsStuff)'; Straighten(TmpLinesCu)'];
    else
    %     CDerivLinesCu=[FirstLine; LocalsLine; SecondLinex; Straighten(TmpLinesCu(1:end-1))'; AddDerivLines; TmpLinesCu(end)];
        CDerivLinesCu=[FirstLine;  Straighten(TmpLinesCu)'];
    end

    CDerivLinesCu{1}=['__device__ ' regexprep(CDerivLinesCu{1},'void\W*','int Cu')];
end