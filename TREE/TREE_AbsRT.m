function   ABSRTtree=TREE_AbsRT(MDP)
% function ABSRTtree=TREE_AbsRT(MDP)
% tree of cumulative depthfirst reaction times
RTtree   = TREE_getMDPTime(MDP,@TREE_LevelTime_RT,@TREE_Append_NULL);
ABSRTtree= RTtree;
diterator=ABSRTtree.depthfirstiterator;
for lev=1:length(diterator)
    current_node  = diterator(lev);    
    leftmost_node = TREE_getTimeLeftMostNode(ABSRTtree,current_node);
    if ~isempty(leftmost_node)
        val= ABSRTtree.get(leftmost_node);
    else
        val=0;
    end
    val           = val+TREE_sum(ABSRTtree.subtree(diterator(lev)));
    ABSRTtree     = ABSRTtree.set(current_node,val);
end
if nargout<1
    disp(ABSRTtree.tostring); 
end
