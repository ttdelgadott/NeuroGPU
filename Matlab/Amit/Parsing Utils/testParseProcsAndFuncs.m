clc;

fileName = 'kv';
suffix = 'kv';
def_fileTypeSuffix;

modLines = getLines([fileName NMODL_SUFFIX]);
parseDefVarsAndConsts (modLines, suffix);


% fileName = 'hh';
% suffix = 'HH';
% parseFunctionsAndProcedures(fileName, suffix);

% suffix = 'hh';

% MODLFN=[suffix '.c'];
% FNOut=['NrnCurrent_' MODLFN(1:end-1) 'm'];
% fid=fopen(MODLFN,'r');
% Lines=cell(0);
% while 1
%     tline = fgetl(fid);
%     if ~ischar(tline),   break,   end
%     Lines{end+1}=tline;
% end
% fclose(fid);
% 
% % for i=1:numel(Lines)
% %     disp (Lines{i});
% % end;
% 
% firstLine = ['function [sumCurrents sumConducts] = NrnCurrent_' suffix ...
%     ' (t, v, varsForThisModel, varsForAllModels, constsForThisModel, constsForAllModels)'];
% 
% Lines = getBlock('static double _nrn_current', Lines);
% 
% %delete everything prefacing the block.
% for i=1:numel(Lines)
%     openBracketInd = strfind(Lines{i},'{');
%     if (isempty(openBracketInd(1)))
%         continue;
%     end;
%     Lines{i} = Lines{i}(openBracketInd(1):end);
%     Lines = Lines(i:end);
%     break;
% end;
% 
% Lines=regexprep(Lines,'_current *\+= *','sumCurrents = sumCurrents + ')';
% Lines=regexprep(Lines,'_current *= *','sumCurrents = ')';
% %remove return statements, '{', '}', double, v=_v;
% Lines=regexprep(Lines,'return *(\w*);','')';
% Lines=regexprep(Lines,'{|}|double|v *= *_v *;','')';
% 
% numOfLines = numel(Lines);
% for i=1:numOfLines
%     if (~isempty(strfind(Lines{i},'sumCurrents')))
%         newLine = regexprep(Lines{i}, 'Currents', 'Conducts');
%         newLine = regexprep(newLine, '(\+ *)(i)(\w*)', '$1g$3');
%         Lines{end+1} = newLine;
%     end;
% end;
% 
% fileName = ['AmitModelConstsIndicesDef_' suffix '.m'];
% variableType = 'constsForThisModel';
% parseVariables;
% fileName = ['AmitModelVarsIndicesDef_' suffix '.m'];
% variableType = 'varsForThisModel';
% parseVariables;
% fileName = 'AmitCommonConstsIndicesDef.m';
% variableType = 'constsForAllModels';
% parseVariables;
% 
% %delete leading spaces and empty lines
% i = 1;
% while (i<=numel(Lines))
%     Lines{i} = strtrim(Lines{i});
%     if (isempty(Lines{i}))
%         Lines(i)=[];
%     else
%         i=i+1;
%     end;
% end;
% 
% fid=fopen(FNOut,'w');
% fprintf(fid,'%s\n',firstLine);
% fprintf(fid,'%s\n','AmitModelConstsIndicesDef_HH;');
% fprintf(fid,'%s\n','AmitModelVarsIndicesDef_HH;');
% fprintf(fid,'%s\n','AmitCommonConstsIndicesDef;');
% for i=1:numel(Lines)
%     fprintf(fid,'%s\n',Lines{i});
% end
% fprintf(fid,'\n');
% fclose(fid);
% 
% % lines = cell(0);
% %  lines{1} = '}{block {';
% %  lines{2} = 'bbbgfdbvvbcb';
% %  lines{3} = 'cccvf{g}fuytu}';
% % 
% % lines = getBlock('block', lines);
%  
% for i=1:numel(Lines)
%     disp (Lines{i});
% end;
% %disp(Lines);
