function   stree=HAI_TreeAppend_ObsFun(MDP,stree,node)
% function stree=HAI_TreeAppend_ObsFun(MDP,stree,node)

obs =MDP.o(1,:);
for is=1:length(obs)
    retrstr=HAI_retrieveLevel(MDP.oname{1}{obs(is)});
    if isempty(retrstr)
        retrstr=char(248);
    end
    strpre=['oL' num2str(MDP.level) '('];
    strpos=[')='  retrstr];
    t=stree.depthfirstiterator;   
    str     = [strpre num2str(t(end)) strpos];
    stree = stree.addnode(node,str);
end