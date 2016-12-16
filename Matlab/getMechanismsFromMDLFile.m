function Mechanisms=getMechanismsFromMDLFile(FN_TopoMDL)
Lines=getLines(FN_TopoMDL);
S=regexp(Lines,'_(.*)=.*','tokens');
S=cat(1,S{:});
S=cat(1,S{:});
for i=1:numel(S)
    if(numel(S{i})>4)
        if(strcmp(S{i}(end-3:end),'ion '))
            S{i}=[];
        end
    end
end
S=S(cellNumel(S)>0);
S=unique(S)';
if (~isempty(S))
    Z=regexp(S,'_','split');
    for i=1:numel(Z)
        Z{i}=Z{i}{end}(1:end-1);
    end
    Mechanisms=unique(Z)';
else
    Mechanisms=[];
end