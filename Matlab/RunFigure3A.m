%for i=1:38
timeFN = '..\..\..\Data\Times.dat';
NTrials=10;
for i=1:8
%     depth = 2^i;
%     if (depth == 32)
%         depth=31;
%     end
depth=i;
    changeNStimuliVS(i);
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
    Time = sort(Time);
    avgTime = mean([Time(NTrials/2-1),Time(NTrials/2),Time(NTrials/2+1)]);
    Times(i+1,:) = [i,avgTime];
    cd('../../../Matlab');
end
    