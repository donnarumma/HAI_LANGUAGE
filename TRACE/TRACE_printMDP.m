function s=TRACE_printMDP(MDP)
% function printExperiment(mdp)

s1=TRACE_printLevel(MDP);
s2=TRACE_printLevel(MDP.MDP);

try
    s3=TRACE_printActualStates(MDP,1);
catch
    s3='';
end
try
    s4=TRACE_printActualStates(MDP.MDP,1);
catch
    s4='';
end
s =sprintf('%s\n%s\n%s\n%s',s1,s2,s3,s4);

if nargout==0
    fprintf('%s\n',s);
end
