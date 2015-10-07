uHP=d;
bHP=B;
%%
for CurLevel=0:Depth
    %     Run all independent set for this level, in parallel
    for JumctionI=find(Level==CurLevel) % in parallel
        for i=SegStartI(JumctionI):SegEndI(JumctionI)
            uHP(i)=uHP(i)-e(i)*(f(i-1)/uHP(i-1)); % So far same as paper parallel
            bHP(i)=bHP(i)-bHP(i-1)*e(i)/uHP(i-1); % bH is y
        end
    end
    %         sum relevant resuls
    if(CurLevel<Depth)
        for CurB=find(Level==CurLevel+1) % in parallel
            CurJ=BranchP(CurB-1);
%             for j=Related{CurB}
            for j=RelVec(RelStarts(CurB):RelEnds(CurB))
                uHP(CurJ)=uHP(CurJ)-e(j)*(f(j-1)/uHP(j-1)); % So far same as paper parallel
                bHP(CurJ)=bHP(CurJ)-bHP(j-1)*e(j)/uHP(j-1); % bH is y
            end
        end
    end
end