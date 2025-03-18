function   hai_neu = HAI_getNeuralStatistics(MDP,params)
% function hai_neu = HAI_getNeuralStatistics(MDP,params)

factor  = params.factor;

nSteps  = length(MDP);                    % number of steps
nEpochs = size(MDP(1).xn{factor},4);      % number of epochs
nStates = size(MDP(1).D{factor}, 1);      % number of states
nBins   = size(MDP(1).xn{factor},1);      % number of time bins per epochs
if params.fakeneuron
    nStates=nStates+params.fakeneuron;
elseif params.killNNeurons
    nStates=nStates-sum(params.killNNeurons);
end
% units to plot
%--------------------------------------------------------------------------
% [iState; iEpoch]
UNITS   = [];
for iEpoch = 1:nEpochs
    for iState = 1:nStates
        UNITS(:,end + 1) = [iState;iEpoch];
    end
end

% summary statistics
%==========================================================================
for iStep = 1:nSteps   
    % all units
    %----------------------------------------------------------------------
    str    = {};
    xn = MDP(iStep).xn{factor};    % nBins x nStates x nEpochs x nEpochs
    if params.maxVBxn               % less VB iterations
        xn=xn(1:params.maxVBxn,:,:,:);
        nBins = size(xn,1);  
    end
    if params.fakeneuron
        xxn=xn;
        xxn(:,nStates-params.fakeneuron+(1:params.fakeneuron),:,:)=zeros(nBins,params.fakeneuron,nEpochs,nEpochs);
        xn=xxn;
    elseif params.killNNeurons
        xxn=xn;
        % xxn(:,[21:40,end-params.killNNeurons(1)+1:end],:,:)=[];
        xxn(:,end-params.killNNeurons(1)+1:end,:,:)=[];
        xn = xxn;
    end
    for j = 1:size(UNITS,2) % nStates*nEpochs
        for iEpoch = 1:nEpochs
            zj{iEpoch,j} = xn(:,UNITS(1,j),UNITS(2,j),iEpoch);
            xj{iEpoch,j} = gradient(zj{iEpoch,j}')';
        end
        % str{j} = sprintf('%s: t=%i',MDP(1).label.name{f}{UNITS(1,j)},UNITS(2,j));
        % str{j} = sprintf('(%i,%i):',UNITS(1,j),UNITS(2,j));
        % str{j} = sprintf('%s:%i)',MDP(1).Aname{2},UNITS(2,j));
        str{j} = sprintf('C^{%g}_{%g}: t=%i',MDP(1).level,UNITS(1,j),UNITS(2,j));
        % str{j} = sprintf('Population Coding C^{%i} (%s x time step)',MDP(1).level,MDP(1).Aname{factor});
    end
    z{iStep,1} = zj;
    x{iStep,1} = xj;
    
    % % selected units
    % %----------------------------------------------------------------------
    % for j = 1:size(UNITS,2)
    %     for k = 1:Ne
    %         vj{k,j} = xn(:,UNITS(1,j),UNITS(2,j),k);
    %         uj{k,j} = gradient(vj{k,j}')';
    %     end
    % end
    % v{i,1} = vj;
    % u{i,1} = uj;
    
    % dopamine or changes in precision
    %----------------------------------------------------------------------
    % dn(:,i) = mean(MDP(i).dn,2);

end
hai_neu.z   = z;                    % neuron potentials
hai_neu.x   = x;                    % difference in potential neurons
hai_neu.str = str;
hai_neu.Ne  = size(z{1},1);         % number of epochs        
hai_neu.Nb  = size(z{1}{1},1);      % number of time bins per epochs
hai_neu.Nx  = size(z{1},2)/nEpochs;      % number of states
