function   state = TREE_LevelTime_Location(MDP,stree,iT)
% function str = TREE_LevelTime_Location(MDP,stree,iT)
if iT==0
    state='.';
else
    state =MDP.s(2,iT);
end