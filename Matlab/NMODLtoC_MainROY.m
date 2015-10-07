% NMODL explanations: http://www.anc.ed.ac.uk/school/neuron/tutorial/tutD.html

% The PARAMETER block specifies variables that:
% are not changed as a result of the calculations in the mechanism;
% are (generally) constant throughout time; and
% can be changed by the user from the hoc interface or the GUI
% mul_b_m

% The ASSIGNED block declares variables that are either:
% calculated by the mechanism itself or computed by NEURON.
% local I think

% The STATE block declares state variables. One type of state variable are 
% the variables that we are trying to solve for in kinetic schemes.
% m_ca

% The GLOBAL statement specifies variables that are always the same for the mechanism.
% q10_ca

% The RANGE statement makes the following variables visible to the NEURON interpreter 
% and specifies that they are be functions of position. 
% For example, the maximum channel conductance should be a RANGE variable, 
% since it can be different at different points on a neuron.
% RANGE minf, hinf, mtau, htau
% minf_ca

% The USEION statement specifies what ions this channel mechanism uses.
% There are three ions NEURON knows about, na, k, ca, however, others may
% also be defined via this statement. NEURON can keep track of the intracellular
% and extracellular concentrations of each ion. (Typically, these are actually
% concentrations in small shells around either side of the membrane.)
% Dealing with ions is difficult, because more than one mechanism may affect
% a particular ion. For example, we may have more than one calcium channel mechanism.
% Therefore, when dealing with ions use exactly the same name used in all other mechanisms.
% The READ modifier lists ionic variables needed in calculating the ionic
% channel current (usually the equilibrium potential, or concentration).
% The WRITE modifier lists what ionic variables are calculated in this mechanism (usually the current).
% In our example we use:
% USEION ca READ eca WRITE ica
% eca not! eca_ca
% ica not! ica_ca

% globals : all-over globals:
% celsius dt stoprun clamp_resist secondorder t
%%
% clear variables;
clc;
NeuroGPUInit;
FN_Topo=fullfile(BaseP, 'Neuron','printCell','Amit','output','64T.csv');
FN_TopoF=fullfile(BaseP, 'Neuron','printCell','Amit','output','64F.csv');
FN_TopoPP=fullfile(BaseP, 'Neuron','printCell','Amit','output','64PP.csv');
FN_TopoMDL=fullfile(BaseP, 'Neuron','printCell','Amit','output','64MDL.csv');
%HocBaseFN=[BaseP 'Neuron\Mainen\test3\runModel.hoc'];
% HocBaseFN=[BaseP 'Neuron\printCell\ForC\knacaonly\knacatrials.hoc'];
%HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','k','ktrials.hoc');
HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','kcaonly','kcaonly.hoc');

%%
availableMechanisms=getMechanismsFromMDLFile(FN_TopoMDL);
availableMechanisms=setdiff(availableMechanisms,'stim');
ModMap=ConnectMechanismsToModFiles(HocBaseFN);

GGlobals={'celsius' 'stoprun' 'clamp_resist' 'secondorder'};
%%
ParamStartVal=0;
StateStartVal=0;
clear AllReadsNoReversals
warning('off','MATLAB:MKDIR:DirectoryExists');
for CurModI=1:numel(availableMechanisms)
    ModelName=availableMechanisms{CurModI};
    ModFN=ModMap.(ModelName);
    NMODLtoC2;
end
%
for CurModI=1:numel(availableMechanisms)
    IonsC{CurModI}=[{NeuronSC{CurModI}.UseIon.name}];
    NGlobalC{CurModI}=strcat(NeuronSC{CurModI}.Global,['_' NeuronSC{CurModI}.Suffix]);
    ReadsC{CurModI}=NeuronSC{CurModI}.Read;
    WritesC{CurModI}=NeuronSC{CurModI}.Writes;
    OnlyReadsC{CurModI}=setdiff(ReadsC{CurModI},WritesC{CurModI});    
