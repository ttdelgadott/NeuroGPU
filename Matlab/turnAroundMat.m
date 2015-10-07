function [nParent,nType,nCoords,nNseg,nName] = turnAroundMat(Parent,Type,Coords,Nseg,Name)
Type{numel(Name)}=[];
endInd = length(Parent);

% toPad = 32 -(sum(Nseg)-floor(sum(Nseg)/32)*32);
% if(toPad>0)
%     Nseg(end)=Nseg(end)+toPad;
%     for i=1:toPad%making sure length wont be 0;
%         padCoord = Coords{end}{end};
%         padCoord(1) = padCoord(1)+0.01;
%         Coords{end}{end+1} = padCoord;
%     end
% end


for i = 1:length(Parent)
    nParent(endInd) = length(Parent) - Parent(i)+1;
    nNseg(endInd) = Nseg(i);
    nType{endInd}=Type{i};
    nName{endInd} = Name{i};
    nCoords{endInd}=Coords{i};
    endInd = endInd-1;
end
nParent(end)=length(Parent)+1;

