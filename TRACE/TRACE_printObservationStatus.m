function   s=TRACE_printObservationStatus(MDP,t,obname)
% function s=TRACE_printObservationStatus(MDP,t,obname)

observation = MDP.(obname)(:,t);
s           = sprintf('%s=',obname);
gs          ='(';
gl          ='(';
Bnames      = MDP.(['Bname']);
onames      = MDP.oname;
for is=1:length(observation)
    gs=sprintf('%s%s=%g,',gs,Bnames{is},observation(is));
    gl=sprintf('%s%s,',gl,HAI_retrieveLevel(onames{is}{observation(is)}));
end
gs(end)     = ')';
gl(end)     = ')';
s           = sprintf('%s%s - %s',s,gs,gl);
if nargout==0
    fprintf('%s\n',s);
end
