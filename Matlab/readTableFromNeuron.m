function Table = readTableFromNeuron( FN )
Lines=getLines(FN)';
Lines2File(Lines(2:end-1),FN);
Table = dlmread(FN,' ');