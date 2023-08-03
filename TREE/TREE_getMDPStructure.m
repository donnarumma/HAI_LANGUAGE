function   [stree]=TREE_getMDPStructure(MDP)
% function [stree]=TREE_getMDPStructure(MDP)
% str = [MDP.Aname{1} ' C(' num2str(MDP.level) ')'];
str = [MDP.Aname{1}];
% str = sprintf('S%g=%s',MDP.level,str);
stree=tree(str);
node =1;
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    % str = [MDP.Aname{1} ' C(' num2str(MDP.level) ')'];
    str = [MDP.Aname{1}];
    % str = sprintf('S%g=%s',MDP.level,str);
    [stree,node]=stree.addnode(node,str);
end
% stree=stree.addnode(node,[MDP.Bname{1} ' (C0)']);
stree=stree.addnode(node,[MDP.Bname{1}]);