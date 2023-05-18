function   [num]=HAI_getBackSaccades(MDP)
% function [num]=HAI_getBackSaccades(MDP)
    stree=HAI_disp(MDP);
    num = 0;
    iterator=stree.locations.depthfirstiterator;
    for it=1:length(iterator)
        bs=0; 
        chs=stree.locations.getchildren(it);
        if length(chs)>1
            vals=[stree.locations.Node{chs}];
            bs=sum(diff(vals)<=0);
        end
        num=num+bs;
    end
end