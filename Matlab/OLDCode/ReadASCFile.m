fclose all
clear 
FN='P17-DEV168.asc';
fid = fopen(FN);
Parent=0;
CurN=1;
NSeg=0;
Name={'Base'};
tline = fgetl(fid);
LineNum=0;
while ischar(tline)
    LineNum=LineNum+1;
%     disp(CurN);
    NO=sum(tline=='(');
    NC=sum(tline==')');
    NNP=sum(tline==';');
    NX=sum(tline=='|');
%     if(LineNum==191)
%         a=6;
%     end
    if(NX==1)
%          disp([num2str(LineNum) ' - ' num2str(CurN) '  -  ' tline]);
         
        CurN=Parent(CurN);
        
        NewIdx=numel(Parent)+1;
        Parent(NewIdx)=CurN;
        CurN=NewIdx;
        NSeg(NewIdx)=0;
    end
    tlineOld=tline;
    tline = fgetl(fid);
    if(NO==0 && NC==0)
        continue;
    end
    if(NO==1 && NC==1 && NNP==0)
        continue;
    end
    if(NO==NC)
        NSeg(CurN)=NSeg(CurN)+1;
        
        if(NSeg(CurN)==1)
            S=regexp(tlineOld,'[,;]','split');
            Name{CurN}=S{end};
        end
        continue;
    end
%      disp([num2str(LineNum) ' - ' num2str(CurN) '  -  ' tlineOld]);
    if(NO>NC)
        NewIdx=numel(Parent)+1;
        Parent(NewIdx)=CurN;
        CurN=NewIdx;
        NSeg(NewIdx)=0;
    end
    if(NC>NO)
        CurN=Parent(CurN);
    end
end

fclose(fid);
%% display
% for i=1:numel(NSeg)
%     disp([num2str(i) '  -  ' num2str(Parent(i)) ' ' Name{i}]);
% end
%%
NComp=numel(NSeg);
Tcount=0;
clear T
for i=1:NComp
    Adj{i}=find(Parent==i);
    if(numel(Adj{i})>0)
        Tcount=Tcount+1;
        T{Tcount}=[NComp+1-i NComp+1-Adj{i}];
    end
end
Ns=NSeg(end:-1:1)+1;