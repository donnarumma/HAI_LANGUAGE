function   L = HAI_Likelihood(P,M,~,Y)
% function L = HAI_Likelihood(P,M,~,Y)
% Likelihood function for model fitting.

L = 0;

mdp(1)   = M.G(P);
mdp(2)   = M.G(P); 

% Assign outcomes
%--------------------------------------------------------------------------
for i = 1:mdp(1).T                                                         
    mdp(1).mdp(i).o = Y.o{i}(:,1:2);                                       
    mdp(2).mdp(i).o = Y.o{i}(:,3:4);                                       
end

% Invert model (forcing it to take same actions)
%--------------------------------------------------------------------------

 
% % Evaluate likelihood of actions
% %--------------------------------------------------------------------------
%     for i = 2:length(MDP(1).mdp)
%         x1 = [];
%         x2 = [];
%         for k = 1:size(MDP(1).mdp(i).xn{1},1)                              
%             for j = 1:numel(MDP(1).mdp(i).xn)                              
%                 xn{j} = MDP(1).mdp(i).xn{j}(end,:,2,1);                    
%             end
%             x1(:,end+1) = spm_softmax(MDP(1).mdp(i).lambda*spm_log(spm_dot(MDP(1).mdp(i).A{4},xn)));
% 
%             for j = 1:numel(MDP(2).mdp(i).xn)                              
%                 xn{j} = MDP(2).mdp(i).xn{j}(end,:,2,1);                    
%             end
%             x2(:,end+1) = spm_softmax(MDP(2).mdp(i).lambda*spm_log(spm_dot(MDP(2).mdp(i).A{4},xn))); 
% 
%             L = L + spm_log(x1(MDP(1).mdp(i).o(4,2),end)) + spm_log(x2(MDP(2).mdp(i).o(4,2),end));
%         end
%     end
% 
% end

% Evaluate likelihood of reaction times
%--------------------------------------------------------------------------
RT = HAI_(MDP(1));

L = L + sum(log( spm_Npdf(log(Y.r), RT' - log(2), 1/256 )));
end
