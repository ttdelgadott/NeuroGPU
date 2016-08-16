clearvars -except paramsFN VoltsFolder StimFN params BaseP FN_TopoList FN_Topo FN_TopoF FN_TopoMDL FN_TopoPP HocBaseFN ModFN ModMap ModelName availableMechanisms CurModI CallToInitC CallToDerivC CallToBreakC CallToBreakDvC BreakPointDeclareC DerivDeclareC InitDeclareC AllParametersC AllStateC ReadsC WritesC CParamLinesC CDerivLinesC CBreakLinesC CInitLinesC CProcLinesC GlobalParamBC ProcDeclareC ProcDeclareCuC CFuncLinesC CFuncLinesCuC LocalsC ParamStartVal StateStartVal AllParametersModelNameC NeuronSC AllAssignedC AllParametersNonGlobalC AllParametersGlobalC AllReadsNoReversals ExtraStatesTrg GGlobals Currents CInitLinesCuC CDerivLinesCuC CBreakLinesCuC CProcLinesCuC AllWrites stim Stim Sim paramSet currOptRunStr OutFN initParams copyToFileFlg Model
mkdir([BaseP 'Matlab' filesep 'CParsed' filesep]);
MODLFN=[BaseP 'Matlab' filesep 'CParsed' filesep ModelName '.mod'];
if(exist(MODLFN,'file'))
    delete(MODLFN);
end
copyfile([ModFN '.mod'],MODLFN,'f');
FNOut=[MODLFN(1:end-3) 'cpp'];
HFNOut=[MODLFN(1:end-3) 'h'];
FNOutCu=[MODLFN(1:end-3) 'cu.cpp'];

FTYPESTR='float';
%%
Lines=getLines(MODLFN);
Lines=removeCommentBlock(Lines);
EndLines=find(strhas(Lines,'}'));
OneBigLine=[Lines{:}];
StartIs=find(OneBigLine=='{');
EndIs=find(OneBigLine=='}');
%%
Writes=cell(0);
Reads=cell(0);
if(any(strhas(Lines,'USEION')))
    IONLine=Lines{strhas(Lines,'USEION')};
    Tmp=regexp(IONLine,'.*WRITE(.*)','tokens');
    if(~isempty(Tmp))
        Tmp2=regexp(Tmp{1},',','split');
        for i=1:numel(Tmp2{1})
            Writes{i}=regexprep(Tmp2{1}{i},'\W*','');
        end
    end
    Tmp=regexp(IONLine,'.*READ(.*)WRITE.*','tokens');
    if(~isempty(Tmp))
        Tmp2=regexp(Tmp{1},',','split');
        for i=1:numel(Tmp2{1})
            Reads{i}=regexprep(Tmp2{1}{i},'\W*','');
        end
    end
end
ReadsC{CurModI}=Reads;
WritesC{CurModI}=Writes;
HandleNMODLNeuron;
NeuronSC{CurModI}=NeuronS;
HandleNMODLAssigned; % CParamLines
AllStateC{CurModI}=AllState;
if(~exist('AllReadsNoReversals','var'))
    return;
end
%% FUNCTION
FunctionLines=find(strhas(Lines,'FUNCTION'));
nFuncs=numel(FunctionLines);
FFuncNames=cell(1,nFuncs);
CFuncLines=cell(1,nFuncs);
CFuncLinesCu=cell(1,nFuncs);
for i=1:nFuncs
    StartL=FunctionLines(i);
    EndL=StartL;
    SumP=0;
    while(1)
        SumP=SumP+sum(Lines{EndL}=='{')-sum(Lines{EndL}=='}');
        if(SumP==0)
            break;
        end
        EndL=EndL+1;
    end
    HandleNMODLFunction; % CFuncLines
