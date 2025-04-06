function   par = HAI_fromPtoSpikesParams(parSource)
% function par = HAI_fromPtoSpikesParams(parSource)
par.exec        = true;
par.factor      = 1;    % choose factor of the hidden states
par.Nnr         = 16;   % Number of duplicate neurons per population 
par.Nev         = 16;   % Number of duplicate events
par.SpT         = 1/16; % Threshold to spikes
par.dt          = 1/64; % time duration of one bin (in ms)
par.th          = 0;    % threshold of noise: ([0,1] more spikes, [-1,0] less spikes)
try
    fnames=fieldnames(parSource);
    for in=1:length(fnames)
        par.(fnames{in})=parSource.(fnames{in});
    end
catch
end
end