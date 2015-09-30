%DOCUMENTATION_REF_008D
function parseNmodlToMatlab2(fileName, ppInSegments, numOfSegs, ModMap)
%Function Name: parseNmodlToMatlab
%INPUT: file name
%OUTPUT: No output. parse the .mod and .c with the file name to the needed 
%matlab function/scripts.
def_fileTypeSuffix;
def_generalMatlabStr;
def_generalNmodlStr;

CurFN=ModMap.(fileName);
if(exist([CurFN C_SUFFIX]))
    cFileLines = getLines([CurFN C_SUFFIX]);
else
    [TmpP TmpN]=fileparts(CurFN);
    cFileLines = getLines([TmpP filesep 'x86_64' filesep TmpN C_SUFFIX]);
end
modFileLines = getLines([CurFN NMODL_SUFFIX]);
modFileLines=removeCommentBlock(modFileLines);
modFileLines=deleteComments(modFileLines, COMMENT_MOD_STR);

[suffix isElectrodeCurrent isPointProcess] = getNeuronBlockData(modFileLines, fileName);

parseDefVarsAndConsts (modFileLines, suffix, isElectrodeCurrent); 

%% get the num of vars and consts for this model (it is needed for parsing
%the NrnInitModel
% defFilesPrefixes={DEF_CONSTS_PER_MODEL_PER_SEG, DEF_CONSTS_PER_MODEL_ALL_SEGS, ...
%     DEF_VARS_PER_MODEL_PER_SEG, DEF_VARS_PER_MODEL_ALL_SEGS};  
clear Tmp
Tmp(1)=getNumOfVarsFromDefFile([DEF_CONSTS_PER_MODEL_PER_SEG fileName '.m']);
Tmp(2)=getNumOfVarsFromDefFile([DEF_CONSTS_PER_MODEL_ALL_SEGS fileName '.m']);
Tmp(3)=getNumOfVarsFromDefFile([DEF_VARS_PER_MODEL_PER_SEG fileName '.m']);
Tmp(4)=getNumOfVarsFromDefFile([DEF_VARS_PER_MODEL_ALL_SEGS fileName '.m']);

% for i=1:numel(defFilesPrefixes)
%         Tmp(i)=getNumOfVarsFromDefFile([defFilesPrefixes{i} fileName '.m']);
%     end
% end

numConstsPerModelPerSeg = Tmp(1);
numConstsPerModelAllSeg = Tmp(2);
numVarsPerModelPerSeg = Tmp(3);
numVarsPerModelAllSegs = Tmp(4);
%%

parseNrnInitmodel(modFileLines, suffix, isPointProcess, ppInSegments, numOfSegs,...
    numConstsPerModelPerSeg, numConstsPerModelAllSeg, ...
    numVarsPerModelPerSeg, numVarsPerModelAllSegs);
parseNrnCurrent(cFileLines, suffix, isElectrodeCurrent, isPointProcess);
parseNrnStates(modFileLines, cFileLines, suffix);
parseFunctionsAndProcedures(modFileLines, suffix);

function [suffix isElectrodeCurrent isPointProcess] = ...
    getNeuronBlockData (modLines, fileName)
def_neuronBlockStr;
def_generalNmodlStr;

isElectrodeCurrent = false;
isPointProcess = false;
suffix = fileName;

neuronLines = getBlock(NEURON_STR, modLines, OPEN_BLOCK_MOD_STR, CLOSE_BLOCK_MOD_STR);
for i=1:numel(neuronLines)
   pointProcessInd = regexp(neuronLines{i}, POINT_PROCESS_STR, 'ONCE');
   electrodeCurrentInd = regexp(neuronLines{i}, ELECTRODE_CURRENT_STR, 'ONCE');
   suffixInd = regexp(neuronLines{i},SUFFIX_STR, 'ONCE');
   commentsInd = regexp(neuronLines{i}, COMMENT_MOD_STR);
   %if found the POINT_PROCESS string in this line
   if (~isempty(pointProcessInd))
       %and if the string is before a remark string (meaning it's not
       %remarked)
      if (isempty(commentsInd) || pointProcessInd(1)<commentsInd(1))
          isPointProcess=true;
      end
   end
   %exactly the same as the point process conditions.
   if (~isempty(electrodeCurrentInd))
      if (isempty(commentsInd) || electrodeCurrentInd(1)<commentsInd(1))
          isElectrodeCurrent=true;
      end
   end
   %if SUFFIX string is in this line
   if (~isempty(suffixInd))
       if (isempty(commentsInd) || suffixInd(1)<commentsInd(1))
          suffix = regexp(neuronLines{i}, [SUFFIX_STR ' *(\w*)'], 'match', 'once');
          suffix = regexprep(suffix, [SUFFIX_STR ' *(\w*)'], '$1');
      end
   end
end

