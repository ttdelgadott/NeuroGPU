function [Starts Ends CN Vec]=Cell2Vec(In)
if(isempty(In))
    Starts=[];
    Ends=[];
    CN=[];
    Vec=[];
end
CN=cellNumel(In);
CS=cumsum(CN);
Starts=[1 CS(1:end-1)+1];
Ends=CS;
for i=1:numel(In)
    Vec(Starts(i):Ends(i))=In{i};
end