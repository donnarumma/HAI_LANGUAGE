function   [stree]=TREE_getMDPContent(MDP)
% function [stree]=TREE_getMDPStructure(MDP)
str = ['C(' num2str(MDP.level) ')'];
% str = sprintf('S%g=%s',MDP.level,str);
stree=tree(str);
node =1;
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    str = ['C(' num2str(MDP.level) ')'];
    % str = sprintf('S%g=%s',MDP.level,str);
    [stree,node]=stree.addnode(node,str);
end
stree=stree.addnode(node,['C(0)']);