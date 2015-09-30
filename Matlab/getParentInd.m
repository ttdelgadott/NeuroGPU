function p = getParentInd(neuron,seg)

comp = find(neuron.SegEnd>=seg,1,'first');
if(neuron.SegStart(comp)==seg)
    parentComp = neuron.Parent(comp);
    if(parentComp~=0)
        p = neuron.SegStart(parentComp)+neuron.ChildSegs(comp)-1;
    else
        p=0;
    end
else
    p=seg-1;
end
%     
%     if(parentComp~=0)
%         
%         seg
%         offset = neuron.SegStart(parentComp)
%         parentCon = neuron.ParentConnection(comp)
%         neuron.NSegs(parentComp)
%         p = offset+floor(parentCon*neuron.NSegs(parentComp))
%         if (parentCon == 1 && sum(neuron.N3d==0))%for some akward reason we need this
%             p =  neuron.SegEnd(parentComp);
%         end
%         
%     else
%         p = 0;
%     end
% else
%     if(seg>1)
%         p=seg-1;
%     else
%         p=0;
%     end
% end
% 

