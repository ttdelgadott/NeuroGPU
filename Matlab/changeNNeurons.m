function changeNNEurons(NNeurons)
FN = '..\VS\FiguresCode\NeuronC\Util.h';
fid=fopen(FN);
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);
Lines{56} = ['#define NNEURONS ',num2str(NNeurons)];
fid=fopen(FN,'w');
for i=1:numel(Lines)
    fprintf(fid,'%s\n',Lines{i});
end
fclose(fid);