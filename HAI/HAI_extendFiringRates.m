function   [FiringRates,timeFR,labEpochs] = HAI_extendFiringRates(popFiringRates,nBins,Nnr,Nev,dt)
% function [data_trials] = HAI_extendFiringRates(popFiringRates,par)
% return:
% Spikes     - nCells x nTimes
% time       - 1 x nTimes (in seconds)
% potentials - nPopulations x nTimes
% SpS        - struct with time of spikes

% xn          = MDP.xn{par.factor};
% [nBins,nStates,nEpochs,~]=size(xn);

% popFiringRates probabilities as 
% nStates*nEpochs (nPopulations) x nBins*nEpochs (nTimes)

% Nnr:      Number of duplicate neurons per population
% Nev:      Number of duplicate events
% nBins:    Number of bin updated
% dt:       time of one bin
TotalNev    = sum(Nev);
nEpochs     = length(Nev); %par.nEpochs;%
nStates     = size(popFiringRates,1)/nEpochs;
labEpochs   = nan(1,TotalNev*nBins*nEpochs);
if length(Nev)==nEpochs
    FiringRates= nan(Nnr*nStates*nEpochs,TotalNev*nBins*nEpochs);
    iStart  = 0;
    % Spikes  = [];
    for iEpoch=1:nEpochs
        % Spikes = [Spikes, kron(probs(:,inds),ones(Nnr,Nev(iEpoch)*nEpochs))];
        inds   = (iEpoch-1)*nBins+1:(iEpoch*nBins);
        iEnd   = iStart+Nev(iEpoch)*nBins*nEpochs;
        FiringRates(:,(iStart+1):iEnd)  = kron(popFiringRates(:,inds),ones(Nnr,Nev(iEpoch)*nEpochs));
        labEpochs(:,(iStart+1):iEnd)    = iEpoch*ones(1,length(inds)*Nev(iEpoch)*nEpochs);
        iStart = iEnd;
    end
else
    % Nev        = sum(Nev);
    FiringRates = kron(popFiringRates,ones(Nnr,TotalNev));
end

timeFR          = (1:TotalNev*nBins*nEpochs)*dt;
% data_trials.firingRates     = FiringRates;
% data_trials.timeFiringRates = time;
% data_trials.labEpochs       = labEpochs;
return