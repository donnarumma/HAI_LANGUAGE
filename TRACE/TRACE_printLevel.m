function   s=TRACE_printLevel(MDP)
% function s=TRACE_printLevel(mdp)

s=TRACE_printLevelID(MDP,0,'Hname');
s=sprintf('%s\n',s);
for ind=1:length(MDP.Aname)
    sna=MDP.Aname{ind};
    stn=MDP.sname{ind};
    for is=1:length(stn)
        s=sprintf('%s%s(%g):%s\n',s,sna,is,HAI_retrieveLevel(stn{is}));
    end
end
if nargout==0
    fprintf('%s\n',s);
end
