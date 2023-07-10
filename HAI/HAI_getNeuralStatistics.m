function   hai_neu = HAI_getNeuralStatistics(MDP,params)
% function hai_neu = HAI_getNeuralStatistics(MDP,params)

factor = params.factor;

Nt = length(MDP);                    % number of trials
Ne = size(MDP(1).xn{factor},4);      % number of epochs
Nx = size(MDP(1).D{factor}, 1);      % number of states
Nb = size(MDP(1).xn{factor},1);      % number of time bins per epochs

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
