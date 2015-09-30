%This function creates a new hoc file called runModel_params which will
%hold all the mechanisms parameters in the 

function parseHocFile( hocFileName, FN_Topo, FN_TopoMDL, FN_TopoPP)
%Parse the hoc file (assuming all the required mechanisms are in the same 
%folder) to the .m files needed for main to run. 
%   Detailed explanation goes here

%get all the hoc files lines without comments
hocFileLines = getLines(hocFileName);
hocFileLines = deleteComments(hocFileLines, '//');
hocFileLines = deleteBlockComments(hocFileLines, '/*', '*/');

%get all the mechanisms names
% LL=regexp(hocFileLines,'\s*insert\s*(\S+).*','tokens');
% Tmp=cat(1,LL{:});
% availableMechanisms=unique(cat(1,Tmp{:}));
%% get Mechnisms from the MDL file
availableMechanisms=getMechanismsFromMDLFile(FN_TopoMDL);
% availableMechanisms=setdiff(availableMechanisms,{'stim','pas'});
availableMechanisms=setdiff(availableMechanisms,{'stim'});

IC=sum(cellNumel(regexp(hocFileLines,'IClamp')));
isThereStimMech = false;
if(IC>0)
    availableMechanisms{end+1}='stim';
    isThereStimMech = true;
end

% get all the segments of the compartments
fidTopo = fopen(FN_Topo);
nSegsMat = getNsegsMat2(fidTopo);
FIRST_SEG_INDEX = 1;
LAST_SEG_INDEX = 2;
numOfCompartments = size(nSegsMat, 1);
segInd = 1;
numOfEmptySegsBetweenCompartments = 1;
compSegsIndexArr = zeros (numOfCompartments, 2);
for i= 1:numOfCompartments
    segInd = segInd + numOfEmptySegsBetweenCompartments;
    compSegsIndexArr(i, FIRST_SEG_INDEX) = segInd;
    segInd = segInd + nSegsMat(i,1) - 1;
    compSegsIndexArr(i, LAST_SEG_INDEX) = segInd;
    segInd = segInd + 1;
end;
numOfSegs = segInd;
%get the mechanisms of each compartment
compMechs = getCompMechs(FN_TopoMDL);

%if there is a stim mechanism than need to indicate that the neuron doesn't
%have the model but in the specific segments.
if (isThereStimMech)
    %stim is always the last mechanism.
    %outputLines{end+1} = ['hasModel(:,' int2str(numOfMechanisms) ') = 0;'];
    fidPP = fopen(FN_TopoPP);  
    ppInSegments = getPpInSegments(nSegsMat, fidPP, compSegsIndexArr);
    %QWERTY - to continue here - last thing to add is the hasModel = 1 in the
    %segments of the stim location
end

numOfMechanisms = numel(availableMechanisms);

%%
ModMap=ConnectMechanismsToModFiles(hocFileName);

%parse all the mechnisms model files to matlab files.
for i=1:(numOfMechanisms-isThereStimMech)
    parseNmodlToMatlab2(availableMechanisms{i}, ppInSegments, numOfSegs, ModMap);
end;

def_generalMatlabStr;
defFilesPrefixes={DEF_CONSTS_PER_MODEL_PER_SEG, DEF_VARS_PER_MODEL_PER_SEG, DEF_VARS_PER_MODEL_ALL_SEGS};
clear Tmp
for i=1:numel(defFilesPrefixes)
    for j=1:numOfMechanisms
        Tmp(i,j)=getNumOfVarsFromDefFile([defFilesPrefixes{i} availableMechanisms{j} '.m']);
    end
end

maxConstsPerModelPerSeg= max(Tmp(1,:));
%MAX_NUM_CONSTS_PER_SEG = 20;
maxConstsGlobal = 3;
maxVarsPerModelPerSeg = max(Tmp(2,:));
maxVarsPerModelAllSegs = max(Tmp(3,:));
%MAX_NUM_VARS_ALL_MODELS_PER_SEG = 20;

def_generalMatlabStr;
outputLines = cell(0);
outputLines{end+1} = ['NUM_OF_MODELS = ' int2str(numOfMechanisms) ';'];
outputLines{end+1} = ['NUM_OF_SEGS = ' int2str(numOfSegs) ';'];
outputLines{end+1} = ['MAX_NUM_CONSTS_PER_MODEL = ' int2str(maxConstsPerModelPerSeg) ';'];
outputLines{end+1} = ['MAX_NUM_CONSTS_GLOBAL = ' int2str(maxConstsGlobal) ';'];
outputLines{end+1} = ['MAX_NUM_VARS_PER_MODEL_PER_SEG = ' int2str(maxVarsPerModelPerSeg) ';'];
outputLines{end+1} = ['MAX_NUM_VARS_PER_MODEL_ALL_SEGS = ' int2str(maxVarsPerModelAllSegs) ';'];

outputLines{end+2} = 'ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);';
outputLines{end+1} = 'ModelsFuncsNames(:, INIT_INDEX) = {''NrnInitModel_''};';
outputLines{end+1} = 'ModelsFuncsNames(:, CURRENT_INDEX) = {''NrnCurrent_''};';
outputLines{end+1} = 'ModelsFuncsNames(:, STATES_INDEX) = {''NrnStates_''};';

