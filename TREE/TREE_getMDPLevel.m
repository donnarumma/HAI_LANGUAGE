function   [stree]=TREE_getMDPLevel(MDP)
% function [stree]=TREE_getMDPLevel(MDP)
stree       =tree('Level');
node        =1;
[stree,node]=stree.addnode(node,MDP.level);
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    [stree,node]=stree.addnode(node,MDP.level);
end
% stree=stree.addnode(node,MDP.Bname{1});