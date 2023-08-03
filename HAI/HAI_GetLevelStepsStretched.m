function   [STEPS]=HAI_GetLevelStepsStretched(MDP,level)
% function [STEPS]=HAI_GetLevelStepsStretched(MDP,level)
% Ne = size(MDP.xn{1},4);      % number of epochs

steptree  = TREE_getMDP(MDP,@TREE_LevelTime_StepsStretched,@TREE_Append_NULL);
depthtree = steptree.depthtree;
dfi=steptree.depthfirstiterator;
STEPS = 0;
deltas=[];
for idfi=1:length(dfi)
    deltas=[deltas; get(steptree,idfi)];
end
mind=min(deltas);
stretchedTree=steptree;

for idfi=1:length(dfi)
    deltas=get(steptree,idfi);
    stretchedTree=stretchedTree.set(idfi,round(16*deltas/mind));
end


for idfi=dfi %1:length(dfi)
    lev=get(depthtree,idfi)+1;
    if level==MDP.level+1-lev
        STEPS = STEPS+sum(get(stretchedTree,idfi));
    end
end



