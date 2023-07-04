function   state = TREE_LevelTime_cumsumRT(MDP,stree,iT)
% function state = TREE_LevelTime_cumsumRT(MDP,stree,iT)
if iT==0
    state='.';
else
    cumsumrt=cumsum(MDP.rt);
    state = cumsumrt(iT);
end

