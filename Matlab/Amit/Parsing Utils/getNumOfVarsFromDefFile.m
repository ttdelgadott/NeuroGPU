function numOfVars = getNumOfVarsFromDefFile( fileName )

lines = getLines(fileName);
numOfVars = 0;

%varLineString - for example: "gk_index = 1;"
varLineExpression = '.*_index *= *.*;';
numOfLines = numel(lines);
for i=1:numOfLines
   if  regexp(lines{i}, varLineExpression, 'once')
       numOfVars = numOfVars + 1;
   end
end

end

