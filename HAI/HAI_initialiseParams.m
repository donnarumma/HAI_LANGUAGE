function    params= HAI_initialiseParams(params)
%% function params= HAI_initialiseParams(params)

% maxTs= [params.level(:).maxT,1];
for iLev=1:length(params.level)
    % params.level(iLev).s = zeros(~isempty(params.level(iLev).CLASSES)+2,maxTs(iLev),maxTs(iLev+1));
    params.level(iLev).s    = zeros(~isempty(params.level(iLev).CLASSES)+2,params.level(iLev:end).maxT);
    % D matrix: Prior beliefs about Initial state
    % structure priors - no hint 
    params.level(iLev).D{1} = ones(length(params.level(iLev).STATES),1);
    % location  priors: point to the first element
    params.level(iLev).D{2}    = zeros(length(params.level(iLev).STATES{1}),1);
    params.level(iLev).D{2}(1) = 1;
    % context   priors (if context present)
    if ~isempty(params.level(iLev).CLASSES)
        params.level(iLev).D{3} = ones(length(params.level(iLev).CLASSES)+params.level(iLev).unknown,1);
    end
end
params.Ht=params.imode;  %% to be removed
