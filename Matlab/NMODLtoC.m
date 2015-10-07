MODLFN='hhx.mod';
FNOut=[MODLFN(1:end-3) 'cpp'];
HFNOut=[MODLFN(1:end-3) 'h'];
FNOutCu=[MODLFN(1:end-3) 'cu.cpp'];

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
HandleNMODLDerivative; % CDerivLines
HandleNMODLBreakpoint; % CBreakLines
%%
% Update states by derivatives!
% Replace tokens?
%% Writing out files
fid=fopen(FNOut,'w');
fprintf(fid,'#include "hh.h"\n');
fprintf(fid,'#include <math.h>\n\n');

% for i=1:numel(CParamLines)
%     fprintf(fid,'%s\n',CParamLines{i});
% end
% fprintf(fid,'\n');

for i=1:numel(BeforeFirstLinesC)
    fprintf(fid,'%s\n',BeforeFirstLinesC{i});
end
fprintf(fid,'\n');

for i=1:numel(ProcDeclare)
    fprintf(fid,'%s\n',ProcDeclare{i});
end
fprintf(fid,'\n');

for i=1:numel(CFuncLines)
    for j=1:numel(CFuncLines{i})
        fprintf(fid,'%s\n',CFuncLines{i}{j});
    end
    fprintf(fid,'\n');
end

for i=1:numel(CInitLines)
    fprintf(fid,'%s\n',CInitLines{i});
end
fprintf(fid,'\n');

for i=1:numel(CProcLines)
    for j=1:numel(CProcLines{i})
        fprintf(fid,'%s\n',CProcLines{i}{j});
    end
    fprintf(fid,'\n');
end

for i=1:numel(CDerivLines)
    fprintf(fid,'%s\n',CDerivLines{i});
end
fprintf(fid,'\n');

for i=1:numel(CBreakLines)
    fprintf(fid,'%s\n',CBreakLines{i});
end
fprintf(fid,'\n');

fclose(fid);

%% H file
fid=fopen(HFNOut,'w');
fprintf(fid,'#ifndef __HH__\n#define __HH__\n\n');
AllParametersLine=strcat(AllParameters,'_');
AllParametersLine=strrep([AllParametersLine{:}],'_',' ');
fprintf(fid,'#define celsius 6.3\n',CallToBreak);
fprintf(fid,'#define ena 56\n',CallToBreak);
fprintf(fid,'#define ek -77\n\n',CallToBreak);

fprintf(fid,'// %s\n',AllParametersLine);
fprintf(fid,'#define NPARAMS %d\n',numel(AllParameters));
fprintf(fid,'#define NSTATES %d\n\n',numel(AllState));

fprintf(fid,'%s\n',BreakPointDeclare);
fprintf(fid,'%s\n',DerivDeclare);
fprintf(fid,'%s\n\n',InitDeclare);

fprintf(fid,'#define CALL_TO_INIT_STATES  %s\n\n',CallToInit);
fprintf(fid,'#define CALL_TO_DERIV  %s\n\n',CallToDeriv);
fprintf(fid,'#define CALL_TO_BREAK %s\n\n',CallToBreak);

fprintf(fid,'\n#endif');
fclose(fid);
%% Cu file
fid=fopen(FNOutCu,'w');
fprintf(fid,'#include "hh.h"\n');
fprintf(fid,'#include <math.h>\n\n');

% for i=1:numel(CParamLines)
%     fprintf(fid,'%s\n',CParamLines{i});
% end
% fprintf(fid,'\n');

% for i=1:numel(BeforeFirstLinesC)
%     fprintf(fid,'%s\n',BeforeFirstLinesC{i});
% end
% fprintf(fid,'\n');

for i=1:numel(ProcDeclareCu)
    fprintf(fid,'%s\n',ProcDeclareCu{i});
end
fprintf(fid,'\n');

for i=1:numel(CFuncLines)
    for j=1:numel(CFuncLines{i})
        fprintf(fid,'%s\n',CFuncLines{i}{j});
    end
    fprintf(fid,'\n');
end

for i=1:numel(CInitLinesCu)
    fprintf(fid,'%s\n',CInitLinesCu{i});
end
fprintf(fid,'\n');

for i=1:numel(CProcLines)
    for j=1:numel(CProcLines{i})
        fprintf(fid,'%s\n',CProcLines{i}{j});
    end
    fprintf(fid,'\n');
end

for i=1:numel(CDerivLines)
    fprintf(fid,'%s\n',CDerivLinesCu{i});
end
fprintf(fid,'\n');

for i=1:numel(CBreakLines)
    fprintf(fid,'%s\n',CBreakLines{i});
end
fprintf(fid,'\n');

fclose(fid);