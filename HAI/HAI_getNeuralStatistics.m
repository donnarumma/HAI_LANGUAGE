function   hai_neu = HAI_getNeuralStatistics(MDP,params)
% function hai_neu = HAI_getNeuralStatistics(MDP,params)

factor = params.factor;

Nt = length(MDP);                    % number of trials
Ne = size(MDP(1).xn{factor},4);      % number of epochs
Nx = size(MDP(1).D{factor}, 1);      % number of states
Nb = size(MDP(1).xn{factor},1);      % number of time bins per epochs
if params.fakeneuron
    Nx=Nx+params.fakeneuron;
elseif params.killNNeurons
    for ik=1:Nx
        roms=sum(MDP(1).xn{factor}(:,ik,:,:));
        bads(ik)=sum(roms(:));
    end
    Nx=Nx-sum(params.killNNeurons);
end
% units to plot
%--------------------------------------------------------------------------
UNITS   = [];
for ie = 1:Ne
    for jx = 1:Nx
        UNITS(:,end + 1) = [jx;ie];
    end
end

% summary statistics
%==========================================================================
for i = 1:Nt   
    % all units
    %----------------------------------------------------------------------
    str    = {};
    xn = MDP(i).xn{factor};
    if params.maxVBxn               % less VB iterations
        xn=xn(1:params.maxVBxn,:,:,:);
        Nb = size(xn,1);  
    end
    if params.fakeneuron
        xxn=xn;
        xxn(:,Nx-params.fakeneuron+(1:params.fakeneuron),:,:)=zeros(Nb,params.fakeneuron,Ne,Ne);
        xn=xxn;
    elseif params.killNNeurons
        xxn=xn;
        % xxn(:,[21:40,end-params.killNNeurons(1)+1:end],:,:)=[];
        xxn(:,end-params.killNNeurons(1)+1:end,:,:)=[];
        xn = xxn;
    end
    for j = 1:size(UNITS,2)
        for k = 1:Ne
            try
                zj{k,j} = xn(:,UNITS(1,j),UNITS(2,j),k);
            catch
                fprintf('wtf\n');
            end
            xj{k,j} = gradient(zj{k,j}')';
        end
        % str{j} = sprintf('%s: t=%i',MDP(1).label.name{f}{UNITS(1,j)},UNITS(2,j));
        % str{j} = sprintf('(%i,%i):',UNITS(1,j),UNITS(2,j));
        % str{j} = sprintf('%s:%i)',MDP(1).Aname{2},UNITS(2,j));
        str{j} = sprintf('C^{%g}_{%g}: t=%i',MDP(1).level,UNITS(1,j),UNITS(2,j));
    end
    z{i,1} = zj;
    x{i,1} = xj;
    
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
hai_neu.z=z;  % neuron potentials
hai_neu.x=x;  % difference in potential neurons
hai_neu.str=str;
