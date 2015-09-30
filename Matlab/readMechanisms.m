% function  [names values]=readMechanisms(fn,comp,mech)
fn='../Neuron\MultiModels/Output/64MDL.csv';
fid = fopen(fn);
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
LinesX=Lines(cellfun(@isempty,regexp(Lines,'_ion')))';
fclose(fid);
AA=regexp(LinesX,'#');
CompLines=find(~cellfun(@isempty,AA));
CompEnds=[CompLines(2:end)'-1 numel(LinesX)];
for i=1:numel(CompLines)
    bla2=@(x) x{1}{1};
    blax=@(x) bla2(regexp(x,'.*?_(.*) =.*','tokens'));
    CurCompLines=LinesX(CompLines(i)+1:CompEnds(i));
    [U IA IB]=unique(cellfun(blax,CurCompLines,'UniformOutput',false));
    CompMechnisms{i}=U;
end

 