function   s=TRACE_printHierarchicalLevel(MDP,t,PH)
% function s=TRACE_printHierarchicalLevel(mdp,t)
try
    printHidden=PH;
catch
    printHidden=true;
end
s1=TRACE_printLevelID(MDP,t,'Hname');
% s2=TRACE_printStateStatus(MDP,t,'s');
s2=TRACE_printStatus(MDP,t,'s','A');
% s3=TRACE_printObservationStatus(MDP,t,'o');
s3=TRACE_printStatus(MDP,t,'o','B');
if printHidden
    s4=TRACE_printHiddenStates(MDP,t,'X');
else
    s4='';
end
s =sprintf('%s\n%s\n%s\n%s',s1,s2,s3,s4);

if nargout==0
    fprintf('%s\n',s);
end