function   stree = HAI_TreeAppend_SyntaxObs(MDP,stree,node)
% function stree = HAI_TreeAppend_SyntaxObs(MDP,stree,node)
stree=stree.addnode(node,MDP.Bname{1});