end
Ions=unique([IonsC{:}]);
Currents=strcat('i',Ions);
Reversals=strcat('e',Ions);
NGlobals=[NGlobalC{:}];
AllReads=unique([ReadsC{:}]);
AllReadsNoReversals=setdiff(AllReads,Reversals);
AllWrites=unique([WritesC{:}]);
for CurModI=1:numel(availableMechanisms)
    OnlyReadsNoReversalsC{CurModI}=setdiff(OnlyReadsC{CurModI},Reversals);
end
nBasicStates=sum(cellNumel(AllStateC));
nExtraStates=numel(AllReadsNoReversals);
if (nExtraStates == 0)
    ExtraStatesTrg={};
else
    ExtraStatesTrg=strcat(strcat('StatesM[',num2str(((1:nExtraStates)-1+nBasicStates)')),']');
    ExtraStatesTrg=mat2cell(ExtraStatesTrg,ones(1,nExtraStates),size(ExtraStatesTrg,2));
end
%%
ParamStartVal=0;
StateStartVal=0;
for CurModI=1:numel(availableMechanisms)
    ModelName=availableMechanisms{CurModI};
    ModFN=ModMap.(ModelName);
    NMODLtoC2;
    ParamStartVal=ParamStartVal+numel(NonGlobalParamI);
    StateStartVal=StateStartVal+numel(AllStateC{CurModI});
end
%
for CurModI=1:numel(availableMechanisms)
    IonsC{CurModI}=[{NeuronSC{CurModI}.UseIon.name}];
    NGlobalC{CurModI}=strcat(NeuronSC{CurModI}.Global,['_' NeuronSC{CurModI}.Suffix]);
    ReadsC{CurModI}=NeuronSC{CurModI}.Read;
    WritesC{CurModI}=NeuronSC{CurModI}.Writes;
    OnlyReadsC{CurModI}=setdiff(ReadsC{CurModI},WritesC{CurModI});    
end
Ions=unique([IonsC{:}]);
Reversals=strcat('e',Ions);
NGlobals=[NGlobalC{:}];
AllReads=unique([ReadsC{:}]);
AllReadsNoReversals=setdiff(AllReads,Reversals);
AllWrites=unique([WritesC{:}]);
for CurModI=1:numel(availableMechanisms)
    OnlyReadsNoReversalsC{CurModI}=setdiff(OnlyReadsC{CurModI},Reversals);
end
nBasicStates=sum(cellNumel(AllStateC));
nExtraStates=numel(AllReadsNoReversals);
if(nExtraStates==0)
    ExtraStatesTrg={};
else
    ExtraStatesTrg=strcat(strcat('StatesM[',num2str(((1:nExtraStates)-1+nBasicStates)')),']');
    ExtraStatesTrg=mat2cell(ExtraStatesTrg,ones(1,nExtraStates),size(ExtraStatesTrg,2));
end
nTotalStates=nBasicStates+nExtraStates;
%% get Parameters
[CompMechnisms CompNames CompLinesPerMech]=getCompMechs2(FN_TopoMDL);

bla2=@(x) x{1}{1};
blax=@(x) bla2(regexp(x,'.*?_(.*) =.*','tokens'));

ParamsFromNEURON=unique(regexprep(cellfun(bla2,regexp(cat(1,CompLinesPerMech{:}),'\W*(.*)\W*=.*','tokens'),'UniformOutput',false),'\W*',''));
%
ParamsFromMods=unique([AllParametersModelNameC{:}]);
AllParametersNonGlobal=[AllParametersNonGlobalC{:}];
nParams=numel(AllParametersNonGlobal);
setdiff(ParamsFromMods,ParamsFromNEURON) %!!!!!!!!!!!
AllParametersGlobal=[AllParametersGlobalC{:}];
ParamStartI=[0 cumsum(cellNumel(AllParametersNonGlobalC(1:end-1)))];
AddParamToHoc;
%% C file
fid=fopen(fullfile(BaseP, 'Matlab','CParsed','AllModels.cpp'),'w');

fprintf(fid,'#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include "AllModels.h"\n\n');

fprintf(fid,'// Universals:\n#define PI (3.1415927f)\n#define R (8.31441f)\n#define FARADAY (96485.309f)\n\n');

if(~isempty(Reversals))
    fprintf(fid,'// Reversals:\n');
    for i=1:numel(Reversals)
        fprintf(fid,['#define ' Reversals{i} ' (' num2str(ReversalsV(i),'%.5f') 'f)\n']);
%         fprintf(fid,['const ' FTYPESTR ' ' Reversals{i} ' = ' num2str(ReversalsV(i)) 'f;\n']);
    end
end

% fprintf(fid,'// GGlobals\n');
% for i=1:numel(GGlobals)
%     fprintf(fid,['const float ' GGlobals{i} ' = ' num2str(GGlobalsV(i)) 'f;\n']);
% end
% fprintf(fid,'\n');

% Locals=unique([LocalsC{:}]);
Locals=unique(cat(1,LocalsC{:}));
if(~isempty(Locals))
    fprintf(fid,'\n// Locals:\n');
    Tmp=strcat(setdiff(Locals,union(Reversals,Currents)),',');
    Tmp=[Tmp{:}];
    fprintf(fid,[FTYPESTR ' ' Tmp(1:end-1) ';\n']);
end
fprintf(fid,'\n// Ion currents as Locals:\n');
Tmp=strcat(Currents,',');
Tmp=[Tmp{:}];
fprintf(fid,[FTYPESTR ' ' Tmp(1:end-1) ';\n']);

fprintf(fid,'\n// Globals:\n');
putLines(fid,CParamLinesC);
fprintf(fid,'\n// Declarations:\n');
putLines(fid,ProcDeclareC);
fprintf(fid,'\n// Functions:\n');
putLines(fid,CFuncLinesC);
fprintf(fid,'\n// Inits:\n');
putLines(fid,ReplacePow(CInitLinesC));
fprintf(fid,'\n// Procedures:\n');
putLines(fid,ReplacePow(CProcLinesC));
fprintf(fid,'\n// Derivs:\n');
putLines(fid,ReplacePow(CDerivLinesC));
fprintf(fid,'\n// Breakpoints:\n');
putLines(fid,ReplacePow(CBreakLinesC));

fclose(fid);
% H file
fid=fopen([BaseP 'Matlab/CParsed/AllModels.h'],'w');
fprintf(fid,['#ifndef __' 'ALLMODELS' '__\n#define __' 'ALLMODELS' '__\n\n']);

% #define BasicConst_FN "..\\..\\..\\Data\\BasicConst"
% #define BasicConstP_FN "..\\..\\..\\Data\\BasicConst"
% #define ParamsMat_FN "..\\..\\..\\Data\\ParamsM"
% #define Stim_FN "..\\..\\..\\Data\\Stim"
% #define Sim_FN "..\\..\\..\\Data\\Sim"

fprintf(fid,['#define NSTATES ' num2str(nTotalStates) '\n']);
fprintf(fid,['#define NPARAMS ' num2str(nParams) '\n\n']);

fprintf(fid,'// GGlobals\n');
% for i=1:numel(GGlobals)
%     fprintf(fid,['const float ' GGlobals{i} ' = ' num2str(GGlobalsV(i)) 'f;\n']);
% end
for i=1:numel(GGlobals)
    fprintf(fid,['#define ' GGlobals{i} ' (' num2str(GGlobalsV(i)) ')\n']);
end
fprintf(fid,'\n');

for CurModI=1:numel(availableMechanisms)
    fprintf(fid,'%s\n',BreakPointDeclareC{CurModI});
    fprintf(fid,'%s\n',DerivDeclareC{CurModI});
    fprintf(fid,'%s\n\n',InitDeclareC{CurModI});
end
callToInitStr='';
callToDerivStr='';
callToBreakStr ='';
callToBreakDVStr='';
for modInd = 1:numel(CallToInitC)
    callToInitStr=[callToInitStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]){%s}',modInd-1,CallToInitC{modInd})];
    callToDerivStr=[callToDerivStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]){%s}',modInd-1,CallToDerivC{modInd})];
    callToBreakStr=[callToBreakStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]){%s}',modInd-1,CallToBreakC{modInd})];
    callToBreakDVStr=[callToBreakDVStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]){%s}',modInd-1,CallToBreakDvC{modInd})];
