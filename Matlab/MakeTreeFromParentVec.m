Nx=N;
NN=histc(Aux.Ks,1:Nx);
% Fathers=find(NN>1);
Fathers=unique(Ks(Ks~=1:numel(Ks) & Ks>0));
for i=1:numel(Fathers)
    Related{i}=find(Ks==Fathers(i));
end
if(~isempty(Fathers))
    [RelStarts RelEnds RelCN RelVec]=Cell2Vec(Related);
else
    RelStarts=[];
    RelEnds=[];
    RelCN=[];
    RelVec=[];
end

CallForFathers=find(ismember(Aux.Ks,Fathers));
RFathers(Fathers)=1:numel(Fathers);
SegStartI=[2 CallForFathers+1];
SegEndI=[CallForFathers-1 Nx-1];

Level=SegStartI*0;
Level( ismember(SegStartI-1,Fathers) )=1;
for i=1:50
    FF=find(Level==i);
    ToWhoTheyCall=Aux.Ks(SegEndI(FF)+1);
    Level(find(ismember(SegStartI-1,ToWhoTheyCall)))=i+1;
end
FLevel=Fathers*0+1;
for i=1:max(Level)
    FF=find(Level==i);
    ToWhoTheyCall=Aux.Ks(SegEndI(FF)+1);
    ToWhichFatherDoTheyCall=RFathers(ToWhoTheyCall(ToWhoTheyCall<=max(Fathers)));
    FLevel(ToWhichFatherDoTheyCall)=i+1;
end
% for i=1:numel(Fathers); Bad previous solution
%     TF=find(SegStartI-1==Fathers(i));
%     FLevel(i)=Level(TF);
% end
SegEndI(end)=N;
Depth=max(Level);