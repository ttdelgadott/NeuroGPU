% DERIVATIVE states {  
%         rates(v)
%         m' =  (minf-m)/mtau
%         h' = (hinf-h)/htau
%         n' = (ninf-n)/ntau
% }

DerivLineI=find(strhas(Lines,'DERIVATIVE'));
StartL=DerivLineI;
EndL=min(EndLines(EndLines>DerivLineI));
CurLines=Lines((StartL+1):EndL);
FirstLine=['void DerivModel() {'];
TmpLines=strcat(regexprep(CurLines,'''','_d'),';');
CDerivLines=[FirstLine; TmpLines];