function   [stree] = TREE_getMDPTime(MDP,LevelFun,AppendFun,root_level,stree,node)
% function [stree] = TREE_getMDPTime(MDP,LevelFun,AppendFun,root_level,stree,node)

if nargin < 6
    stree=[];
    if nargin < 4
        root_level=MDP.level;
    end
end
if MDP.level==root_level
    node    =1;
end
%%

if MDP.level==root_level 
    element = LevelFun(MDP,stree,0);
    stree   = tree(element);
end
subnode=zeros(MDP.T,1);
for iT=1:MDP.T
    element = LevelFun(MDP,stree,iT);
    [stree, subnode(iT)] =stree.addnode(node,element);
end
if isfield(MDP,'mdp')
    for iT=1:length(MDP.mdp)
        stree  = TREE_getMDPTime(MDP.mdp(iT),LevelFun,AppendFun,root_level,stree,subnode(iT));
    end
else
    stree=AppendFun(MDP,stree,node);
end
return