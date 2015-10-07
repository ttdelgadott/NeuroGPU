function ExpandILPMacros(FN,OtherFNsWithMacroDefinitions,ILPn,OutFN)
% FN=fullfile(BaseP, 'VS','mainenCuda2','NeuronC','CudaStuff.cu');
% OtherFNs={fullfile(BaseP, 'VS','mainenCuda2','NeuronC','AllModels.cuh')};
% ILPn=2;
% OutFN=fullfile(BaseP, 'VS','mainenCuda2','NeuronC','CudaStuffExpanded.cu');

Lines=getLines(FN);
AllLines=Lines;
for i=1:numel(OtherFNsWithMacroDefinitions)
    AllLines=[AllLines getLines(OtherFNsWithMacroDefinitions{i})];
end
Calls=Lines(strhas(Lines,'SUPERILPMACRO('));
bla2=@(x) x{1}{1};
AllInMacros=setdiff(cellfun(bla2,regexp(Calls,'SUPERILPMACRO\((.*?)\)','tokens'),'UniformOutput',false),{'x'});
for i=1:numel(AllInMacros)
    CurLineI=find(cellNumel(regexp(AllLines,['#define.*' AllInMacros{i}])));
    
    CurLine=AllLines{CurLineI};
    BaseCommand=CurLine(strfind(CurLine,'VARILP)')+8:end);
    Expanded='';
    for j=1:ILPn
        Tmp=strrep(BaseCommand,' ## VARILP',num2str(j));
        Tmp=strrep(Tmp,'## VARILP',num2str(j));
        Expanded=[Expanded Tmp];
    end
    CurCallI=find(strhas(Lines,['SUPERILPMACRO\(' AllInMacros{i} '\)']));
    for j=1:numel(CurCallI)
    	Lines{CurCallI(j)}=[Lines{CurCallI(j)}(1:strfind(Lines{CurCallI(j)},'SUPERILPMACRO')-1) Expanded];
    end
end
putLines(OutFN,Lines);