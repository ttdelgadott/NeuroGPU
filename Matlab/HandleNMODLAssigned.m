StartL=regexp(OneBigLine,'ASSIGNED\W*{');
StartL=min(StartIs(StartIs>StartL));
EndI=min(EndIs(EndIs>StartL));
AssignedStr=OneBigLine(StartL+1:EndI-1);
TmpLines=regexprep(AssignedStr,'\(.*?\)',' ');
ToksC=regexp(TmpLines,'\s*','split');
AllAssigned=ToksC(cellNumel(ToksC)>0)';

StartL=regexp(OneBigLine,'STATE\W*{');
if ~isempty(StartL) 
    StartL=min(StartIs(StartIs>StartL));
    EndI=min(EndIs(EndIs>StartL));
    StatesStr=OneBigLine(StartL+1:EndI-1);
    ToksC= regexp(StatesStr,'\s*','split');
    AllState=ToksC(cellNumel(ToksC)>0)';
    if(isempty(AllState))
        AllStateLine=zeros(1,0);
        AllStateLineSeg='';
    else
        AllStateLine=strcat('float@&', AllState);
        AllStateLine=strcat(AllStateLine,',');
        AllStateLine=[AllStateLine{:}];
        AllStateLine=strrep(AllStateLine,'@',' ');
        AllStateLine=AllStateLine(1:end-1);
        AllStateLineSeg=strcat('StatesM[',num2str(((1:numel(AllState))-1+StateStartVal)'));
        AllStateLineSeg=strcat(AllStateLineSeg,'][seg] ,');
        AllStateLineSeg=AllStateLineSeg';
        AllStateLineSeg=AllStateLineSeg(:)';
        AllStateLineSeg=strrep(AllStateLineSeg,'@',' ');
        AllStateLineSeg=AllStateLineSeg(1:end-1);
    end
else
    AllStateLine=zeros(1,0);
        AllStateLineSeg='';
        AllState={};
end

AssignedLine=find(strhas(Lines,'PARAMETER'));
StartL=AssignedLine;
EndL=min(EndLines(EndLines>StartL));
TmpLines=regexprep(Lines((StartL+1):(EndL-1)),'\(.*\)',' ');
TmpLines=regexprep(TmpLines,'<.*>',' ');
TmpLines=regexprep(TmpLines,'\s*','');
TmpLines=TmpLines(strhas(TmpLines,'='));
AllParameters=cell(1,numel(TmpLines));
for i=1:numel(TmpLines)
    AllParameters{i}=strtok(TmpLines{i},'=');
end
GlobalParamI=find(ismember(AllParameters,NeuronS.Global));
NonGlobalParamI=find(~ismember(AllParameters,NeuronS.Global));
CParamLines=cell(numel(GlobalParamI),1);
for i=1:numel(GlobalParamI)
    CParamLines{i}=[FTYPESTR ' ' TmpLines{GlobalParamI(i)} ';'];
end
GlobalsNotPredefined=setdiff( NeuronS.Global,AllParameters);
for i=1:numel(GlobalsNotPredefined)
    CParamLines{end+1}=[FTYPESTR ' ' GlobalsNotPredefined{i} ';'];
end
AllParameters=[AllParameters GlobalsNotPredefined];

AllParamLine='';
AllParamLineSeg='';
AllParamLineDeclare='';
AllParamLineCall='';
if(~isempty(AllParameters(NonGlobalParamI)))
    AllParamLine=strcat('float@', AllParameters(NonGlobalParamI));
    AllParamLine=strcat(AllParamLine,',');
    AllParamLine=[AllParamLine{:}];
    AllParamLine=strrep(AllParamLine,'@',' ');
    AllParamLine=AllParamLine(1:end-1);

    AllParamLineSeg=strcat('ParamsM[',num2str(((1:numel(NonGlobalParamI))-1+ParamStartVal)'));
    AllParamLineSeg=strcat(AllParamLineSeg,'][comp],');
    AllParamLineSeg=AllParamLineSeg';
    AllParamLineSeg=AllParamLineSeg(:)';
    AllParamLineSeg=strrep(AllParamLineSeg,'@',' ');
    AllParamLineSeg=AllParamLineSeg(1:end-1);
    AllParamLineDeclare=[',' AllParamLine];

    AllParamLineCall=strcat(AllParameters(NonGlobalParamI),',');
    AllParamLineCall=[AllParamLineCall{:}];
    AllParamLineCall=strrep(AllParamLineCall,'@',' ');
    AllParamLineCall=AllParamLineCall(1:end-1);
end
%% KINETICS CODE
KineticFlg = 0;
StartL=find(strhas(Lines,'KINETIC'));
stateMat = cell(length(AllState));
if ~isempty(StartL)
    KineticFlg = 1;
    parInd = strfind(Lines{StartL},'{');
    kinName =Lines{StartL}( 8:parInd-2);
    EndL=min(EndLines(EndLines>StartL));
    KinLines=Lines(StartL+1:EndL-1);
    conserveLine = find(strhas(KinLines,'CONSERVE'));
    if ~isempty(conserveLine)
        KinLines(conserveLine) = []
    end
    transitionLinesInds = find(strhas(KinLines,'<->'));
    transitionLines = KinLines(transitionLinesInds);
    firstLines = KinLines(1:transitionLinesInds-1);
    matrixBuildLines = {'double sum = 0;',firstLines{:}};
    % c1<->c2 (k12,k21) setting a matrix where i is c1 j is c2 index in
    % states and vlues would be at i,j - k12 (forward transition) k21 j,i (backward transition)
    for currLineInd = 1:length(transitionLines)
        currLine = transitionLines{currLineInd};
        transStr = currLine(strfind(currLine,'(')+1:strfind(currLine,')')-1);
        [match,tokens] = regexp(currLine(1:strfind(currLine,'(')),'\s*~\s*(\w+)\s*<->\s*(\w+)\s*','match','tokens');
        stateI = tokens{1}{1};
        stateJ = tokens{1}{2};
        indI=find(strhas(AllState,stateI));
        indJ=find(strhas(AllState,stateJ));
        transitions = strsplit(transStr,',');
        stateMat(indI,indJ)=transitions(1);
        stateMat(indJ,indI)=transitions(2);
        matrixBuildLines(end+1) = strcat('//matq[',num2str(indI-1),'][' ,num2str(indJ-1) ,'] = ' ,stateMat(indI,indJ),';');
        matrixBuildLines(end+1) = strcat('//matq[',num2str(indJ-1),'][',num2str(indI-1),'] = ',stateMat(indJ,indI),';');
    end
    matrixBuildLines{end+1} = strcat('for (int i = 0; i < ',num2str(length(AllState)),'; i++) {');
    matrixBuildLines{end+1} = 'sum = 0 ;';
    matrixBuildLines{end+1} = strcat('for (int j = 0; j < ',num2str(length(AllState)),'; j++) {');
    matrixBuildLines{end+1} = 'if (i != j) {' 
    matrixBuildLines{end+1} = '//sum +=matq[i][j];'
    matrixBuildLines{end+1} = '}';
    matrixBuildLines{end+1} = '}';
    matrixBuildLines{end+1} = '//matq[i][i] = -sum;'	
    matrixBuildLines{end+1} = '}';
    matrixBuildLines{end+1} = '}';
    KinLocals = strcat('float matq[',num2str(length(AllState)),'][',num2str(length(AllState)),'],rhs[',num2str(length(AllState)),'],y[',num2str(length(AllState)),'];');
    
   
end

 
    



%%END OF KINETIC CODE
StateParamSeperator='';
if(~isempty(AllStateLine))
    StateParamSeperator=',';
end
ParamGlobalSeperator='';
if(~isempty(AllParamLine))
    ParamGlobalSeperator=',';
end

if(~exist('AllReadsNoReversals','var'))
    return;
end

OnlyRead='';
OnlyReadSeg='';
if(~isempty(NeuronS.OnlyReadsNoReversals))
    OnlyRead=strcat(', float>',NeuronS.OnlyReadsNoReversals);
    OnlyRead=strrep(OnlyRead,'>',' ');
    OnlyReadSeg=strcat(strcat(', ',NeuronS.OnlyReadsNoReversals),'[ seg ]');
    OnlyRead=[OnlyRead{:}];
    OnlyReadSeg=[OnlyReadSeg{:}];
end
WriteNoCurrent='';
WriteNoCurrentSeg='';
if(~isempty(NeuronS.WritesNoCurrents))
    WriteNoCurrent=strcat(', float &',NeuronS.WritesNoCurrents);
    WriteNoCurrentSeg=strcat(strcat(', ',NeuronS.WritesNoCurrents),'[ seg ]');
    WriteNoCurrent=[WriteNoCurrent{:}];
    WriteNoCurrentSeg=[WriteNoCurrentSeg{:}];
end
AdditionalWrites='';
AdditionalWritesSeg='';
AdditionalWritesC=setdiff(intersect(NeuronS.Writes,AllReadsNoReversals),NeuronS.WritesNoCurrents);
if(~isempty(AdditionalWritesC))
    AdditionalWrites=strcat(', float &',AdditionalWritesC);
    AdditionalWritesSeg=strcat(strcat(', ',AdditionalWritesC),'[ seg ]');
    AdditionalWrites=[AdditionalWrites{:}];
    AdditionalWritesSeg=[AdditionalWritesSeg{:}];
end

StatesAndParamsStr=[StateParamSeperator AllStateLine ParamGlobalSeperator AllParamLine OnlyRead WriteNoCurrent AdditionalWrites];
StatesAndParamsStrSeg=[StateParamSeperator AllStateLineSeg ParamGlobalSeperator AllParamLineSeg OnlyReadSeg WriteNoCurrentSeg AdditionalWritesSeg];
StatesAndParamsStrSeg=AddModelNameToFunctions(StatesAndParamsStrSeg,AllReadsNoReversals,ExtraStatesTrg);
Locals=setdiff(AllAssigned,['celsius' 'v' AllState' AllParameters Reads Writes]);
LocalsC{CurModI}=Locals';