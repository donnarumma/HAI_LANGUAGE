function s=printActualStates(MDP,t) 
% function printActualStates(MDP,t) 

states=MDP.s(:,t);
s=sprintf('Actual States\n');
for ind=1:length(states)
    sna         =MDP.Aname{ind};
    sen         =MDP.sname{ind};
    indstate    =states(ind);
    recstate    =sen{indstate};
    if iscell(sen{1})
        recstate=reconstructSentence(recstate);
    end
    s=sprintf('%s%s=%g (%s)\n',s,sna,indstate,recstate);
end

if nargout==0
    fprintf('%s\n',s);
end
