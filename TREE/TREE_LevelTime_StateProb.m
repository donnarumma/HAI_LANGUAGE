function   state = TREE_LevelTime_StateProb(MDP,stree,iT)
% function state = TREE_LevelTime_StateProb(MDP,stree,iT)
if iT==0
    state='.';
else
    state = MDP.X{1}(MDP.s(1),iT);
end

