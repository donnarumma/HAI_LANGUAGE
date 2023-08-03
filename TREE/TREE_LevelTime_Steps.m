function   state = TREE_LevelTime_Steps(MDP,stree,iT)
% function state = TREE_LevelTime_Steps(MDP,stree,iT)
if iT==0
    state='.';
else
    state = HAI_MDPSTEPS(MDP);% MDP.X{1}(MDP.s(1),iT);
end