end
fprintf(fid,'#define CALL_TO_INIT_STATES  %s\n\n',callToInitStr);
fprintf(fid,'#define CALL_TO_DERIV  %s\n\n',callToDerivStr);
fprintf(fid,'#define CALL_TO_BREAK %s\n\n',callToBreakStr);
fprintf(fid,'#define CALL_TO_BREAK_DV %s\n\n',callToBreakDVStr);

fprintf(fid,'\n#endif*************************************************');
fclose(fid);
%% CU file
fid=fopen(fullfile(BaseP, 'Matlab','CParsed','AllModels.cu'),'w');

fprintf(fid,'#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include "cuda_runtime.h"\n#include "device_launch_parameters.h"\n#include "AllModels.cuh"\n\n');

fprintf(fid,'// Universals:\n#define PI (3.1415927f)\n#define R (8.31441f)\n#define FARADAY (96485.309f)\n\n');

% fprintf(fid,'// Universals:\nconst float PI=3.1415927;\nconst float R=8.31441;\nconst float FARADAY=96485.309;\n\n');

% if(~isempty(Reversals))
%     fprintf(fid,'// Reversals:\n');
%     for i=1:numel(Reversals)    
%         fprintf(fid,['const ' FTYPESTR ' ' Reversals{i} ' = ' num2str(ReversalsV(i)) 'f;\n']);
%     end
% end

