function Out=cellNumel(in)
Out=zeros(size(in));
if(isempty(in))
    return;
end
for i=1:numel(in)
    Out(i)=numel(in{i});
end