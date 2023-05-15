function   s=TRACE_printExecution(MDP,MAXDEPTH,PH)
% function s=TRACE_printExecution(MDP,MAXDEPTH)
% s=TRACE_printMDP(MDP);
try 
    maxdepth=MAXDEPTH;
catch
    maxdepth=MDP.level-1;
end
s='';
for it=1:MDP.T
    s=sprintf('%s%s',s,TRACE_printHierarchicalLevel(MDP,it,PH));
    if isfield(MDP,'MDP') && maxdepth>0
        s=sprintf('%s%s',s,TRACE_printExecution(MDP.mdp(it),maxdepth-1,PH));
    end
end
if nargout==0
    fprintf('%s\n',s);
end
return