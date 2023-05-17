% function main_TREE

%% state tree

[stree] = HAI_getTreeMDP(MDP,@HAI_TreeLevel_StateFun,@HAI_TreeAppend_ObsFun);
[mtree] = HAI_getTreeSTRUCTURE(MDP);
% disp([stree.tostring,mtree.tostring]);

guard = HAI_getTreeMDP(MDP,@HAI_TreeLevel_SyntaxName,@HAI_TreeAppend_SyntaxObs);


[ltree] = HAI_getTreeMDPTime(MDP,@HAI_TreeLevelTime_LocationFun,@HAI_TreeAppend_NULL);

disp([stree.tostring,mtree.tostring,ltree.tostring]);
