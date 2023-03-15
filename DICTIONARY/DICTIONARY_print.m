function   s=DICTIONARY_print(DICTIONARY,Dspace)
% function s=DICTIONARY_print(DICTIONARY,Dspace)
Obs     =DICTIONARY.OBS;
ObsNames=DICTIONARY.ObsNames;
N       = length(Obs)+1;
try
    D=Dspace;
catch
    D=strings(N,1);
    D(end)=' ';
end
s       ='';
for iof = 1:length(ObsNames)
    oname=ObsNames{iof};
    obs  =Obs{iof};
    for ios=1:length(obs)
        s=sprintf('%s%s(%g)=%s\n',s,oname,ios,HAI_retrieveLevel(obs{ios},D{iof}));
    end
end
sname   = DICTIONARY.StateNames{end};
sts     = DICTIONARY.STATES{end};
for iss=1:length(sts)
    s=sprintf('%s%s(%g)=%s\n',s,sname,iss,HAI_retrieveLevel(sts{iss},D{end}));
end
if nargout==0
    fprintf('%s\n',s);
end
return