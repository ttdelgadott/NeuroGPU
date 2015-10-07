function parseHocFile( hocFileName )
%Parse the hoc file (assuming all the required mechanisms are in the same 
%folder) to the .m files needed for main to run. 
%   Detailed explanation goes here
NeuroGPUInit;
cd (fullfile(BaseP,'Neuron','printCell','Amit'));
AddTopoToHoc (hocFileName);
if(filesep=='/')
    system(['nrniv ' hocFileName(1:end-4)  '_topo.hoc']);
else
    RunHoc([hocFileName(1:end-4)  '_topo.hoc']);
    %eval(['!' hocFileName(1:end-4)  '_topo.hoc']);
    pause(4);   %wait 7 seconds for hoc file to finish, need to replace this with something more intelligent
    system('taskkill /im nrniv.exe');  %kill nrniv so the CSV files can be opened
end
cd (fullfile(BaseP,'Matlab','Amit','Parsing Utils','Parsed Funcs'));
regexprep(hocFileName, '.hoc *$', '_topo.hoc');

%get all the hoc files lines without comments
hocFileLines = getLines(hocFileName);
hocFileLines = deleteOneLineComments(hocFileLines, '//');
hocFileLines = deleteBlockComments(hocFileLines, '/*', '*/');

% % % %get all the mechanisms names
% % % LL=regexp(hocFileLines,'\s*insert\s*(\S+).*','tokens');
% % % Tmp=cat(1,LL{:});
% % % availableMechanisms=unique(cat(1,Tmp{:}));
% % % IC=sum(cellNumel(regexp(hocFileLines,'IClamp')));
% % % isThereStimMech = false;
% % % if(IC>0)
% % %     availableMechanisms{end+1}='stim';
% % %     isThereStimMech = true;
% % % end

% get all the segments of the compartments
fidTopo = fopen([BaseP,'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64T.csv']);      
nSegsMat = getNsegsMat(fidTopo);
fclose(fidTopo);
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
compMechs = getCompMechs ([BaseP,'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64MDL.csv']);

% %not suffcient to get all the mechanisms names since we don't always use
% %the 'insert' statement.
% LL=regexp(hocFileLines,'\s*insert\s*(\S+).*','tokens');
% Tmp=cat(1,LL{:});
% availableMechanisms=unique(cat(1,Tmp{:}));

