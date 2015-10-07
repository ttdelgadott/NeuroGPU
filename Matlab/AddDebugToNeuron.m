format long g
clc;
FTYPESTR = 'float';
NeuroGPUInit;
%paramsToPrint = {'m_na','h_na','gbar_na','tha_na','qa_na','Ra_na','Rb_na','thi1_na','thi2_na','qi_na','thinf_na','qinf_na','Rg_na','Rd_na'};
%paramsToPrint = {'m_ca','h_ca'};
paramsToPrint = {'v(0.5)'};
HocBaseFN=fullfile(BaseP, 'Neuron','Mainen','FullTest','runNoStim.hoc');
FNWithDebug=[HocBaseFN(1:end-4) '_Debug.hoc'];
debugFN = fullfile(BaseP, 'Neuron','printCell','Amit','output','Debug.csv');
debugFN=strrep(debugFN,'\','/');

AddLinesInitial = cell(0);
AddLinesInitial{1} = 'objref dbg';
AddLinesInitial{2} = 'dbg = new File()';
AddLinesInitial{3} = ['dbg.wopen("' debugFN '")'];
Lines=getLines(HocBaseFN);
fadvanceLine = 123;
currLine = Lines{fadvanceLine};
while(true)
   if(strhas(currLine,'fadvance'))
       break;
   end
    fadvanceLine = fadvanceLine+1;
    currLine = Lines{fadvanceLine};
end
formatA = '"';
vars = '';
for i = 1:numel(paramsToPrint)
    formatA = [formatA, '%1.15f,'];
    vars = [vars ,paramsToPrint{i},','];
end
debugLine = ['dbg.printf(',formatA(1:end-1),'\n",',vars(1:end-1),')'];
OutLines=[AddLinesInitial(1:end)'; Lines(1:fadvanceLine)';];% debugLine';]% Lines((fadvanceLine+1):end);'dbg.fclose()'];
OutLines{end+1} =  'forall{';
OutLines{end+1} =  'dbg.printf("%s,",secname())';
OutLines{end+1} =  debugLine;
OutLines{end+1} =  '}';

OutLines = [OutLines; Lines((fadvanceLine+1):end)'];
OutLines{end+1} =  'dbg.close()';
Lines2File(OutLines,FNWithDebug);
[HocP, HocN, Ext]=fileparts(FNWithDebug);
cd(HocP);
RunHoc(FNWithDebug);
cd([BaseP 'Matlab']);

%debugMat = csvread(debugFN,0,1,[0 1 3400 1]);
debugMat = csvread(debugFN,0,1);

%%OUTPUT to C
debugPerSeg = [];
for i = 1:(size(debugMat,1)/size(Neuron.NSegsMat,1))-1
    for ii = 1:size(Neuron.NSegsMat,1)
        comp = CompTopologyMap(ii);
        %temp(Neuron.SegStart(comp):Neuron.SegEnd(comp))=debugMat(i*size(Neuron.NSegsMat,1)+ii);
        temp = repmat(debugMat(i*size(Neuron.NSegsMat,1)+ii,:),Neuron.NSegsMat(comp),1);
        
    end
    debugPerSeg = [debugPerSeg; temp'];
     
end
fid = fopen('../Data/VForC.dat','w');
%fid = fopen('../Data/StatesForC.dat','w');

numberOfParams = length(debugPerSeg);
%fwrite(fid,numberOfParams,'uint16');
debugPerSeg = debugPerSeg';
fwrite(fid,debugPerSeg,FTYPESTR);


