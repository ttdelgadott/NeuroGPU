BranchP=CN(1:end-1)+1;
SegStartI=[0 CN(1:end-1)]+2;
SegEndI=CN;
% which results go to which parentm
for CurLevel=1:Depth
    CurBranches=find(Level==CurLevel);
    for CurB=CurBranches
        Related{CurB}=find(Ks==BranchP(CurB-1));
        %         SegStartI(CurB)=SegStartI(CurB)+1;
    end
end

uHP=d;
bHP=B;
%%
for CurLevel=0:Depth
    %     Run all independent set for this level, in parallel
    for JumctionI=find(Level==CurLevel) % in parallel
        CurSegs=SegStartI(JumctionI):SegEndI(JumctionI);
        for i=SegStartI(JumctionI):SegEndI(JumctionI)
            uHP(i)=uHP(i)-e(i)*(f(i-1)/uHP(i-1)); % So far same as paper parallel
            bHP(i)=bHP(i)-bHP(i-1)*e(i)/uHP(i-1); % bH is y
        end
    end
    %         sum relevant resuls
    if(CurLevel<Depth)
        for CurB=find(Level==CurLevel+1) % in parallel
            CurJ=BranchP(CurB-1);
            for j=Related{CurB}
                uHP(CurJ)=uHP(CurJ)-e(j)*(f(j-1)/uHP(j-1)); % So far same as paper parallel
                bHP(CurJ)=bHP(CurJ)-bHP(j-1)*e(j)/uHP(j-1); % bH is y
            end
        end
    end
end

disp('---');