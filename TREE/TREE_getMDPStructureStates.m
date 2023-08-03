function   [stree]=TREE_getMDPStructureStates(MDP)
% function [stree]=TREE_getMDPStructureStates(MDP)
str = ['C' num2str(MDP.level)];%MDP.Aname{1};
stree=tree(str);
node =1;
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    str = ['C' num2str(MDP.level)];%MDP.Aname{1};
    [stree,node]=stree.addnode(node,str);
end

% str = ['O' num2str(MDP.level)];%MDP.Aname{1};
str = 'CONTENT';
stree=stree.addnode(node,str);