function   state = TREE_LevelTime_t(MDP,stree,iT)
% function str = TREE_LevelTime_LocationName(MDP,stree,iT)
if iT==0
    state='.';
else
    state =MDP.level;
 end