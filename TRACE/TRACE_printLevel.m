function   s=TRACE_printLevel(MDP,D)
% function s=TRACE_printLevel(MDP,D)

s=TRACE_printLevelID(MDP,0,'Hname');
s=sprintf('%s\n',s);
for ind=1:length(MDP.Aname)
    sna=MDP.Aname{ind};
    stn=MDP.sname{ind};
    for is=1:length(stn)
        s=sprintf('%s%s(%g):%s\n',s,sna,is,HAI_retrieveLevel(stn{is},D));
    end
end
if nargout==0
    fprintf('%s\n',s);
end
