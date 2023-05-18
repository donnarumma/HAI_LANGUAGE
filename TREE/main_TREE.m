% function main_TREE

%% state tree

[stree] = TREE_getMDP(MDP,@TREE_Level_States,@TREE_Append_Obs);
[mtree] = TREE_getMDPStructure(MDP);
% disp([stree.tostring,mtree.tostring]);

guard = TREE_getMDP(MDP,@TREE_Level_StateName,@TREE_Append_ObsName);


% [otree] = TREE_getMDPTime(MDP,@TREE_LevelTime_LocationName,@TREE_Append_NULL);

[vtree] = TREE_getMDPTime(MDP,@TREE_LevelTime_Location,@TREE_Append_NULL);

% N_Saccades=find(vtree)
% fprintf()

% disp([stree.tostring,mtree.tostring,otree.tostring,vtree.tostring]);
[ltree] = TREE_getMDPLevel(MDP);
[lstree]=TREE_getMDPStructureStates(MDP);
[otree]=TREE_getMDPStructureLocations(MDP);
disp([mtree.tostring,stree.tostring,lstree.tostring,vtree.tostring,otree.tostring,]);

