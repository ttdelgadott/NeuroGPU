% function FNWithParam=AddTopologyToHoc(FN)
% FN='C:\SVN\Neuron\printCell\Amit\printCellBinaryK64Base.hoc';
function ProcAddParamToHocForOpt(AllParametersNonGlobalC,HocBaseFN,BaseP,availableMechanisms,NeuronSC,Reversals,CompNames,CompMechnisms,GGlobals,NGlobals,Neuron,FTYPESTR,pSizeSet,paramSet)
ParamStartI=[0 cumsum(cellNumel(AllParametersNonGlobalC(1:end)))];

FN=HocBaseFN;
FNWithTopo=[FN(1:end-4) '_topo.hoc'];
FNWithParam=[FN(1:end-4) '_param.hoc'];
FN_ParamM=[BaseP 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep 'ParamM.dat'];
FN_ParamM=strrep(FN_ParamM,'\','/');
FN_Mat=[BaseP 'Neuron' filesep 'printCell' filesep 'Amit' filesep 'output' filesep 'Mat.dat'];
FN_Mat=strrep(FN_Mat,'\','/');
Lines=getLines(FNWithTopo)';
AddLineI=find(strhas(Lines,'End point processess mechanisms output'));
if(numel(AddLineI)~=1)
    error('Problem with finding place to add code: End point processess mechanisms output');
end
if exist('pSizeSet','var')
     Lines{18} = [Lines{18}(1:7),num2str(pSizeSet)];
end
NSets = str2num(Lines{18}(8:end));
Nt = str2num(Lines{15}(12:end));
if exist('paramSet','var')
     Lines{12} = [Lines{12}(1:16),paramSet,'"'];
end


ParamName = Lines{12}(17:end-5);
%NSets = 5;
%%
clear RepComp
for CurModI=1:numel(availableMechanisms)
    ReversalsC{CurModI}=NeuronSC{CurModI}.Reversals;
end
for i=1:numel(Reversals)
    FoundRepComp=false;
    while(~FoundRepComp)
        for c=1:numel(CompNames)
            CurMechF=find(ismember(availableMechanisms,CompMechnisms{c}));
            Tmp=ReversalsC(CurMechF);
            CurReversals={};
            for j = 1:numel(Tmp)
                currTmp = Tmp{j};
                for jj = 1:numel(currTmp)
                    CurReversals{end+1} =  currTmp{jj};
                end
            end
            
            if(ismember(Reversals{i},CurReversals))
                RepComp(i)=c;
                FoundRepComp=true;
                break;
            end
        end
    end
end
%%
AddedLines=cell(0);
AddedLines{1}='// Start params output';
AddedLines{end+1}='proc writeReversals(){';
for i=1:numel(Reversals)
    AddedLines{end+1}=['access ' CompNames{RepComp(i)}(2:end)];
    AddedLines{end+1}=['a=' Reversals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
AddedLines{end+1}='}';
AddedLines{end+1}='proc writeGGlobals(){';
for i=1:numel(GGlobals)
    AddedLines{end+1}=['a=' GGlobals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
AddedLines{end+1}='}';

AddedLines{end+1}='proc writeNGlobals(){';
for i=1:numel(NGlobals)
    AddedLines{end+1}=['a=' NGlobals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
AddedLines{end+1}='}';
funcsIndex = size(AddedLines,2);
AddedLines{end+1}='proc printParams(){';
AddedLines{end+1}=['fn.wopen("' FN_ParamM '")'];
AddedLines{end+1}='writeReversals()';
AddedLines{end+1}='writeGGlobals()';
AddedLines{end+1}='writeNGlobals()';
AddedLines{end+1}='for (ii=0;ii<pmat.nrow();ii+=1){';
AddedLines{end+1}='transvec = pmat.getrow(ii)';
AddedLines{end+1}='tfunc()';
AddedLines{end+1}='finitialize()';
procCounter = 0;
counter =0;
funcs={};
funcName = ['proc',num2str(procCounter),'()'];
AddedLines{end+1}= funcName;
funcs{end+1} = ['proc ', funcName,'{'];
for c=1:numel(CompNames)
    if(counter>50)
        funcs{end+1} = '}';
        procCounter = procCounter+1;
        counter=0;
        funcName = ['proc',num2str(procCounter),'()'];
        AddedLines{end+1} = funcName;
        funcs{end+1} = ['proc ', funcName,'{'];
    end
    F=find(ismember(availableMechanisms, CompMechnisms{c}));
    funcs{end+1}=['access ' CompNames{c}(2:end)];
    counter = counter+1;
%     if(ismember('pas',CompMechnisms{c}))
%         AddedLines{end+1}=['a=g_pas'];
%         AddedLines{end+1}='fn.vwrite(&a)';
%         AddedLines{end+1}=['a=e_pas'];
%         AddedLines{end+1}='fn.vwrite(&a)';
%     end
    for m=1:numel(F)
        CurMechParams=AllParametersNonGlobalC{F(m)};
        for p=1:numel(CurMechParams)
            funcs{end+1}=['a=' CurMechParams{p}];
            funcs{end+1}='fn.vwrite(&a)';
            counter = counter+2;
        end
    end
end
if(counter>0)
        funcs{end+1} = '}';    
end
AddedLines = [AddedLines(1:funcsIndex),funcs,AddedLines(funcsIndex+1:end)];
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='}';
AddedLines{end+1} = 'printParams()';
AddedLines{end+1}='// End params output';
AddedLines{end+1}='// Start Mat Output';
AddedLines{end+1}='fcurrent()';
AddedLines{end+1}=['hoc_stdout("',FN_Mat ,'")'];
AddedLines{end+1}='MyPrintMatrix()';
AddedLines{end+1}='hoc_stdout()';
AddedLines{end+1}='// endMat Output';
OutLines=[Lines(1:AddLineI); AddedLines'; Lines((AddLineI+1):end)];

Lines2File(OutLines,FNWithParam);
%%
[HocP, HocN, Ext]=fileparts(FNWithParam);
cd(HocP);
RunHoc(FNWithParam);
cd([BaseP 'Matlab']);
%%
clear ReversalsV GGlobalsV NGlobalsV ParamM
fid=fopen(FN_ParamM,'rb');
for i=1:numel(Reversals)
    ReversalsV(i) = fread(fid, 1, 'float64');
end
for i=1:numel(GGlobals)
    GGlobalsV(i) = fread(fid, 1, 'float64');
end
for i=1:numel(NGlobals)
    NGlobalsV(i) = fread(fid, 1, 'float64');
end

% for c=1:numel(CompNames)
%     F=find(ismember(availableMechanisms, CompMechnisms{c}));
%     for m=1:numel(F)
%         CurMechParams=AllParametersNonGlobalC{F(m)};
%         for p=1:numel(CurMechParams)
%             ParamM(c, ParamStartI(F(m))+p) = fread(fid, 1, 'float64');
%         end
%     end
% end
clear AllParams;
CompTopologyMap = zeros(1,numel(CompNames));
for kk=1:NSets
    for c=1:numel(CompNames)
        compName = CompNames{c};
        compInd = getCompIndex(Neuron.Types,compName(2:end));
        CompTopologyMap(c)=compInd;
        F=find(ismember(availableMechanisms, CompMechnisms{c}));
    %     if(ismember('pas',CompMechnisms{c}))
    %         ParamM(compInd, ParamStartI(end)+1) = fread(fid, 1, 'float64');
    %         ParamM(compInd, ParamStartI(end)+2) = fread(fid, 1, 'float64');
    %     end
        for m=1:numel(F)
            CurMechParams=AllParametersNonGlobalC{F(m)};
            for p=1:numel(CurMechParams)
                Tmp=fread(fid, 1, 'float64');
                ParamM(compInd, ParamStartI(F(m))+p) = Tmp;
            end
        end
    end
tmp = reshape(ParamM,size(ParamM,1)*size(ParamM,2),1);
AllParams(:,kk) = tmp;
ParamM=[];
end
fclose(fid);
AllParams = reshape(AllParams,size(AllParams,1)*size(AllParams,2),1);
fid = fopen ('../Data/AllParams.dat','w');
fwrite(fid,NSets,'uint16');
fwrite(fid,AllParams,FTYPESTR);
fclose(fid);
