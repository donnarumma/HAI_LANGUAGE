function   [STEPS]=HAI_GetLevelSteps(MDP,level)
% function [STEPS]=HAI_MDPSTEPS(MDP)
% Ne = size(MDP.xn{1},4);      % number of epochs

steptree  = TREE_getMDPTime(MDP,@TREE_LevelTime_Steps,@TREE_Append_NULL);
depthtree = steptree.depthtree;

dfi=steptree.depthfirstiterator;
STEPS = 0;
for idfi=dfi %1:length(dfi)
    lev=get(depthtree,idfi);
    if level==MDP.level+1-lev
        STEPS = STEPS+get(steptree,idfi);
    end
end
% STEPS = size(MDP.xn{1},1); 