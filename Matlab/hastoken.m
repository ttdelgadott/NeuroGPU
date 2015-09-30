function Out=hastoken(In,Str)
if(iscell(In))
    for i=1:numel(In)
        Out(i)=strhas(In{i},['(^|\W)(' Str ')($|\W)']);
    end
    return;
end
Out=false;
if(~isempty(regexp(In,['(^|\W)(' Str ')($|\W)'], 'once')))
    Out=true;
end
