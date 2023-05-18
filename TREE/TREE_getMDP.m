function   [stree] = TREE_getMDP(MDP,LevelFun,AppendFun,root_level,stree,node)
% function [stree] = TREE_getMDP(MDP,LevelFun,AppendFun,root_level,stree,node)
% [stree] = TREE_getMDP(MDP,@HAI_stateTreeFun,@HAI_obsTreeFun);

if nargin < 6
    stree=[];
    if nargin < 4
        root_level=MDP.level;
    end
end
element = LevelFun(MDP,stree);
%%
if MDP.level==root_level
    node    = 1;
    stree   = tree(element);
else
    try
        [stree, node] =stree.addnode(node,element);
    catch
        fprintf('WTF\n');
    end
end
if isfield(MDP,'mdp')
    for iT=1:length(MDP.mdp)
        stree  = TREE_getMDP(MDP.mdp(iT),LevelFun,AppendFun,root_level,stree,node);
    end
else
    stree=AppendFun(MDP,stree,node);
end
return