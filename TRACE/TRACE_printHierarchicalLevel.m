function   s=TRACE_printHierarchicalLevel(MDP,t)
% function s=TRACE_printHierarchicalLevel(mdp,t)

s1=TRACE_printLevelID(MDP,t,'Hname');
s2=TRACE_printStateStatus(MDP,t,'s');
s3=TRACE_printObservationStatus(MDP,t,'o');
s4=TRACE_printHiddenStates(MDP,t,'X');

s =sprintf('%s\n%s\n%s\n%s',s1,s2,s3,s4);

if nargout==0
    fprintf('%s\n',s);
end