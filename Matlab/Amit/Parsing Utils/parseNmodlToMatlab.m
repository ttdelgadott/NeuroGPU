%DOCUMENTATION_REF_008D
function [isWritingCai]= parseNmodlToMatlab (fullfileName, ppInSegments, ...
    numOfSegs, varValueMap, compSegsIndexArr)
%Function Name: parseNmodlToMatlab
%INPUT: file name
%OUTPUT: No output. parse the .mod and .c with the file name to the needed 
%matlab function/scripts.
def_fileTypeSuffix;
def_generalMatlabStr;
NeuroGPUInit;

%modAndCPath = [BaseP 'Matlab\Amit\models\'];   old-replaced suffix based
%mapping to ModMap of gilad. fileName is now a complete path.

%find the a non-seprator string after a seprator at the end of the string.
toks = regexp(fullfileName, '[\\/]([^\\/]*)$', 'tokens');
fileName = char(toks{1});
cFileLines = getLines([fullfileName C_SUFFIX]);
modFileLines = getLines([fullfileName NMODL_SUFFIX]);
modFileLines = removeCommentBlock(modFileLines);

[suffix isElectrodeCurrent isPointProcess, isWritingCai] = ...
    getNeuronBlockData(modFileLines, fileName);
%A struct containing all the var and consts names by types (e.g. consts per
%model per segment)
varsAndConstsNames = parseDefVarsAndConsts (modFileLines, suffix, isElectrodeCurrent);

%% get the num of vars and consts for this model (it is needed for parsing
%the NrnInitModel
% defFilesPrefixes={DEF_CONSTS_PER_MODEL_PER_SEG, DEF_CONSTS_PER_MODEL_ALL_SEGS, ...
%     DEF_VARS_PER_MODEL_PER_SEG, DEF_VARS_PER_MODEL_ALL_SEGS};  
clear Tmp
DefFilesPath = [BaseP 'Matlab\Amit\Parsing Utils\Parsed Funcs\'];
Tmp(1)=getNumOfVarsFromDefFile([DefFilesPath DEF_CONSTS_PER_MODEL_PER_SEG fileName '.m']);
Tmp(2)=getNumOfVarsFromDefFile([DefFilesPath DEF_CONSTS_PER_MODEL_ALL_SEGS fileName '.m']);
Tmp(3)=getNumOfVarsFromDefFile([DefFilesPath DEF_VARS_PER_MODEL_PER_SEG fileName '.m']);
Tmp(4)=getNumOfVarsFromDefFile([DefFilesPath DEF_VARS_PER_MODEL_ALL_SEGS fileName '.m']);

% for i=1:numel(defFilesPrefixes)
%         Tmp(i)=getNumOfVarsFromDefFile([defFilesPrefixes{i} fileName '.m']);
%     end
% end

numConstsPerModelPerSeg = Tmp(1);
numConstsPerModelAllSeg = Tmp(2);
numVarsPerModelPerSeg = Tmp(3);
numVarsPerModelAllSegs = Tmp(4);
%%

parseNrnInitmodelNewWithCellArrs(modFileLines, suffix, isPointProcess,...
    ppInSegments, numOfSegs, numConstsPerModelPerSeg, numConstsPerModelAllSeg, ...
    numVarsPerModelPerSeg, numVarsPerModelAllSegs, varValueMap, ...
    varsAndConstsNames, compSegsIndexArr);
parseNrnCurrent(cFileLines, suffix, isElectrodeCurrent, isPointProcess);
parseNrnStates(modFileLines, cFileLines, suffix);
parseFunctionsAndProcedures(modFileLines, suffix);

function [suffix isElectrodeCurrent isPointProcess isWritingCai] = ...
    getNeuronBlockData (modLines, fileName)
def_neuronBlockStr;
def_generalNmodlStr;

isElectrodeCurrent = false;
isPointProcess = false;
suffix = fileName;
isWritingCai = false;

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
   %if this line contain "WRITE...cai" than we are writing cai.
   writeCaiInd = regexp(neuronLines{i}, 'WRITE.*\<cai\>', 'ONCE');
   if (~isempty(writeCaiInd))
       isWritingCai = true;
   end;
end

