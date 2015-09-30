function [nParent,nType,nDiams,nLengths,nNSeg] = turnAroundMatForNeuron(Parent,Type,Diams,Lengths,Nseg);

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
    nNSeg(endInd) = Nseg(i);
    nType{endInd}=Type{i};
    %nName{endInd} = Name{i};
    nDiams{endInd}=Diams{i};
    nLengths{endInd}=Lengths{i};
    endInd = endInd-1;
end
nParent(end)=length(Parent)+1;