% function FNWithParam=AddTopologyToHoc(FN)
% FN='C:\SVN\Neuron\printCell\Amit\printCellBinaryK64Base.hoc';
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
AddedLines{end+1}=['fn.wopen("' FN_ParamM '")'];
for i=1:numel(Reversals)
    AddedLines{end+1}=['access ' CompNames{RepComp(i)}(2:end)];
    AddedLines{end+1}=['a=' Reversals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
for i=1:numel(GGlobals)
    AddedLines{end+1}=['a=' GGlobals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
for i=1:numel(NGlobals)
    AddedLines{end+1}=['a=' NGlobals{i}];
    AddedLines{end+1}='fn.vwrite(&a)';
end
for c=1:numel(CompNames)
    F=find(ismember(availableMechanisms, CompMechnisms{c}));
    AddedLines{end+1}=['access ' CompNames{c}(2:end)];
%     if(ismember('pas',CompMechnisms{c}))
%         AddedLines{end+1}=['a=g_pas'];
%         AddedLines{end+1}='fn.vwrite(&a)';
%         AddedLines{end+1}=['a=e_pas'];
%         AddedLines{end+1}='fn.vwrite(&a)';
%     end
    for m=1:numel(F)
        CurMechParams=AllParametersNonGlobalC{F(m)};
        for p=1:numel(CurMechParams)
            AddedLines{end+1}=['a=' CurMechParams{p}];
            AddedLines{end+1}='fn.vwrite(&a)';
        end
    end
end
AddedLines{end+1}='fn.close()';
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
CompTopologyMap = zeros(1,numel(CompNames));
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
            if(~isempty(Tmp))
                ParamM(compInd, ParamStartI(F(m))+p) = Tmp;
            end
        end
    end
end
fclose(fid);