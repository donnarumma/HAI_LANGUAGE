function   maxTree=HAI_dispMaxTree(MDP)
% function maxTree=HAI_dispMaxTree(MDP)

maxTree= TREE_getMDP(MDP,@TREE_Level_maxT,@TREE_Append_NULL);

if nargout<1
    disp(maxTree.tostring);
end