fprintf(fid,'// GGlobals\n');
% for i=1:numel(GGlobals)
%     fprintf(fid,['const float ' GGlobals{i} ' = ' num2str(GGlobalsV(i)) 'f;\n']);
% end
for i=1:numel(GGlobals)
    fprintf(fid,['#define ' GGlobals{i} ' (' num2str(GGlobalsV(i),'%.5f') ')\n']);
end
fprintf(fid,'\n');

% Locals=unique([LocalsC{:}]);
% if(~isempty(Locals))
%     fprintf(fid,'\n// Locals:\n');
%     Tmp=strcat(setdiff(Locals,union(Reversals,Currents)),',');
%     Tmp=[Tmp{:}];
%     fprintf(fid,[FTYPESTR ' ' Tmp(1:end-1) ';\n']);
% end

% fprintf(fid,'\n// Ion currents as Locals:\n');
% Tmp=strcat(Currents,',');
% Tmp=[Tmp{:}];
% fprintf(fid,[FTYPESTR ' ' Tmp(1:end-1) ';\n']);

if(~isempty(Reversals))
    fprintf(fid,'// Reversals:\n');
    for i=1:numel(Reversals)
        fprintf(fid,['#define ' Reversals{i} ' (' num2str(ReversalsV(i),'%.5f') 'f)\n']);
%         fprintf(fid,['const ' FTYPESTR ' ' Reversals{i} ' = ' num2str(ReversalsV(i)) 'f;\n']);
    end
end

for i=1:numel(CParamLinesC)
    CParamLinesCuC{i}=CParamLinesC{i}(strhas(CParamLinesC{i},'='));
end
fprintf(fid,'\n// Globals:\n');
putLines(fid,gstrcat('__device__ ',CParamLinesCuC));
fprintf(fid,'\n// Declarations:\n');
putLines(fid,ProcDeclareCuC);
fprintf(fid,'\n// Functions:\n');
putLines(fid,CFuncLinesCuC);
fprintf(fid,'\n// Procedures:\n');
putLines(fid,ReplacePowf(CProcLinesCuC));
fprintf(fid,'\n// Inits:\n');
putLines(fid,ReplacePowf(CInitLinesCuC));
fprintf(fid,'\n// Derivs:\n');
putLines(fid,ReplacePowf(CDerivLinesCuC));
fprintf(fid,'\n// Breakpoints:\n');
putLines(fid,ReplacePowf(CBreakLinesCuC));

fclose(fid);
%% H file
fid=fopen(fullfile(BaseP, 'Matlab','CParsed','AllModels.h'),'w');
fprintf(fid,['#ifndef __' 'ALLMODELS' '__\n#define __' 'ALLMODELS' '__\n\n']);

