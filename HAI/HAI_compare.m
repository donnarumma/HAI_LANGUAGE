function   HAI_compare(MDP1,MDP2,LEVEL)
% function HAI_compare(MDP1,MDP2)

try
    level=LEVEL;
catch
    level=MDP1.level;
    fprintf('Comparing level %g\n',MDP1.level);
end
params.printEqual       =0;
params.pauseNotEqual    =0;
    
compareStructs(MDP1,MDP2,params);
if isfield(MDP1,'MDP') && isfield(MDP2,'MDP')
    N=length(MDP1.mdp);
    if length(MDP1.mdp)~=length(MDP2.mdp)
        fprintf('mdp are NOT equal\n');
    end
    % fprintf('Comparing sublevel %g\n',MDP1.mdp(1).level);
    for in=1:N
        fprintf('Comparing level %g mdp(%g)\n',MDP1.mdp(in).level,in); 
        HAI_compare(MDP1.mdp(in),MDP2.mdp(in),level)
        % compareStructs(MDP1.mdp(in),MDP2.mdp(in),params);
    end
        
end
end
