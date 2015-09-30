function OutC=ReplacePowf(InC)
if(ischar(InC))
    InC={InC};
end
OutC=cell(1,numel(InC));
for i=1:numel(InC)
    % In='tadj_kv=q10_kv^((celsius - temp_kv)/(10 )) ;';
    if(iscell(InC{i}))
        OutC{i}=ReplacePowf(InC{i});
    else
        In=InC{i};
        F1=find(In=='^');
        InC{i}=strrep(InC{i},'}',';}');
        if(~isempty(F1))
            F2=find(In=='=');
            F3=find(In==';');
            OutC{i}=[In(1:F2) 'powf(' In(F2+1:F1-1) ',' In(F1+1:F3-1) ');'];
        else
            OutC{i}=InC{i};
        end
    end
end