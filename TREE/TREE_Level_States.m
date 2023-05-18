function   str = TREE_Level_States(MDP,stree)
% function str = TREE_Level_States(MDP,stree)
state = MDP.s(1,end);
str   = HAI_retrieveLevel(MDP.sname{1}{state},' ');