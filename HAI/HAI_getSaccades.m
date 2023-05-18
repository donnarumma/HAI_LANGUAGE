function   [num]=HAI_getSaccades(MDP)
% function [num]=HAI_getSaccades(MDP)
    stree=HAI_disp(MDP);
    num=length([stree.locations.Node{stree.locations.findleaves}]);
end