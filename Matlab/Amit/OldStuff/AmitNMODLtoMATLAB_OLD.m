%Store new matlab file name in FNOut
MODLFN='hh.mod';
FNOut=[MODLFN(1:end-3) 'm'];

%%
%read original file (as string) to fid and copies line by line to Lines.
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);
%%
%removed all the remarks from the Lines array (":"operator in NMODL)
%and create an array of GoodLines - indicating which line is empty QWERTY
GoodLine=ones(1,numel(Lines))>0;
for i=1:numel(Lines)
    F=find(Lines{i}==':');
    if(~isempty(F))
        Lines{i}=Lines{i}(1:(F(1)-1));
    end
    if(isempty(Lines{i}))
        GoodLine(i)=false;
    end
end
Lines=Lines(GoodLine);

%removes redundant spaces before and after "=" operator?    QWERTY
Lines=regexprep(Lines,' *= *','=')';
%find end of blocks?    QWERTY
EndLines=find(strcmp(Lines,'}'));

%initialize 2 arrays: StratL indicate the start line of function and EndL
%the end of function
FunctionLines=find(strhas(Lines,'FUNCTION'));
for i=1:numel(FunctionLines)
    StartL=FunctionLines(i);
    EndL=min(EndLines(EndLines>StartL));
    HandleNMODLFunction; % CFuncLines
end

