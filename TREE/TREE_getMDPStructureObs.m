function   [stree]=TREE_getMDPStructureObs(MDP)
% function [stree]=TREE_getMDPStructureObs(MDP)
stree       =tree('Obs');
node        =1;
str         =['O' num2str(MDP.level)];
[stree,node]=stree.addnode(node,str);
while isfield(MDP,'MDP')
    MDP=MDP.MDP;
    str = ['O' num2str(MDP.level)];
    [stree,node]=stree.addnode(node,str);
end
% stree=stree.addnode(node,MDP.Bname{1});