NeuroGPUInit;
fullHocFileName=fullfile(hocFileName);
ModMap=ConnectMechanismsToModFiles(fullHocFileName);
%get all the availableMechanisms - new (doesn't include point-processes)
availableMechanisms = compMechs{1,1};
for compInd=2:numOfCompartments
    availableMechanisms = union(availableMechanisms, compMechs{1, compInd});
end
IC=sum(cellNumel(regexp(hocFileLines,'IClamp')));
isThereStimMech = false;
if(IC>0)
    availableMechanisms{end+1}='stim';
    isThereStimMech = true;
end

%if there is a stim mechanism than need to indicate that the neuron doesn't
%have the model but in the specific segments.
if (isThereStimMech)
    %stim is always the last mechanism.
    %outputLines{end+1} = ['hasModel(:,' int2str(numOfMechanisms) ') = 0;'];
    fidPP = fopen([BaseP,'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64PP.csv']);  
    ppInSegments = getPpInSegments(nSegsMat, fidPP, compSegsIndexArr);
    fclose(fidPP);
end

%get the file names of the mechinisms using ModMap

availableMechsWithoutStim = setdiff(availableMechanisms, {'stim'});
numOfMechanismsWithoutStim = numel(availableMechsWithoutStim);
availableMechanismsFileNames = cell(1,numOfMechanismsWithoutStim);

for i=1:numOfMechanismsWithoutStim
    availableMechanismsFileNames{i} = ModMap.(availableMechsWithoutStim{i});
end
%Stim mod file has no suffix. that's why it need special consideration.
if (numOfMechanismsWithoutStim~= numel(availableMechanisms))
    NrnPath;
    stimPath = [NrnP 'stim'];
   availableMechanismsFileNames{end+1} = stimPath;
end
numOfMechanisms = numel(availableMechanismsFileNames);

globalFileName = ['..' filesep '..' filesep '..' filesep '..' filesep 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64GLOBAL.csv'];
fid = fopen(globalFileName);
globalCellArr = textscan(fid,'%s %*s %f');
fclose(fid);
mdlFileName = ['..' filesep '..' filesep '..' filesep '..' filesep 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep '64MDL.csv'];
fid = fopen(mdlFileName);
mdlCellArr = textscan(fid,'%s %*s %f');
fclose(fid);

%create a map of all the initialization values of all the consts and vars
%in neuron from the global and mdl file based arrays.
varValueMap = getVarValueMap(globalCellArr, mdlCellArr);

%if any model is writing cai we need to calculate eca every time step. if
%not we need to relay on Nueron's constants
isAnyModelWritingCai = false;
%parse all the mechnisms model files to matlab files.
for i=1:numOfMechanisms
    isWritingCai = parseNmodlToMatlab (availableMechanismsFileNames{i}, ...
        ppInSegments, numOfSegs, varValueMap, compSegsIndexArr);
    if (isWritingCai)
        isAnyModelWritingCai = true;
    end;
end;

def_generalMatlabStr;
defFilesPrefixes={DEF_CONSTS_PER_MODEL_PER_SEG, DEF_CONSTS_PER_MODEL_ALL_SEGS, ...
    DEF_VARS_PER_MODEL_PER_SEG, DEF_VARS_PER_MODEL_ALL_SEGS};
clear Tmp
for i=1:numel(defFilesPrefixes)
    for j=1:numOfMechanisms
        Tmp(i,j)=getNumOfVarsFromDefFile([defFilesPrefixes{i} availableMechanisms{j} '.m']);
    end
end

for i=1:numOfMechanisms
    numConstsPerModelPerSeg(i) = Tmp(1,i);
    numConstsPerModelAllSeg(i) = Tmp(2,i);
    numVarsPerModelPerSeg(i) = Tmp(3,i);
    numVarsPerModelAllSegs(i) = Tmp(4,i);
end
MAX_NUM_CONSTS_PER_SEG = 20;
maxConstsGlobal = 11;
%MAX_NUM_VARS_ALL_MODELS_PER_SEG = 20;

%get all the fork locations in the neuron dendrites.
% matrixLines = cell(0);
% fid = fopen('neurogpu/Neuron/printCell/Amit/output/64F.csv');
% line = fgetl(fid);
% while (ischar(line) && isempty(strfind(line, 'dend')))
%     matrixLines{end+1} = line;
%     line = fgetl(fid);
% end
% numOfLines = numel(matrixLines);
% numOfSegs = numOfLines;
% forkSegments = [];
% for i=1:numOfLines
%    vars(1,:) = sscanf(matrixLines{i},'%f %f %f %f %f');
%    if (vars(5)==0)
%        forkSegments = [forkSegments; i];
%    end
% end


def_generalMatlabStr;
outputLines = cell(0);
outputLines{end+1} = ['IS_ANY_MODEL_WRITING_CAI = ' int2str(isAnyModelWritingCai) ';'];
outputLines{end+1} = ['NUM_OF_MODELS = ' int2str(numOfMechanisms) ';'];
outputLines{end+1} = ['NUM_OF_SEGS = ' int2str(numOfSegs) ';'];
for i=1:numOfMechanisms
    
    outputLines{end+2} = ['%Num of variables and consts for the No. '...
        int2str(i) ' model.'];
    outputLines{end+1} = ['MAX_NUM_CONSTS_PER_MODEL(' int2str(i)...
        ') = ' int2str(numConstsPerModelAllSeg(i)) ';'];
    outputLines{end+1} = ['MAX_NUM_VARS_PER_MODEL_PER_SEG(' int2str(i) ...
        ') = ' int2str(numVarsPerModelPerSeg(i)) ';'];
    outputLines{end+1} = ['MAX_NUM_VARS_PER_MODEL_ALL_SEGS(' int2str(i) ...
        ') = ' int2str(numVarsPerModelAllSegs(i)) ';'];
end

outputLines{end+1} = ['MAX_NUM_CONSTS_GLOBAL = ' int2str(maxConstsGlobal) ';'];


outputLines{end+2} = 'ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);';
outputLines{end+1} = 'ModelsFuncsNames(:, INIT_INDEX) = {''NrnInitModel_''};';
outputLines{end+1} = 'ModelsFuncsNames(:, CURRENT_INDEX) = {''NrnCurrent_''};';
outputLines{end+1} = 'ModelsFuncsNames(:, STATES_INDEX) = {''NrnStates_''};';

for i=1:numOfMechanisms
    outputLines{end+1} = ['ModelsFuncsNames(' int2str(i) ',:) = strcat(ModelsFuncsNames('...
         int2str(i) ',:), ''' availableMechanisms{i} ''');'];
end


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
    for mechInd = 1:numOfMechsForThisComp
        TF = strcmp (thisCompMechs{mechInd}, availableMechanisms);
        wantedMechInd = find(TF,1,'first');
        outputLines{end+1} = ['    hasModel(segInd, ' int2str(wantedMechInd) ') = 1;'];
        outputLines{end+1} = ['    hasModel(segInd, ' int2str(wantedMechInd) ') = 1;'];
    end
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

fileNameOut = 'hocFileData.m';
fid=fopen(fileNameOut,'w');
numOfLines = numel(outputLines);
for i=1:numOfLines
    fprintf(fid,'%s\n',outputLines{i});
end
fprintf(fid,'\n');
fclose(fid);

fclose('all');
end

