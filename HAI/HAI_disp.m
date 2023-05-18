function   [tree_struct]=HAI_disp(MDP)
% function [tree_struct]=HAI_disp(MDP)
% if nargin > 0 returns tree_struct with MDP execution info and structure
structures = TREE_getMDP(MDP,@TREE_Level_States,@TREE_Append_Obs);
[description] = TREE_getMDPStructure(MDP);

[str_desc] = TREE_getMDPTime(MDP,@TREE_LevelTime_Location,@TREE_Append_NULL);

[lstree]=TREE_getMDPStructureStates(MDP);
[loc_desc]=TREE_getMDPStructureLocations(MDP);

tree_struct.description           = description;
tree_struct.structures            = structures;
tree_struct.structures_description= lstree;
tree_struct.locations             = str_desc;
tree_struct.locations_description = loc_desc;
if nargout < 1
    disp([description.tostring,structures.tostring,lstree.tostring,str_desc.tostring,loc_desc.tostring,]);
end
