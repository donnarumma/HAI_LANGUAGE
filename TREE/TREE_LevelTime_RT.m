function   state = TREE_LevelTime_RT(MDP,stree,iT)
% function state = TREE_LevelTime_RT(MDP,stree,iT)
if iT==0
    state='.';
else
    state = MDP.rt(iT);
end

