% BREAKPOINT {
%         SOLVE states METHOD cnexp
%         gna = gnabar*m*m*m*h
% 	ina = gna*(v - ena)
%         gk = gkbar*n*n*n*n
% 	ik = gk*(v - ek)
%         il = gl*(v - el)
% }

BreakLineI=find(strhas(Lines,'BREAKPOINT'));
StartL=BreakLineI;
EndL=min(EndLines(EndLines>BreakLineI));
CurLines=Lines((StartL+1):EndL);
SolveLine=CurLines(strhas(CurLines,'SOLVE'));
[Tmp RestLine]=strtok(SolveLine);
[SolveWhat RestLine]=strtok(RestLine);
[Tmp RestLine]=strtok(RestLine);
SolveMethod=strtok(RestLine);
if(~strcmp(SolveMethod,'cnexp'))
    disp('Solve method not cnexp!');
    sdfsdf;
end
CurLines=CurLines(~strhas(CurLines,'SOLVE'));
CurLines=regexprep(CurLines,'\s*','');
FirstLine=['void BreakpointModel() {'];
TmpLines=strcat(CurLines,';');
CBreakLines=[FirstLine; TmpLines];