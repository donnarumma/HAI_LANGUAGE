function probLevel=HAI_getTimeProb(MDP)
% function probLevel=HAI_getTimeProb(MDP)
% need matlab-tree
% get for each level the couples [prob(t),t]

ptree   = TREE_getMDPTime(MDP,@TREE_LevelTime_StateProb,@TREE_Append_NULL);  % tree of probability per level
levtree = TREE_getMDPTime(MDP,@TREE_LevelTime_t,@TREE_Append_NULL);          % tree of cumulative time per level

ABSRTtree=TREE_AbsRT(MDP);
probLevel=cell(ABSRTtree.depth,1);
btiterator=ABSRTtree.breadthfirstiterator;
for it=2:length(btiterator)
    cnode=btiterator(it);
    probLevel{levtree.get(cnode)}=[           probLevel{levtree.get(cnode)};  ...
                                   [ptree.get(cnode), ABSRTtree.get(cnode)]];
end