% #define BasicConst_FN "..\\..\\..\\Data\\BasicConst"
% #define BasicConstP_FN "..\\..\\..\\Data\\BasicConst"
% #define ParamsMat_FN "..\\..\\..\\Data\\ParamsM"
% #define Stim_FN "..\\..\\..\\Data\\Stim"
% #define Sim_FN "..\\..\\..\\Data\\Sim"

fprintf(fid,['#define NSTATES ' num2str(nTotalStates) '\n']);
fprintf(fid,['#define NPARAMS ' num2str(nParams) '\n\n']);

fprintf(fid,'// GGlobals\n');
% for i=1:numel(GGlobals)
%     fprintf(fid,['const float ' GGlobals{i} ' = ' num2str(GGlobalsV(i)) 'f;\n']);
% end
for i=1:numel(GGlobals)
    fprintf(fid,['#define ' GGlobals{i} ' (' num2str(GGlobalsV(i)) ')\n']);
end
fprintf(fid,'\n');

for CurModI=1:numel(availableMechanisms)
    fprintf(fid,'%s\n',BreakPointDeclareC{CurModI});
    fprintf(fid,'%s\n',DerivDeclareC{CurModI});
    fprintf(fid,'%s\n\n',InitDeclareC{CurModI});
end
%RBS STart
callToInitStr='';
callToDerivStr='';
callToBreakStr ='';
callToBreakDVStr='';
for modInd = 1:numel(CallToInitC)
    callToInitStr=[callToInitStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]==1){%s}',modInd-1,CallToInitC{modInd})];
    callToDerivStr=[callToDerivStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]==1){%s}',modInd-1,CallToDerivC{modInd})];
    callToBreakStr=[callToBreakStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]==1){%s}',modInd-1,CallToBreakC{modInd})];
    callToBreakDVStr=[callToBreakDVStr,sprintf(' if(TheMMat.boolModel[seg+%d*TheMMat.N]==1){%s}',modInd-1,CallToBreakDvC{modInd})];
end
callToInitStrC = strrep(callToInitStr,'ParamsM','ParamsMSerial');
callToDerivStrC = strrep(callToDerivStr,'ParamsM','ParamsMSerial');
callToBreakStrC = strrep(callToBreakStr,'ParamsM','ParamsMSerial');
callToBreakDVStrC = strrep(callToBreakDVStr,'ParamsM','ParamsMSerial');
fprintf(fid,'#define CALL_TO_INIT_STATES  %s\n\n',callToInitStrC);
fprintf(fid,'#define CALL_TO_DERIV  %s\n\n',callToDerivStrC);
fprintf(fid,'#define CALL_TO_BREAK %s\n\n',callToBreakStrC);
fprintf(fid,'#define CALL_TO_BREAK_DV %s\n\n',callToBreakDVStrC);
%RBS END
fprintf(fid,'\n#endif');
fclose(fid);
%% CUH file
[fid,messeage]=fopen(fullfile(BaseP, 'Matlab','CParsed','AllModels.cuh'),'w');
fprintf(fid,['#ifndef __' 'ALLMODELSCU' '__\n#define __' 'ALLMODELSCU' '__\n\n']);
fprintf(fid,'#include "cuda_runtime.h"\n#include "device_launch_parameters.h"\n\n');
% #define BasicConst_FN "..\\..\\..\\Data\\BasicConst"
% #define BasicConstP_FN "..\\..\\..\\Data\\BasicConst"
% #define ParamsMat_FN "..\\..\\..\\Data\\ParamsM"
% #define Stim_FN "..\\..\\..\\Data\\Stim"
% #define Sim_FN "..\\..\\..\\Data\\Sim"

for CurModI=1:numel(availableMechanisms)
    fprintf(fid,'%s\n',[CInitLinesCuC{CurModI}{1}(1:end-1) ';']);
    fprintf(fid,'%s\n',[CDerivLinesCuC{CurModI}{1}(1:end-1) ';']);
    fprintf(fid,'%s\n',[CBreakLinesCuC{CurModI}{1}(1:end-1) ';']);
end
%RBS
ReplaceForCUH;
SetParamsForCUH;
SetStatesForCUH;

