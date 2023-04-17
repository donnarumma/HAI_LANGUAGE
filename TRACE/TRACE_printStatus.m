function   s=TRACE_printStatus(MDP,t,vname,mname)
% function s=TRACE_printStatus(MDP,t,vname,mname)

observation = MDP.(vname)(:,t);
s           = sprintf('%s=',vname);
gs          ='(';
gl          ='(';
mnames      = MDP.([mname 'name']);
vnames      = MDP.([vname 'name']);
for is=1:length(observation)
    gs=sprintf('%s%s=%g,',gs,mnames{is},observation(is));
    gl=sprintf('%s%s,',gl,HAI_retrieveLevel(vnames{is}{observation(is)}));
end
gs(end)     = ')';
gl(end)     = ')';
s           = sprintf('%s%s - %s',s,gs,gl);
if nargout==0
    fprintf('%s\n',s);
end
