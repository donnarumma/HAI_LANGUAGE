function rt = HAI_simRT(MDP)
%function rt = HAI_simRT(MDP)
%% ONLY FOR TWO LEVELS
% Simulate reaction times (based upon predictive entropy)
indContext=1; %% letter
rt        = nan(1,length(MDP.mdp)-1);
for i = 2:length(MDP.mdp)
    x = [];
    for k = 1:size(MDP.mdp(i).xn{1},1)
        for j = 1:numel(MDP.mdp(i).xn)
            xn{j} = MDP.mdp(i).xn{j}(k,:,end,1);
            % xn{j} = MDP.mdp(i).xn{j}(k,:,2,1);
        end
        % x(:,end+1) = spm_dot(MDP.mdp(i).A{2},xn);
        x(:,end+1) = spm_dot(MDP.mdp(i).A{indContext},xn);
    end
    v       = -diag(x'*spm_log(x));
    % rt(i-1) = find(v<8/10,1);
    rt(i-1) = v(end);
end