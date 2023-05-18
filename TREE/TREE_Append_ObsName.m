function   stree = TREE_Append_ObsName(MDP,stree,node)
% function stree = TREE_Append_ObsName(MDP,stree,node)
stree=stree.addnode(node,MDP.Bname{1});