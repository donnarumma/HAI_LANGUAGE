function   str = HAI_TreeLevel_StateFun(MDP,stree)
% function str = HAI_TreeLevel_StateFun(MDP,stree)
state = MDP.s(1,end);
str   = '';
for is=1:length(state)
    retrstate=HAI_retrieveLevel(MDP.sname{1}{state(is)},' ');
    strpre=[str ' sL' num2str(MDP.level) '('];
    strpos=[')=' retrstate];
end
if isempty(stree)
    inode=0;
else
    inode=stree.nnodes;
end
str     =[strpre num2str(inode) strpos];
return

    % t=stree.depthfirstiterator;  % str = [strpre num2str(t(end)) strpos]; 
    % str     =[strpre num2str(stree.nnodes) strpos];
% end