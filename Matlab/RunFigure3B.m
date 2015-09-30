%for i=1:38
timeFN = '..\..\..\Data\Times.dat';
NTrials=10;
%for i=0:20
for i=4:10
    fourteenMul = i*14
    for nneurons = (fourteenMul-2):1:(fourteenMul+2)
    if(i>3)
        NTrials =1;
    end
   % nneurons = 2^i;
   %nneurons=i;
    changeNNeurons(nneurons);
    cd ('..\VS\FiguresCode');
%pause(1);
    system('msbuild CN.sln');
%pause(1);
    cd ('.\Debug');
    SumTime=0;
    Time=zeros(1,NTrials);
    for trials = 1:NTrials
        system('fig2.exe');
        fidT = fopen(timeFN);
        ILP = fread(fidT, 1, 'uint16');
        Time(trials) = fread(fidT, 1, 'double');
        fclose(fidT);
        pause(1);
    end
    
    if(NTrials>1)
   Time = sort(Time);
   avgTime = mean([Time(NTrials/2-1),Time(NTrials/2),Time(NTrials/2+1)]);
   Times(nneurons,:) = [nneurons,avgTime];
    else
   Times(nneurons,:) = [nneurons,Time(1)];
    end
    cd('../../../Matlab');
    end
end
    