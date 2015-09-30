% PROCEDURE rates(v(mV)) {  :Computes rate and other constants at current v.
%                       :Call once from HOC to initialize inf at resting v.
%         LOCAL  alpha, beta, sum, q10
%         TABLE minf, mtau, hinf, htau, ninf, ntau DEPEND celsius FROM -100
%         TO 100 WITH 200
% UNITSOFF
%         q10 = 3^((celsius - 6.3)/10)
%                 :"m" sodium activation system
%         alpha = .1 * vtrap(-(v+40),10)
%         beta =  4 * exp(-(v+65)/18)
%         sum = alpha + beta
% 	mtau = 1/(q10*sum)
%         minf = alpha/sum
%                 :"h" sodium inactivation system
%         alpha = .07 * exp(-(v+65)/20)
%         beta = 1 / (exp(-(v+35)/10) + 1)
%         sum = alpha + beta
% 	htau = 1/(q10*sum)
%         hinf = alpha/sum
%                 :"n" potassium activation system
%         alpha = .01*vtrap(-(v+55),10)
%         beta = .125*exp(-(v+65)/80)
% 	sum = alpha + beta
%         ntau = 1/(q10*sum)
%         ninf = alpha/sum
% }
clear CProcLines
ProcedureLines=find(strhas(Lines,'PROCEDURE'));
for i=numel(ProcedureLines)
    StartL=ProcedureLines(i);
    EndL=min(EndLines(EndLines>StartL));
    CurLines=Lines((StartL+1):EndL);
    CLocalLine='';
    LocalVars=cell(0);
    LocalLineF=find(strhas(CurLines,'LOCAL'));
    if(~isempty(LocalLineF))
        LocalLine=CurLines{LocalLineF};
        LocalVarLine=LocalLine((strfind(LocalLine,'LOCAL')+6):end);
        LocalVarLine=regexprep(LocalVarLine,'\s*','');
        LocalVars=regexp(LocalVarLine,',','split');
        CLocalLine=[FTYPESTR ' ' LocalVarLine ';'];
    end
    
    EqualLinesF=find(strhas(CurLines,'='));
    UpdatedVars=cell(0);
    for j=EqualLinesF
        UpdatedVars=[UpdatedVars fliplr(strtok(fliplr(CurLines{j}(1:(find(CurLines{j}=='=',1)-1)))))];
    end
    UpdatedVars=unique(UpdatedVars);
    OutVars=setdiff(UpdatedVars,LocalVars);
    
    ProcedureLine=Lines{StartL};
    ProcedureLine=ProcedureLine(strfind(ProcedureLine,'PROCEDURE')+10:end);
    FuncName=strtok(strrep(ProcedureLine,'(',' '));
    RestLine=ProcedureLine(strfind(ProcedureLine,'(')+1:end);
    RestLine= regexprep(RestLine,'\(.*?\)','');
    RestLine=RestLine(1:(find(RestLine==')',1)-1));
    InputVars=regexp(RestLine,',','split');
    FirstLine=['void ' FuncName '('];
    for k=1:numel(InputVars)
        Tmp='';
        if(k>1)
            Tmp=',';
        end
        FirstLine=[FirstLine Tmp FTYPESTR ' ' InputVars{k}];
    end
    for k=1:numel(OutVars)
        Tmp='';
        if(k>1 || ~isempty(InputVars))
            Tmp=',';
        end
        FirstLine=[FirstLine Tmp FTYPESTR ' &' OutVars{k}];
    end
    FirstLine=[FirstLine ') {'];
    FLines=CurLines(~strhas(CurLines,'(UNITSOFF|LOCAL|TABLE)'));
    
    if(~isempty(LocalLineF))
        LocalLine=CurLines{LocalLineF};
        CLocalLine=[FTYPESTR ' ' LocalLine((strfind(LocalLine,'LOCAL')+6):end) ';'];
    end
    
    CProcLines{i}=[FirstLine; CLocalLine; FLines];
end