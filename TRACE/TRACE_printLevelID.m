function   s=TRACE_printLevelID(MDP,t,Hname)
% function s=TRACE_printLevelID(MDP,t,Hname)

s=sprintf('%s, Time %g:',MDP.(Hname),t);
if nargout==0
    fprintf('%s\n',s);
end
