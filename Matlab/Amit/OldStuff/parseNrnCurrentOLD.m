function parseNrnCurrent ()
clc;
parseSpecificNrnCurrent('hh', 'HH');
parseSpecificNrnCurrent('na', 'MainenNa');
parseSpecificNrnCurrent('kv', 'MainenKv');
parseSpecificNrnCurrent('stim', 'Stim');



function parseSpecificNrnCurrent (fileName, suffix)
isPointProcess = false;
isElectrodeCurrent = false;
MODLFN=[fileName '.mod'];
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);

Lines = getBlock('NEURON', Lines, '{', '}');
for i=1:numel(Lines)
   pointProcessInd = regexp(Lines{i}, 'POINT_PROCESS');
   ElectrodeCurrentInd = regexp(Lines{i}, 'ELECTRODE_CURRENT');
   remarksInd = regexp(Lines{i}, ':');
   if (~isempty(pointProcessInd))
      if (isempty(remarksInd) || pointProcessInd(1)<remarksInd(1))
          isPointProcess=true;
      end
   end
   if (~isempty(ElectrodeCurrentInd))
      if (isempty(remarksInd) || ElectrodeCurrentInd(1)<remarksInd(1))
          isElectrodeCurrent=true;
      end
   end
end

MODLFN=[fileName '.c'];
FNOut=['NrnCurrent_' suffix '.m'];
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    
    Lines{end+1}=tline;
end
fclose(fid);


% for i=1:numel(Lines)
%     disp (Lines{i});
% end;

firstLine = ['function [sumCurrents sumConducts] = NrnCurrent_' suffix ...
    ' (t, v, varsForThisModel, varsForAllModels, constsForThisModel, constsForAllModels)'];

Lines = getBlock('static double _nrn_current', Lines, '{', '}');
Lines = removeAtTimeFunc(Lines);
Lines = parseControlFlow(Lines, 1, 1, numel(Lines), numel(Lines{numel(Lines)}));

%delete everything prefacing the block.
for i=1:numel(Lines)
    openBracketInd = strfind(Lines{i},'{');
    if (isempty(openBracketInd(1)))
        continue;
    end;
    Lines{i} = Lines{i}(openBracketInd(1):end);
    Lines = Lines(i:end);
    break;
end;

if (isElectrodeCurrent)
    Lines=regexprep(Lines,'_current *\+= *','sumCurrents = sumCurrents - ')';
else
    Lines=regexprep(Lines,'_current *\+= *','sumCurrents = sumCurrents + ')';
end 
Lines=regexprep(Lines,'_current *= *','sumCurrents = ')';
%remove return statements, '{', '}', double, v=_v;
Lines=regexprep(Lines,'return *(\w*);','')';
Lines=regexprep(Lines,'{|}|double|v *= *_v *;','')';

%duplicate and convert the lines the calculate sumCurrrents to do so for
%sumConducts.
numOfLines = numel(Lines);
for i=1:numOfLines
    if (~isempty(strfind(Lines{i},'sumCurrents')))
        newLine = regexprep(Lines{i}, 'Currents', 'Conducts');
        newLine = regexprep(newLine, '(\+ *)(i)(\w*)', '$1g$3');
        Lines{end+1} = newLine;
    end;
end;
%if point process multiply in 100 and divide by area.
if (isPointProcess)
    Lines{end+1} = 'sumCurrents = sumCurrents*100/area;';
end

fileName = ['AmitModelConstsIndicesDef_' suffix '.m'];
variableType = 'constsForThisModel';
parseVariables;
fileName = ['AmitModelVarsIndicesDef_' suffix '.m'];
variableType = 'varsForThisModel';
parseVariables;
fileName = 'AmitCommonConstsIndicesDef.m';
variableType = 'constsForAllModels';
parseVariables;

%delete leading spaces and empty lines
i = 1;
while (i<=numel(Lines))
    Lines{i} = strtrim(Lines{i});
    if (isempty(Lines{i}))
        Lines(i)=[];
    else
        i=i+1;
    end;
end;

fid=fopen(FNOut,'w');
fprintf(fid,'%s\n',firstLine);
fprintf(fid,'%s\n',['AmitModelConstsIndicesDef_' suffix ';']);
fprintf(fid,'%s\n',['AmitModelVarsIndicesDef_' suffix ';']);
fprintf(fid,'%s\n','AmitCommonConstsIndicesDef;');
for i=1:numel(Lines)
    fprintf(fid,'%s\n',Lines{i});
end
fprintf(fid,'\n');
fclose(fid);

% lines = cell(0);                  %QWERTY
%  lines{1} = '}{block {';
%  lines{2} = 'bbbgfdbvvbcb';
%  lines{3} = 'cccvf{g}fuytu}';
% 
% lines = getBlock('block', lines);
 
% for i=1:numel(Lines)
%     disp (Lines{i});
% end;
% %disp(Lines);
