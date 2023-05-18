function   [stree]=TREE_getMDPStructureLocations(MDP)
% function [stree]=TREE_getMDPStructureLocations(MDP)
stree       =tree('LOCATIONS');
node        =1;
str         =['L' num2str(MDP.level)];
[stree,node]=stree.addnode(node,str);
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    str = ['L' num2str(MDP.level)];
    [stree,node]=stree.addnode(node,str);
end
% stree=stree.addnode(node,MDP.Bname{1});