function   s=TRACE_printStateStatus(MDP,t,statename)
% function s=TRACE_printStateStatus(MDP,t,statename)

State = MDP.(statename)(:,t);
s=sprintf('%s=',statename);
gs='(';gl='(';
snames= MDP.([statename 'name']);
Anames= MDP.(['Aname']);
for is=1:length(State)
    gs=sprintf('%s%s=%g,',gs,Anames{is},State(is));
    recsentence=HAI_retrieveLevel(snames{is}{State(is)});
    gl=sprintf('%s%s,',gl,recsentence);
end
gs(end)=')';
gl(end)=')';
s=sprintf('%s%s - %s',s,gs,gl);
if nargout==0
    fprintf('%s\n',s);
end
    