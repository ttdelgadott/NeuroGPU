%Store new matlab file name in FNOut
MODLFN='na.c';
FNOut=['AmitNrnCurrent_' MODLFN(1:end-1) 'm'];

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
%FirstLineI=find(strhas(Lines,'static double _nrn_current'));    %QWERTY - think of a better string to look for?




for i=FirstLineI:numel(Lines)
    openCurlyBrackets = strfind(Lines(i),'{');
    if (~isempty(openCurlyBrackets))
        foundFirstCurlyBracket = true;
        closeCurlyBrackets = strfind(Lines(i),'}');
        for j=1:numel(openCurlyBrackets)
        break;
    end;
end;
while (~foundFirstCurlyBracket)
isEmptyStack = false;
while 
find 

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

