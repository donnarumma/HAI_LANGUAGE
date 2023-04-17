function   s=TRACE_printMDP(MDP)
% function s=TRACE_printMDP(MDP)
mMDP=MDP;
s=TRACE_printLevel(mMDP,' ');
while isfield(mMDP,'MDP')
    s1=TRACE_printLevel(mMDP.MDP,'');
    s=sprintf('%s\n%s\n',s,s1);
    mMDP=mMDP.MDP;
end
if nargout==0
    fprintf('%s\n',s);
end
