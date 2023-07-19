function   [x,t,dt]=HAI_humanlike(MDP,x,params)
% function [x,rescale,newsteps]=HAI_humanlike(MDP,x)
Nt  = length(MDP);              % number of trials
Nb      = size(x{1}{1},1);      % number of time bins per epochs
Ne      = size(x{1},1);         % number of epochs        
dt      =  1/64;                % time bin (seconds)

probLevel=HAI_getTimeProb(MDP);

fs = (1/3+1/4)/2; % human saccades rate (saccades per second)

if params.humanlike
    rescale=length(probLevel{1})*fs; % seconds rescaled
else
    rescale=1;
end

if params.RTstretch % strecht interval times with Reaction Time 
    for itrial = 1:length(x)
        % maxLen=probLevel{MDP.level}(end);
        exectime=probLevel{MDP.level}(:,2);
        deltas=diff([0;exectime]);
        % newsteps=round(deltas/dt); % with this condition a simulation is ~250 ms
        newsteps=round(Nb*deltas/min(deltas));
        for ie=1:length(newsteps)
            x=extendConverged (x,itrial,ie,newsteps(ie));
        end
    end
else
    newsteps=Ne*Nb;
end
% phase amplitude coupling
%==========================================================================
t = (1:(sum(newsteps)*Nt))*dt;    % time (seconds)
t = t*rescale/t(end);
t = params.t0+t;