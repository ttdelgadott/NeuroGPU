NumSegPerComp=5;
for i=1:numel(NSeg)
    if(NSeg(i)>NumSegPerComp)
%         Idxs=floor(linspace(1,NSeg(i),NumSegPerComp+1));
%         Idxs(end)=Idxs(end)+1;
%         for j=1:NumSegPerComp
%             TmpLengths(j)=sum(Lengths{i}(Idxs(j):(Idxs(j+1)-1)));
%             TmpDiams(j)=mean(Diams{i}(Idxs(j):(Idxs(j+1)-1)));
%         end
%         Lengths{i}=TmpLengths;
%         Diams{i}=TmpDiams;
        TrgNumSegPerComp=NumSegPerComp;
%         if(i==numel(NSeg))
%             TrgNumSegPerComp=NumSegPerComp+32-mod(sum(min(NSeg,NumSegPerComp)),32);
%         end
        LS=linspace(0,NSeg(i),TrgNumSegPerComp+1);
        CS=[0  cumsum(Lengths{i})];
        Lengths{i}=diff(interp1(0:NSeg(i),CS,LS));
        
        CS=[0  cumsum(Diams{i})];
        Diams{i}=diff(interp1(0:NSeg(i),CS,LS))./diff(LS);
        
        
        NSeg(i)=TrgNumSegPerComp;
    end
end

% toPad = 32 -(sum(NSeg)-floor(sum(NSeg)/32)*32);
% if(toPad>0)
%     NSeg(end)=NSeg(end)+toPad;
%     for i=1:toPad%making sure length wont be 0;
%         Lengths{end}(end+1) = 0.01;
%         Diams{end}(end+1) = Diams{end}(1);
%     end
% end

