function    params= HAI_initialiseParams(params)
%% function params= HAI_initialiseParams(params)

maxTs= [params.level(:).maxT,1];
for iLev=1:length(params.level)
    params.level(iLev).s = zeros(~isempty(params.level(iLev).CLASSES)+2,maxTs(iLev),maxTs(iLev+1));
end
params.Ht=params.imode;  %% to be removed