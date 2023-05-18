function   stree=TREE_Append_Obs(MDP,stree,node)
% function stree=TREE_Append_Obs(MDP,stree,node)

obs =MDP.o(1,:);
for is=1:length(obs)
    str=HAI_retrieveLevel(MDP.oname{1}{obs(is)});
    if isempty(str)
        str=char(248);
    end
    stree = stree.addnode(node,str);
end