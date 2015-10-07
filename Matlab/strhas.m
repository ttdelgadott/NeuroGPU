function Out=strhas(In,Str)
if(iscell(In))
    for i=1:numel(In)
        Out(i)=strhas(In{i},Str);
    end
    return;
end
Out=false;
if(~isempty(regexp(In,Str, 'once')))
    Out=true;
end
