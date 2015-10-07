uHP=d;
bHP=B;
%%
for CurLevel=0:Depth
    %     Run all independent set for this level, in parallel
    for r=LRelStarts(CurLevel+1):LRelEnds(CurLevel+1)
        CurLevelForL=r;
        for ProcessorI = 1:32 % in parallel
            JumctionI=CompByLevel32(CurLevelForL,ProcessorI);
            % The following if is unnecessary in CUDA
            if(ProcessorI>1 && CompByLevel32(CurLevelForL,ProcessorI)==CompByLevel32(CurLevelForL,ProcessorI-1))
                continue;
            end
            %     for JumctionI=find(Level==CurLevel) % in parallel
            for i=SegStartI(JumctionI):SegEndI(JumctionI)
                
                uHP(i)=uHP(i)-e(i)*(f(i-1)/uHP(i-1)); % So far same as paper parallel
                bHP(i)=bHP(i)-bHP(i-1)*e(i)/uHP(i-1); % bH is y
            end
        end
    end
    %         sum relevant resuls
    if(CurLevel<Depth)
        for r=FLRelStarts(CurLevel+1):FLRelEnds(CurLevel+1)
            %         for CurB=find(FLevel==CurLevel+1) % in parallel
            CurLevelForFLevel=r;
            for ProcessorI = 1:32 % in parallel
                if(ProcessorI>1 && CompByFLevel32(CurLevelForFLevel,ProcessorI)==CompByFLevel32(CurLevelForFLevel,ProcessorI-1))
                    continue;
                end
                CurB=CompByFLevel32(CurLevelForFLevel,ProcessorI);
                %             CurJ=BranchP(CurB-1);
                CurJ=Fathers(CurB);
                
                %             for j=Related{CurB}
                for j=RelVec(RelStarts(CurB):RelEnds(CurB))
                    uHP(CurJ)=uHP(CurJ)-e(j)*(f(j-1)/uHP(j-1)); % So far same as paper parallel
                    bHP(CurJ)=bHP(CurJ)-bHP(j-1)*e(j)/uHP(j-1); % bH is y
                end
            end
        end
    end
end

%disp('HinesTriankP2Ks32');