end
%%
HandleNMODLProcedure; % CProcLines
HandleNMODLInitial; % CInitLines;
HandleNMODLDerivative; % CDerivLines
HandleNMODLBreakpoint; % CBreakLines
HandleNMODLKinetic;
AllAssignedC{CurModI}=AllAssigned;
%%
% Update states by derivatives!
% Replace tokens?
Src=[FuncNames{:} FFuncNames];
SrcCu=[Src, strcat('Cu',Src)];
Trg=strcat(Src,['_' ModelName]);
TrgCu=[strcat('Cu',Trg), strcat('Cu',Trg)];
BeforeFirstLinesC=AddModelNameToFunctions(BeforeFirstLinesC,Src,Trg);
ProcDeclare=AddModelNameToFunctions(ProcDeclare,Src,Trg);
ProcDeclareCu=AddModelNameToFunctions(ProcDeclareCu,Src,Trg);
for i=1:numel(CFuncLines)
    CFuncLines{i}=AddModelNameToFunctions(CFuncLines{i},Src,Trg);
end
for i=1:numel(CFuncLinesCu)
    CFuncLinesCu{i}=AddModelNameToFunctions(CFuncLinesCu{i},SrcCu,TrgCu);
end

CInitLines=AddModelNameToFunctions(CInitLines,Src,Trg);
CInitLinesCu=AddModelNameToFunctions(CInitLinesCu,SrcCu,TrgCu);
for i=1:numel(CProcLines)
    CProcLines{i}=AddModelNameToFunctions(CProcLines{i},Src,Trg);
    CProcLinesCu{i}=AddModelNameToFunctions(CProcLinesCu{i},SrcCu,TrgCu);
end
if ~isempty(CDerivLines)
    CDerivLines=AddModelNameToFunctions(CDerivLines,Src,Trg);
    CDerivLinesCu=AddModelNameToFunctions(CDerivLinesCu,SrcCu,TrgCu);
end
if ~isempty(CKineticLines)
    CKineticLines = AddModelNameToFunctions(CKineticLines,Src,Trg);
    CKineticLines = AddModelNameToFunctions(CKineticLines,SrcCu,TrgCu);
end
CBreakLines=AddModelNameToFunctions(CBreakLines,Src,Trg);
CBreakLinesCu=AddModelNameToFunctions(CBreakLinesCu,SrcCu,TrgCu);


Src=AllParameters;
Trg=strcat(AllParameters,['_' ModelName]);
AllParametersModelNameC{CurModI}=Trg;

AllParametersNonGlobalC{CurModI}=Trg(NonGlobalParamI);
AllParametersGlobalC{CurModI}=Trg(GlobalParamI);

CParamLines=AddModelNameToFunctions(CParamLines,Src,Trg);
if ~isempty(CDerivLines)
CDerivLines=AddModelNameToFunctions(CDerivLines,Src,Trg);
CDerivLinesCu=AddModelNameToFunctions(CDerivLinesCu,Src,Trg);
end
if ~isempty(CKineticLines)
CKineticLines=AddModelNameToFunctions(CKineticLines,Src,Trg);
CKineticLinesCu=AddModelNameToFunctions(CKineticLinesCu,Src,Trg);
end
CBreakLines=AddModelNameToFunctions(CBreakLines,Src,Trg);
CBreakLinesCu=AddModelNameToFunctions(CBreakLinesCu,Src,Trg);
CInitLines=AddModelNameToFunctions(CInitLines,Src,Trg);
CInitLinesCu=AddModelNameToFunctions(CInitLinesCu,Src,Trg);
ProcDeclare=AddModelNameToFunctions(ProcDeclare,Src,Trg);
ProcDeclareCu=AddModelNameToFunctions(ProcDeclareCu,Src,Trg);
for i=1:numel(CProcLines)
    CProcLines{i}=AddModelNameToFunctions(CProcLines{i},Src,Trg);
    CProcLinesCu{i}=AddModelNameToFunctions(CProcLinesCu{i},Src,Trg);
end
for i=1:numel(CFuncLines)
    CFuncLines{i}=AddModelNameToFunctions(CFuncLines{i},Src,Trg);
