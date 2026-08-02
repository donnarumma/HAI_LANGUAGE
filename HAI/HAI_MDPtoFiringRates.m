function   [popFiringRates,time,labEpochs] = HAI_MDPtoFiringRates(MDP,factor,dt)
%function  [popFiringRates,time,labEpochs] = HAI_MDPtoFiringRates(MDP,factor,dt)
% return:
% Spikes     - nCells x nTimes
% time       - 1 x nTimes (in seconds)
% popFiringRates - nPopulations x nTimes
% where - nPopulations = nStates*nEpochs
%       - nTimes       = nBins*nEpochs

xn                          = MDP.xn{factor};
[nBins,nStates,nEpochs,~]   = size(xn);
% dt                          = par.dt;

% reassemble probabilities as
% nStates*nEpochs (nPopulations) x nBins*nEpochs (nTimes)
popFiringRates = reshape(xn,nBins,nStates*nEpochs,nEpochs);
popFiringRates = permute(popFiringRates,[2,1,3]);
popFiringRates = reshape(popFiringRates,nStates*nEpochs,nBins*nEpochs);
time           = (1:nBins*nEpochs)*dt;
% data_trials.firingRates     = popFiringRates;
% data_trials.timeFiringRates = time;
% data_trials.nBins           = nBins;
% data_trials.nEpochs         = nEpochs;
labEpochs = [];
for iEpoch=1:nEpochs
    labEpochs   = [labEpochs, iEpoch*ones(1,nBins)];
end
% data_trials.labEpochs       = labEpochs;