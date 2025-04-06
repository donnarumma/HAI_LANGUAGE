function   [Spikes,time,FiringRates,SpS,popFiringRates] = HAI_fromPtoSpikes(MDP,par)
% function [Spikes,time,FiringRates,SpS] = HAI_fromPtoSpikes(MDP,par)
% return:
% Spikes     - nCells x nTimes
% time       - 1 x nTimes (in seconds)
% potentials - nPopulations x nTimes
% SpS        - struct with time of spikes

xn          = MDP.xn{par.factor};
[nBins,nStates,nEpochs,~]=size(xn);

% reassemble probabilities as 
% nStates*nEpochs (nPopulations) x nBins*nEpochs (nTimes)
popFiringRates = reshape(xn,nBins,nStates*nEpochs,nEpochs);
popFiringRates = permute(popFiringRates,[2,1,3]);
popFiringRates = reshape(popFiringRates,nStates*nEpochs,nBins*nEpochs);

Nnr         = par.Nnr;      % Number of duplicate neurons per population
Nev         = par.Nev;      % Number of duplicate events
SpT         = par.SpT;      % Threshold to spikes
dt          = par.dt;       % time of one bin
TotalNev    = sum(Nev);
if length(Nev)==nEpochs
    FiringRates= nan(Nnr*nStates*nEpochs,TotalNev*nBins*nEpochs);
    iStart  = 0;
    % Spikes  = [];
    for iEpoch=1:nEpochs
        % Spikes = [Spikes, kron(probs(:,inds),ones(Nnr,Nev(iEpoch)*nEpochs))];
        inds   = (iEpoch-1)*nBins+1:(iEpoch*nBins);
        iEnd   = iStart+Nev(iEpoch)*nBins*nEpochs;
        FiringRates(:,(iStart+1):iEnd)=kron(popFiringRates(:,inds),ones(Nnr,Nev(iEpoch)*nEpochs));
        iStart = iEnd;
    end
else
    % Nev        = sum(Nev);
    FiringRates = kron(popFiringRates,ones(Nnr,TotalNev));
end
cap         = 0.8;
FiringRates(FiringRates>cap)=cap;
Spikes      = rand(size(FiringRates)) > FiringRates*(1 - SpT) + par.th;
Spikes      = ~Spikes;
time        = (1:TotalNev*nBins*nEpochs)*dt;

iCell       = 0;
nCells      = nStates*nEpochs*Nnr;
str         = cell(nCells,1);
for iEpoch=1:nEpochs 
    for iState=1:nStates
        %imod       = mod(0:nStates-1,nStats)+1;
        for iRep=1:Nnr
            iCell      = iCell+1;
            str{iCell} = sprintf('%s: t=%i',MDP.label.name{par.factor}{iState},iEpoch);
        end
    end
end
%nCells      = size(Spikes,1);
SpS.t       = cell(1,nCells); % vdm structure

for iC=1:nCells
    SpS.t{1,iC}     = time(Spikes(iC,:)>0);
    SpS.label{iC}   = str{iC};%sprintf('c%g',iC);
end
SpS.tvec    = time;
%%
return
