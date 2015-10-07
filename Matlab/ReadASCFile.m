function [Adj,Coords,Type,Parent,NSeg] = ReadASCFile(FN)
fid = fopen(FN);
Parent=[];
CurN=1;
NSeg=0;
Name={'Base'};
tline = fgetl(fid);
LineNum=-1;
while ischar(tline)
    LineNum=LineNum+1;
    if(LineNum == 43)
     disp(CurN);
    end
    NO=sum(tline=='(');
    NC=sum(tline==')');
    NNP=sum(tline==';');
    NX=sum(tline=='|');
%     if(LineNum==191)
%         a=6;
%     end
    if(NO==1 && NC==1 && NNP==0)
        if(strcmp(strtrim(tline),'(CellBody)')||strcmp(strtrim(tline),'(Axon)')||strcmp(strtrim(tline),'(Dendrite)')||strcmp(strtrim(tline),'(Apical)'))
          Type{CurN} = tline(2:end);  
        end
        %continue;
    end
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
    if(NO==1 && NC==1 && NNP==0)
        continue;
    end
    if(NO==0 && NC==0)
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
fid = fopen(FN);
tline = fgetl(fid);
LineNum=-1;
CurrSeg = zeros(1,NewIdx);
CurN=1;
NewIdx =0;
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
        NewIdx=NewIdx+1;
        CurN=NewIdx;
        Coords{NewIdx}={};
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
        CurrSeg(CurN)=CurrSeg(CurN)+1;
        S=regexp(tlineOld,'[,;]','split');
        coor = sscanf(S{1},'%*s %f %f %f %f');
        Coords{CurN}{CurrSeg(CurN)} = coor;
        if(NSeg(CurN)==1)
            
    
        end
        continue;
    end
%      disp([num2str(LineNum) ' - ' num2str(CurN) '  -  ' tlineOld]);
    if(NO>NC)
        NewIdx=NewIdx+1;
        CurN=NewIdx;
        Coords{NewIdx}={};
    end
    if(NC>NO)
        CurN=Parent(CurN);
    end
end

fclose(fid);
[Parent,Type,Coords,NSeg,Name] = turnAroundMat(Parent,Type,Coords,NSeg,Name);
%% destroy stuff
% NN=4;
% Parent=Parent(1:NN);
% Coords=Coords(1:NN);
% NSeg=NSeg(1:NN);
% Name=Name(1:NN);
% Type=Type([5 7 11 12]);
% Parent=Parent*0+numel(Parent);
% Parent(end)=numel(Parent)+1;
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
%     if(numel(Adj{i})>0)
%         Tcount=Tcount+1;
%         T{Tcount}=[NComp+1-i NComp+1-Adj{i}];
%     end
end

%plotNeuron(Coords,Lengths,Diams);