fprintf(fid,'\n\n#define  SET_STATES(VARILP) %s;\n',StateSetStr);
fprintf(fid,'#define SET_PARAMS(VARILP) MYFTYPE %s;%s\n\n',declareStr(1:end-1),parmeterSetStr);
fprintf(fid,'\n\n#define CALL_TO_CU_INIT_STATES(VARILP)  %s\n\n',callToInitStrCU);
fprintf(fid,'#define CALL_TO_CU_DERIV(VARILP)  %s\n\n',callToDerivStrCU);
fprintf(fid,'#define CALL_TO_CU_BREAK(VARILP) %s\n\n',callToBreakStrCU);
fprintf(fid,'#define CALL_TO_CU_BREAK_DV(VARILP) %s\n\n',callToBreakDVStrCU);

fprintf(fid,'\n#endif');
fclose(fid);
%%
%Amit - Main
NeuroGPUInit
cd([BaseP 'Matlab']);
% addpath(genpath('./Amit/'));
%%
%%DOCUMENTATION_REF_001
%Indices for all the mechanism funcs throughout the program.
%(global - not ideal, could use function that return the value instead)
global INIT_INDEX 
global CURRENT_INDEX
global STATES_INDEX
INIT_INDEX= 1;
CURRENT_INDEX = 2;
STATES_INDEX = 3;
global NUM_OF_FUNCS_PER_MODEL
NUM_OF_FUNCS_PER_MODEL = 3;

hocFileData;
%%
[Neuron Sim Stim] = ReadKForkTopology2(FN_Topo);

fidFmatrix = FN_TopoF;
hasF=true;

if(hasF)
    [Mats Traces] = AmitReadFmatrixForkHH(fidFmatrix,Neuron); % Traces cannot be 4D exactly when different NSegs
end
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
if(hasF)
    save('realcell','Neuron', 'Sim', 'Stim','Mats', 'Traces');
else
    save('realcell','Neuron', 'Sim', 'Stim');
end

%%DOCUMENTATION_REF_003
numOfSegs = sum(Neuron.NSegsMat);
varsPerModelPerSeg = zeros(numOfSegs, NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_PER_SEG);
varsPerModelAllSegs = zeros (NUM_OF_MODELS, MAX_NUM_VARS_PER_MODEL_ALL_SEGS);
constsPerModelAllSegs = zeros(NUM_OF_MODELS, MAX_NUM_CONSTS_PER_MODEL);
constsAllModelsAllSegs = zeros(1, MAX_NUM_CONSTS_GLOBAL);
%%
% load('realcell');
Neuron.HasHH=AmitGetHHsegs(Neuron); 
GetBoolModel; 
Neuron.HasHH=boolModel;
%Stim.loc = 2;
%Stim.amp=5;
[OurMat Table]= createMatrixAsNEURONNew(Neuron);
% Table = squeeze(Mats(:,2:4,1));
% OurMat = TableToMatrix(Table,Neuron);
%Stim.loc=9;
Nx = length(OurMat);
%Traces=Traces(2:end,:,:,:);
cmVec = createCmvec(Neuron.Cms,Neuron.NSegs);
%This is not working on a single compt cellat,Nx,Neuron.NSegsMat, Neuron.Parent,cmVec);

[FN FNP FNM Aux]=CreatAuxiliaryData3(rot90(OurMat,2),Nx,fliplr(Neuron.NSegsMat'), numel(Neuron.NSegs)+1-fliplr(Neuron.Parent),Neuron,cmVec);
%%
disp('Finished writing AllModels.h,cpp,cu');

paramsMPerSeg = [];
for i = 1:size(ParamM,1)
     temp = repmat(ParamM(i,:),Neuron.NSegsMat(i),1);
     paramsMPerSeg = [paramsMPerSeg; temp];
end

fidParamsM=fopen(['..' filesep 'Data' filesep 'ParamsMForC.mat'],'wb');
fwrite(fidParamsM,paramsMPerSeg,'float32');
fclose(fidParamsM);
%%Stuff for debuging
NRHS=squeeze(Mats(:,5,:));
NRHSStim = NRHS(2,:);

