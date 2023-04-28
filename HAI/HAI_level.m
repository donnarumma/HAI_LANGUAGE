function   [states,levlabel] = HAI_level(MDP,Dspace) 
% function [states,levlabel] = HAI_level(MDP,Dspace) 
    levlabel=MDP.Bname{1};
    states=MDP.sname{1};
    for is = 1:length(states)
        states{is}= [HAI_retrieveLevel(states{is},Dspace)];
    end
end