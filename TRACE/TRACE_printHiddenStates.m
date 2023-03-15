function s=printHiddenStates(MDP,t,hiddenstatename)
% function s=printStateStatus(MDP,t,statename)
% s       = sprintf('%s, Time %g\n',MDP.Hname,t);
s       = '';
State   = MDP.(hiddenstatename);
Anames  = MDP.(['Aname']);
for is=1:length(State)
    pb      =State{is}(:,t);
    gs      =sprintf('p(%s)=(',Anames{is});
    for ip=1:length(pb)
        gs=sprintf('%s%.2g,',gs,pb(ip));
    end
    gs(end) =')';
    s=sprintf('%s%s\n',s,gs);
end
if nargout==0
    fprintf('%s\n',s);
end
    