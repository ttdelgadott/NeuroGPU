uHP32=d;
bHP32=B;
%%
for CurLevel=0:Depth
    %     Run all independent set for this level, in parallel
    for ProcessorI = 1:32 % in parallel
        JumctionI=CompByLevel32(CurLevel+1,ProcessorI);
        % The following if is unnecessary in CUDA
        if(ProcessorI>1 && CompByLevel32(CurLevel+1,ProcessorI)==CompByLevel32(CurLevel+1,ProcessorI-1))
            continue;
        end
        for i=SegStartI(JumctionI):SegEndI(JumctionI)
            uHP32(i)=uHP32(i)-e(i)*(f(i-1)/uHP32(i-1)); % So far same as paper parallel
            bHP32(i)=bHP32(i)-bHP32(i-1)*e(i)/uHP32(i-1); % bH is y
        end
    end
    %         sum relevant resuls
    if(CurLevel<Depth)
        for ProcessorI = 1:32 % in parallel
%         for CurB=find(Level==CurLevel+1) % in parallel
            % The following if is unnecessary in CUDA
            if(ProcessorI>1 && CompByLevel32(CurLevel+2,ProcessorI)==CompByLevel32(CurLevel+2,ProcessorI-1))
                continue;
            end
            CurB=CompByLevel32(CurLevel+2,ProcessorI);
            CurJ=BranchP(CurB-1);
%             for j=Related{CurB}
            for j=RelVec(RelStarts(CurB):RelEnds(CurB))
                uHP32(CurJ)=uHP32(CurJ)-e(j)*(f(j-1)/uHP32(j-1)); % So far same as paper parallel
                bHP32(CurJ)=bHP32(CurJ)-bHP32(j-1)*e(j)/uHP32(j-1); % bH is y
            end
        end
    end
end

% max(uHP32-uHP)