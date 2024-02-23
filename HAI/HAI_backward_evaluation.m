%% beackward level evaluation
function Back_final = HAI_backward_evaluation(MDP)
%MDP is the model
if MDP.Hname == ['Level 3']
    backw_lev1 = 0;
    backw_lev2 = 0;  
    backw_lev3 = 0;
    for i=1:length(MDP.mdp)
        mdp_lev2 = MDP.mdp(i);
        for j = 1:length(mdp_lev2.mdp)
            mdp_lev1 = mdp_lev2.mdp(j);
            if mdp_lev1.T ~= 1
                for k = 1:length(mdp_lev1.o)-1
                    if mdp_lev1.o(2,k+1) <= mdp_lev1.o(2,k)
                        backw_lev1 = backw_lev1 +1;
                    end
                end
            end
        end
    end    
    Back_final(1,1)= backw_lev1;

    % Backward saccades of level 2
    for j = 1:length(MDP.mdp)  
        mdp_lev2 = MDP.mdp(j);
        for k = 1:length(mdp_lev2.o)-1
            if mdp_lev2.T ~= 1
                if mdp_lev2.o(2,k+1) <= mdp_lev2.o(2,k)
                    backw_lev2 = backw_lev2 + 1;
                end
            end
        end
    end
  
    Back_final(1,2)= backw_lev2;

    % Backward saccades of level 3
    for i=1:size(MDP.o,2)-1
        if MDP.T ~= 1
            if MDP.o(2,i+1) <= MDP.o(2,i)
                backw_lev3 = backw_lev3 +1;
            end
        end
    end
    Back_final(1,3)= backw_lev3;
    
elseif MDP.Hname == ['Level 2']
    % Backward saccades of level 1
    backw_lev1 = 0;
    backw_lev2 = 0;  

    for i=1:length(MDP.mdp)
        mdp_lev1 = MDP.mdp(i);
            if mdp_lev1.T ~= 1
                for k = 1:length(mdp_lev1.o)-1
                    if mdp_lev1.o(2,k+1) <= mdp_lev1.o(2,k)
                        backw_lev1 = backw_lev1 +1;
                    end
                end
            end
    end    
    Back_final(1,1)= backw_lev1;

    % Backward saccades of level 2
    for i=1:length(MDP.o)-1
        if MDP.T ~= 1
            if MDP.o(2,i+1) <= MDP.o(2,i)
                backw_lev2 = backw_lev2 +1;
            end
        end
    end
    Back_final(1,2)= backw_lev2;
end