for i=1:numOfMechanisms
    outputLines{end+1} = ['ModelsFuncsNames(' int2str(i) ',:) = strcat(ModelsFuncsNames('...
         int2str(i) ',:), ''' availableMechanisms{i} ''');'];
end

% % % % % for segInd=2:3
% % % % %     hasModel(segInd, MAINENNA_INDEX) = 1;
% % % % %     hasModel(segInd, MAINENKV_INDEX) = 1;
% % % % %     hasModel(segInd, HH_INDEX) = 1;
% % % % % end;

outputLines{end+2} = 'hasModel = zeros (NUM_OF_SEGS, NUM_OF_MODELS);';

% % % numOfForkSegments  = numel(forkSegments);
if (isThereStimMech)
    numOfRegularMechs = numOfMechanisms - 1;
else
    numOfRegularMechs = numOfMechanisms;
end

for compInd=1:numOfCompartments
    outputLines{end+1} = ['for segInd = ' int2str(compSegsIndexArr(compInd, FIRST_SEG_INDEX))...
        ':' int2str(compSegsIndexArr(compInd, LAST_SEG_INDEX))];
    thisCompMechs = compMechs{1, compInd};
    numOfMechsForThisComp = size(thisCompMechs, 1);
    F=find(ismember(availableMechanisms,thisCompMechs)');
    Straighten=@(x) reshape(x,[1 numel(x)]);
    outputLines{end+1} = ['    hasModel(segInd, [' int2str(Straighten(F)) ']) = 1;'];
%     for mechInd = 1:numOfMechsForThisComp
%         TF = strcmp (thisCompMechs{mechInd}, availableMechanisms);
%         wantedMechInd = find(TF,1,'first');
%         outputLines{end+1} = ['    hasModel(segInd, ' int2str(wantedMechInd) ') = 1;'];
%     end
    outputLines{end+1} = 'end';
end


StimSegs=[];
for tt=1:length(ppInSegments)
    if(isempty(ppInSegments{tt}))
        continue;
    end
    StimSegs=[StimSegs ppInSegments{tt}(1,:)];
end
StimIdxStr=num2str(find(strcmp(availableMechanisms,'stim')));
outputLines{end+1} = ['hasModel([' num2str(StimSegs) '],' StimIdxStr ')=1;'];

% % % outputLines{end+2} = 'hasModel = ones (NUM_OF_SEGS, NUM_OF_MODELS);';
% % % 
% % % numOfForkSegments  = numel(forkSegments);
% % % if (isThereStimMech)
% % %     numOfRegularMechs = numOfMechanisms - 1;
% % % else
% % %     numOfRegularMechs = numOfMechanisms;
% % % end
% % % for forkSegInd=1:numOfForkSegments
% % %     for mechInd=1:numOfRegularMechs
% % %         outputLines{end+1} = ['hasModel(' int2str(forkSegments(forkSegInd))...
% % %             ', ' int2str(mechInd) ') = 0;'];
% % %     end     
% % % end
% % % 
% % % %if there is a stim mechanism than need to indicate that the neuron doesn't
% % % %have the model but in the specific segments.
% % % if (isThereStimMech)
% % %     %stim is always the last mechanism.
% % %     outputLines{end+1} = ['hasModel(:,' int2str(numOfMechanisms) ') = 0;'];
% % %     
% % %     %QWERTY - to continue here - last thing to add is the hasModel = 1 in the
% % %     %segments of the stim location
% % % end

%This was abondended for now.
%Add IClamps
% % % for i=1:numel(hocFileLines)
% % %     line = hocFileLines{i};
% % %     %if line contains IClamp
% % %     if (~isempty(strfind(line, 'IClamp')))
% % %         tokens = regexp(line, '(?:[\w]* +)*(\w+) *= *new *IClamp *\(([01]*.\d*)\).*', 'tokens');
% % %         stimName = tokens{1}{1};
% % %         pos = tokens{1}{2};
% % %         for j=i+1:numel(hocFileLines)
% % %             line2 = hocFileLines{j};
% % %             if (~isempty(strfind(line, stimName)))
% % %                 if (~isempty(strfind(line, 'amp')))
% % %                 %tokens = regexp(line, '
% % %                 %QWERTY continue here...
% % %                 end
% % %             end
% % %         end
% % %     end
% % % end

fileNameOut = 'hocFileData.m';
fid=fopen(fileNameOut,'w');
numOfLines = numel(outputLines);
for i=1:numOfLines
    fprintf(fid,'%s\n',outputLines{i});
end
fprintf(fid,'\n');
fclose(fid);

%hasModel = ones (nSegs, nModels);

end



%NUM_OF_MODELS = 4;                                   
%MAX_NUM_CONSTS_PER_MODEL= 17;
%MAX_NUM_CONSTS_PER_SEG = 20;
%MAX_NUM_CONSTS_GLOBAL = 3;
%MAX_NUM_VARS_PER_MODEL_PER_SEG = 7;
%MAX_NUM_VARS_PER_MODEL_ALL_SEGS = 6;
%MAX_NUM_VARS_ALL_MODELS_PER_SEG = 20;

%constant independently of pre-process
%ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
%ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
%ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
%ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};

%depend of pre-process
%ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'hh');
%ModelsFuncsNames(4,:) = strcat(ModelsFuncsNames(4,:), 'stim');
%ModelsFuncsNames(3,:) = strcat(ModelsFuncsNames(3,:), 'na');  
%ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'kv');
