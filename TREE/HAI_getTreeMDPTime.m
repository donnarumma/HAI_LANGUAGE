function   [stree] = HAI_getTreeMDPTime(MDP,LevelFun,AppendFun,root_level,stree,node)
% function [stree] = HAI_getTreeMDP(MDP,LevelFun,AppendFun,root_level,stree,node)

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
    stree   = tree('ROOT');
end
subnode=zeros(MDP.T,1);
for iT=1:MDP.T
    element = LevelFun(MDP,stree,iT);
    [stree, subnode(iT)] =stree.addnode(node,element);
end
if isfield(MDP,'mdp')
    for iT=1:length(MDP.mdp)
        stree  = HAI_getTreeMDPTime(MDP.mdp(iT),LevelFun,AppendFun,root_level,stree,subnode(iT));
    end
else
    stree=AppendFun(MDP,stree,node);
end
return