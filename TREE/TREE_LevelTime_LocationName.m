function   str = TREE_LevelTime_LocationName(MDP,stree,iT)
% function str = TREE_LevelTime_LocationName(MDP,stree,iT)
if iT==0
    str='.';
else
    state =MDP.s(2,iT);
    str=HAI_retrieveLevel(MDP.sname{2}{state},' ');
end