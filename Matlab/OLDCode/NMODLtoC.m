MODLFN='hh.mod';
FNOut=[MODLFN(1:end-3) 'c'];

FTYPESTR='float';
%%
fid=fopen(MODLFN,'r');
Lines=cell(0);
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    Lines{end+1}=tline;
end
fclose(fid);
%%
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
Lines=regexprep(Lines,' *= *','=')';
EndLines=find(strcmp(Lines,'}'));
%% FUNCTION
FunctionLines=find(strhas(Lines,'FUNCTION'));
for i=1:numel(FunctionLines)
    StartL=FunctionLines(i);
    EndL=min(EndLines(EndLines>StartL));
    HandleNMODLFunction; % CFuncLines
end
%%
HandleNMODLAssigned; % CParamLines
HandleNMODLNeuron;

HandleNMODLProcedure; % CProcLines
HandleNMODLInitial; % CInitLines;
HandleNMODLDerivative; % DerivLineI
HandleNMODLBreakpoint; % CBreakLines
%%
Update states by derivatives!
Replace tokens?
%% Writing out files
fid=fopen(FNOut,'w');
fprintf(fid,'#include "blabalbal.h"\n\n');
for i=1:numel(CParamLines)
    fprintf(fid,'%s\n',CParamLines{i});
end
fclose(fid);