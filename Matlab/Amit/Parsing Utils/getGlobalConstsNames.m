function constsNames = getGlobalConstsNames (mechNames)

def_fileTypeSuffix;
mechsNum = numel(mechNames);
for mechInd=1:mechsNum
   lines = getLines([mechNames{mechInd} C_SUFFIX]); 
   linesNum = numel(lines);
   lines = regexp(lines, '#define _ion_e\w*', 'match');
%    for lineInd=1:linesNum
%        
%    end
end
