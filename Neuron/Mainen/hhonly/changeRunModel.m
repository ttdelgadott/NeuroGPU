function changeRunModel(arr)
FN = './runModel.hoc';
fid=fopen(FN);
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);
Lines{2} = ['modelFile = "./' arr{1} '"'];
Lines{3} = ['timesFile = "./' arr{2} '"'];
Lines{4} = ['paramsFile = "./' arr{3} '"'];
Lines{5} = ['stimFile = "./' arr{4} '"'];
Lines{6} = ['outFile = "./' arr{5} '"'];
Lines{7} = ['ntimestep =' num2str(arr{6})];
Lines{8} = ['nparams =' num2str(arr{8})];
Lines{9} = ['psize =' num2str(arr{7})];
Lines{10} = ['ntraces =' num2str(arr{9})];

fid=fopen(FN,'w');
for i=1:numel(Lines)
    fprintf(fid,'%s\n',Lines{i});
end
fclose(fid);