end
for i=1:numel(CFuncLinesCu)
    CFuncLinesCu{i}=AddModelNameToFunctions(CFuncLinesCu{i},Src,Trg);
end

BreakPointDeclare=AddModelNameToFunctions(BreakPointDeclare,Src,Trg);
if ~isempty(DerivDeclare)
    DerivDeclare=AddModelNameToFunctions(DerivDeclare,Src,Trg);
end
if ~isempty(DerivDeclare)
    DerivDeclare=AddModelNameToFunctions(DerivDeclare,Src,Trg);
end
InitDeclare=AddModelNameToFunctions(InitDeclare,Src,Trg);

ProcDeclareC{CurModI}=ProcDeclare;
ProcDeclareCuC{CurModI}=ProcDeclareCu;
CFuncLinesC{CurModI}=CFuncLines;
CFuncLinesCuC{CurModI}=CFuncLinesCu;
CParamLinesC{CurModI}=CParamLines;
CInitLinesC{CurModI}=CInitLines;
CInitLinesCuC{CurModI}=CInitLinesCu;
CProcLinesC{CurModI}=CProcLines;
CProcLinesCuC{CurModI}=CProcLinesCu;
CDerivLinesC{CurModI}=CDerivLines;
CDerivLinesCuC{CurModI}=CDerivLinesCu;
CBreakLinesC{CurModI}=CBreakLines;
CBreakLinesCuC{CurModI}=CBreakLinesCu;

CallToInitC{CurModI}=CallToInit;
CallToDerivC{CurModI}=CallToDeriv;
CallToBreakC{CurModI}=CallToBreak;
CallToBreakDvC{CurModI}=CallToBreakDv;

BreakPointDeclareC{CurModI}=BreakPointDeclare;
DerivDeclareC{CurModI}=DerivDeclare;
InitDeclareC{CurModI}=InitDeclare;

AllParametersC{CurModI}=AllParameters;
%% Writing out files
fid=fopen(FNOut,'w');
fprintf(fid,['#include "' ModelName '.h"\n']);
fprintf(fid,'#include <math.h>\n\n');

putLines(fid,CParamLines);

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
fprintf(fid,['#ifndef __' ModelName '__\n#define __' ModelName '__\n\n']);
AllParametersLine=strcat(AllParameters,'_');
AllParametersLine=strrep([AllParametersLine{:}],'_',' ');
fprintf(fid,'#define celsius 6.3\n');
fprintf(fid,'#define ena 56\n');
fprintf(fid,'#define ek -77\n\n');

fprintf(fid,'// %s\n',AllParametersLine);
fprintf(fid,'#define NPARAMS %d\n',numel(AllParameters));
fprintf(fid,'#define NSTATES %d\n\n',numel(AllState));

fprintf(fid,'%s\n',BreakPointDeclare);
if (~isempty (DerivDeclare))
fprintf(fid,'%s\n',DerivDeclare);
end
fprintf(fid,'%s\n\n',InitDeclare);

fprintf(fid,'#define CALL_TO_INIT_STATES  %s\n\n',CallToInit);
fprintf(fid,'#define CALL_TO_DERIV  %s\n\n',CallToDeriv);
fprintf(fid,'#define CALL_TO_BREAK %s\n\n',CallToBreak);
fprintf(fid,'#define CALL_TO_BREAK_DV %s\n\n',CallToBreakDv);

fprintf(fid,'\n#endif');
fclose(fid);
%% Cu file
fid=fopen(FNOutCu,'w');
fprintf(fid,'#include "hh.h"\n');
fprintf(fid,'#include <math.h>\n\n');

% putLines(fid,CParamLines);

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

for i=1:numel(CDerivLinesCu)
    fprintf(fid,'%s\n',CDerivLinesCu{i});
end
fprintf(fid,'\n');

for i=1:numel(CBreakLines)
    fprintf(fid,'%s\n',CBreakLines{i});
end
fprintf(fid,'\n');

fclose(fid);