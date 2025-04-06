function [Spikes] = HAI_fireToSpikes(FiringRates,par)
% cap         = 0.8;
cap         = par.cap;
th          = par.th;
SpT         = par.SpT;
FiringRates(FiringRates>cap)=cap;
Spikes      = rand(size(FiringRates)) > FiringRates*(1 - SpT) + th;
Spikes      = ~Spikes;
return
%%
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

