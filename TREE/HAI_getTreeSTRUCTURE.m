function   [stree]=HAI_getTreeSTRUCTURE(MDP)
% function [stree]=HAI_getTreeSTRUCTURE(MDP)
stree=tree(MDP.Aname{1});
node =1;
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    [stree,node]=stree.addnode(node,MDP.Aname{1});
end
stree=stree.addnode(node,MDP.Bname{1});