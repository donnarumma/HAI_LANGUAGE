function   [x,rescale,newsteps]=HAI_humanlike(MDP,x)
% function [x,rescale,newsteps]=HAI_humanlike(MDP,x)
Nb      = size(x{1}{1},1);      % number of time bins per epochs
probLevel=HAI_getTimeProb(MDP);
% dt      = 1/64;                 % time bin (seconds)

fs = (1/3+1/4)/2; % human saccades rate (saccades per second)
rescale=length(probLevel{1})*fs; % seconds

for itrial = 1:length(x)
    % maxLen=probLevel{MDP.level}(end);
    exectime=probLevel{MDP.level}(:,end);
    deltas=diff([0;exectime]);
    % newsteps=round(deltas/dt); % with this condition a simulation is ~250 ms
    newsteps=round(Nb*deltas/min(deltas));
    for ie=1:length(newsteps)
        x=extendConverged (x,itrial,ie,newsteps(ie));
    end
end