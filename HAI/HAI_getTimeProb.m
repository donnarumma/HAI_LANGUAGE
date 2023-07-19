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

alltimes=full(spm_cat(probLevel));
alltimes=alltimes(:,end);
vals=sort(alltimes);
for ilev=1:length(probLevel)
    for it=1:length(probLevel{ilev}(:,2))
        probLevel{ilev}(it,3)=find(probLevel{ilev}(it,2)==vals);
    end
end

probLevel{1}(:,4)=(1:length(probLevel{1}(:,3)))-1;
% RT=probLevel{1}(:,2);
for ilev=2:length(probLevel)
    RT=probLevel{ilev-1}(:,2);
    for it=1:length(probLevel{ilev}(:,3))
        [~,minR]=min(abs(RT-probLevel{ilev}(it,2)));
        probLevel{ilev}(it,4)=probLevel{ilev-1}(minR,4);
    end
end

