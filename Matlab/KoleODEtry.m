tmp=strcat(AllTerms','~');
eval(['syms ' strrep([tmp{:}],'~',' ') 'real']);
AllSymbols=unique(AllS)';
AllCoeffs=setdiff(AllSymbols,AllTerms);
tmp=strcat(AllCoeffs','~');
eval(['syms ' strrep([tmp{:}],'~',' ') 'real']);
Map=struct();
for i=1:numel(AllTerms)
    Map.(AllTerms{i})=i;
end
A=sym(zeros(numel(AllTerms)));
for i=1:size(AllS,1)
    CurVal=eval(AllS{i,3});
    A(Map.(AllS{i,1}),Map.(AllS{i,1}))=A(Map.(AllS{i,1}),Map.(AllS{i,1}))-CurVal;
    A(Map.(AllS{i,2}),Map.(AllS{i,1}))=A(Map.(AllS{i,2}),Map.(AllS{i,1}))+CurVal;
    CurVal=eval(AllS{i,4});
    A(Map.(AllS{i,1}),Map.(AllS{i,2}))=A(Map.(AllS{i,1}),Map.(AllS{i,2}))+CurVal;
    A(Map.(AllS{i,2}),Map.(AllS{i,2}))=A(Map.(AllS{i,2}),Map.(AllS{i,2}))-CurVal;
end
AllTermsVec=eval(['[' AllTerms{1} ' ' AllTerms{2} ' ' AllTerms{3} ' ' AllTerms{4} ' ' AllTerms{5} ' ' AllTerms{6} ' ' AllTerms{7} ' ' AllTerms{8} ']']);
[V,D] = eig(A);
Q=V'*AllTermsVec'; % This supposes to be the coefficient vector
InvA=inv(eye(numel(AllTerms))-A);
Ynext=InvA*AllTermsVec';
%%
syms a b c d
A=[a b;c d]
[V,D] = eig(A);
%%
syms y1(t) y2 a1 b1
dsolve(diff(y1)==y2+y1)

%%
syms mc(t) m(t) a b
eqns(1)=diff(mc)==-a*mc +b*m;
eqns(2)=diff(m)==+a*mc -b*m;
SolSmall=dsolve(eqns)