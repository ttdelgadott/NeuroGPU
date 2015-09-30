function Out=removeGlobalsRecalculation(In,NGlobals)
Out=In;
for l=1:numel(Out)
    if(iscell(Out{l}))
        Out{l}=removeGlobalsRecalculation(Out{l},NGlobals);
    else
        if(~isempty(Out{l}))
            for g=1:numel(NGlobals)
                Out{l}=regexprep(Out{l},['(^|\W)' NGlobals{g} '\W*=.*?;'],['/* removed ' NGlobals{g} ' recalculation */']);
            end
        end
    end
end