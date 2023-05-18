function   [stree]=TREE_getMDPStructureStates(MDP)
% function [stree]=TREE_getMDPStructureStates(MDP)
str = ['S' num2str(MDP.level)];%MDP.Aname{1};
stree=tree(str);
node =1;
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    str = ['S' num2str(MDP.level)];%MDP.Aname{1};
    [stree,node]=stree.addnode(node,str);
end

% str = ['O' num2str(MDP.level)];%MDP.Aname{1};
str = 'STRUCTURES';
stree=stree.addnode(node,str);