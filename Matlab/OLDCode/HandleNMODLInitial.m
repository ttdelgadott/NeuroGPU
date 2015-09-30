% INITIAL {
% 	rates(v)
% 	m = minf
% 	h = hinf
% 	n = ninf
% }

InitialLineI=find(strhas(Lines,'INITIAL'));
StartL=InitialLineI;
EndL=min(EndLines(EndLines>InitialLineI));
CurLines=Lines((StartL+1):EndL);
FirstLine=['void InitModel() {'];
TmpLines=strcat(CurLines,';');
CInitLines=[FirstLine; TmpLines];