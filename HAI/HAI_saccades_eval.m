%% Number of saccades evaluation
% Sacc_level is the number of saccades for each level,
% Sacc_total is the number of total saccades of all level
function [Sacc_level,Sacc_total] = HAI_saccades_eval(MDP)

if MDP.Hname == ['Level 3']
    % Number of Word-saccades, syllable-saccades and Letter-saccades
    % evaluaion
    sacc_lev3 = zeros(length(MDP.mdp),max([MDP.mdp.T]));
    for i = 1:length(MDP.mdp)
        mdp_lev2 = MDP.mdp(i);
        for j = 1:length(mdp_lev2.mdp)
            sacc_lev3(i,j) = mdp_lev2.mdp(j).T;
        end
    end

    Sacc_level  = sacc_lev3';
    
    % Number of total saccades evaluation
    Sacc_total = sum(Sacc_level,'all');

elseif MDP.Hname == ['Level 2']
    % Number of Word-saccades, syllable-saccades and Letter-saccades
    % evaluaion
    sacc_lev2 = zeros(length(MDP.mdp));
    for i = 1:length(MDP.mdp)
        mdp_lev1 = MDP.mdp(i);
            sacc_lev2(i) = mdp_lev1.T;
    end
    Sacc_level = sacc_lev2';
    Sacc_total = sum(Sacc_level,'all');
end