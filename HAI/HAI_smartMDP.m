function   MDP=HAI_smartMDP(MDP)
% function MDP=HAI_smartMDP(MDP)
ftr ={'A','B','C',...'D', ...
     'V', ...'U', ...
     'R','P','Q','w','link','label','vn','un','wn','dn','nP','O'}; %'MDP','xn'
for iF=1:length(ftr)
    try
        MDP=rmfield(MDP,ftr{iF});
    catch
    end
end
if isfield(MDP,'mdp')
    nT  =length(MDP.mdp);
    for iT=1:nT 
        mdp(iT)=HAI_smartMDP(MDP.mdp(iT));
    end
    MDP.mdp=mdp;
end