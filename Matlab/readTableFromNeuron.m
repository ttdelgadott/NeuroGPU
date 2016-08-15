function Table = readTableFromNeuron( FN )
Lines=getLines(FN)';
Lines = replaceAllStr(Lines,'1.#INF00000000000',num2str(1e23));
Lines2File(Lines(2:end-1),FN);
Table = dlmread(FN,' ');