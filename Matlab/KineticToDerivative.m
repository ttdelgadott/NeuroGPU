FN=[BaseP 'Neuron' filesep 'KineticMechs' filesep 'na8st.mod'];
FNOut=[BaseP 'Neuron' filesep 'KineticMechs' filesep 'na8st_deriv.mod'];
Lines=getLines(FN);
StartLine=find(strhas(Lines,'KINETIC'));
EndLines=find(strhas(Lines,'}'));
EndLine=min(EndLines(EndLines>StartLine));
KinLines=find(strhas(Lines,'<->'));
Terms=struct();
for i=1:numel(KinLines)
    CurLine=Lines{KinLines(i)};
    CurLine=regexprep(strrep(strrep(CurLine,'~',''),'<->',' '),'[\(\),]',' ');
    S=regexp(CurLine,'\W+','split');
    S=S(cellNumel(S)>0);
    AllS(i,:)=S;
end
AllTerms=unique(AllS(:,1:2));
for i=1:numel(AllTerms)
    Terms.(AllTerms{i})='';
end
for i=1:size(AllS,1)
    Terms.(AllS{i,1})=[Terms.(AllS{i,1}) ' -'  AllS{i,1} '*' AllS{i,3} ' +' AllS{i,2} '*' AllS{i,4}];
    Terms.(AllS{i,2})=[Terms.(AllS{i,2}) ' +'  AllS{i,1} '*' AllS{i,3} ' -' AllS{i,2} '*' AllS{i,4}];
end
for i=1:numel(AllTerms)
    OutKinLine{i}=[sprintf('\t') AllTerms{i} '''' ' = ' Terms.(AllTerms{i})];
end
SolveLine=find(strhas(Lines,'SOLVE') & strhas(Lines,'METHOD') );
Lines{SolveLine}=strrep(Lines{SolveLine},'sparse','cnexp');
InitSolveLine=find(strhas(Lines,'SOLVE') & strhas(Lines,'STEADYSTATE') );
Lines{InitSolveLine}=regexprep(Lines{InitSolveLine},'SOLVE.*STEADYSTATE(\W+.*?\W)','');
DerivLine=strrep(Lines{StartLine},'KINETIC','DERIVATIVE');
OutLines=[Lines(1:(StartLine-1))'; DerivLine; OutKinLine'; Lines(EndLine:end)'];
putLines(FNOut,OutLines);