function   str = HAI_TreeLevelTime_LocationFun(MDP,stree,iT)
% function str = HAI_TreeLevelTime_LocationFun(MDP,stree,iT)
state =MDP.s(2,iT);
str=HAI_retrieveLevel(MDP.sname{2}{state},' ');
