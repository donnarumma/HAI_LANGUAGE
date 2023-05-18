function   str = TREE_LevelTime_LocationName(MDP,stree,iT)
% function str = TREE_LevelTime_LocationName(MDP,stree,iT)
state =MDP.s(2,iT);
str=HAI_retrieveLevel(MDP.sname{2}{state},' ');
