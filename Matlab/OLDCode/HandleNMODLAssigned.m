AssignedLine=find(strhas(Lines,'ASSIGNED'));
StartL=AssignedLine;
EndL=min(EndLines(EndLines>StartL));
TmpLines=regexprep(Lines((StartL+1):(EndL-1)),'\(.*\)',' ');
ToksC= regexp(TmpLines,'\s*','split');
Toks=[ToksC{:}];
AllAssigned=Toks(cellNumel(Toks)>0)';

StateLine=find(strhas(Lines,'STATE'));
StartL=StateLine;
EndL=min(EndLines(EndLines>StartL));
TmpLines=regexprep(Lines((StartL+1):(EndL-1)),'\(.*\)',' ');
ToksC= regexp(TmpLines,'\s*','split');
Toks=[ToksC{:}];
AllState=Toks(cellNumel(Toks)>0)';


AssignedLine=find(strhas(Lines,'PARAMETER'));
StartL=AssignedLine;
EndL=min(EndLines(EndLines>StartL));
TmpLines=regexprep(Lines((StartL+1):(EndL-1)),'\(.*\)',' ');
TmpLines=regexprep(TmpLines,'<.*>',' ');
TmpLines=regexprep(TmpLines,'\s*','');
TmpLines=TmpLines(strhas(TmpLines,'='));
AllParameters=cell(1,numel(TmpLines));
CParamLines=cell(numel(TmpLines),1);
for i=1:numel(TmpLines)
    AllParameters{i}=strtok(TmpLines{i},'=');
    CParamLines{i}=[FTYPESTR ' ' TmpLines{i} ';'];
end