function   [xdata,t,dt]=HAI_humanlike(MDP,xdata,params)
% function [x,rescale,newsteps]=HAI_humanlike(MDP,x)
Nt      = length(MDP);          % number of trials
Nb      = size(xdata{1}{1},1);      % number of time bins per epochs
Ne      = size(xdata{1},1);         % number of epochs        
dt      = 1/64;                 % time bin (seconds)

% probLevel=params.probLevel;
% fs = (1/3+1/4)/2; % human saccades rate (saccades per second)

if params.humanlike
    % rescale = params.rescale*(length(probLevel{1})*params.fs); % stretch with respect human saccades length
    
    % % rescale = params.rescale*params.numS*params.fs; % stretch with respect human saccades length
    
    % rescale = params.rescale; % seconds rescaled
else
    % rescale= params.rescale;
end

if params.RTstretch % strecht interval times with Reaction Time 
    probLevel=HAI_getTimeProb(MDP);
    for itrial = 1:length(xdata)
        % maxLen=probLevel{MDP.level}(end);
        % exectime=probLevel{MDP.level}(:,2);
        exectime    = probLevel{2}(:,2);   % sub-level RT
        deltas      = diff([0;exectime]);
        % newsteps=round(deltas/dt); % with this condition a simulation is ~250 ms
        newsteps    = round(Nb*deltas/min(deltas));
        for ie=1:length(newsteps)
            xdata   = extendConverged (xdata,itrial,ie,newsteps(ie));
        end
    end

else
    newsteps=Ne*Nb;
end
% phase amplitude coupling
%==========================================================================
t = (1:(sum(newsteps)*Nt));    

               % time (seconds)
% t = t*rescale/t(end);

% t = t*(256/192);
if params.humanlike
    % t=t*rescale/(t(end));
    % t=t*params.fs*params.numS;
    % t=t*params.levsteps/params.sacsteps;
    t=(t*params.fs*params.numS)/params.levsteps;
    % if params.RTstretch
        % t=t*rescale/probLevel{end}(end,2);
else
    t = t*dt;
    % else
        % t=t*rescale/t(end);
    % end    
end
t = params.t0+t;