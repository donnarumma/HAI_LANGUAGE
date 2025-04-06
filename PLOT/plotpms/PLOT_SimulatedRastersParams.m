function   par = PLOT_SimulatedRastersParams(parSource)
% function par = PLOT_SimulatedRastersParams(parSource)
par.exec        = true;
par.hfig        = [];
par.factor      = 1;
par.nla         = 0.05;  % neuron line alpha
par.sa          = 0.1;   % step alpha
% par.z           = [];
par.humanlike   = false;
par.RTstretch   = false;
par.t0          = 0;
par.Ne          = [];   % number of epochs
par.Nx          = [];   % number of states
par.Nb          = [];   % number of bin per epoch
par.dt          = 1/64; % sampling rate (time of each bin)
try
    fnames=fieldnames(parSource);
    for in=1:length(fnames)
        par.(fnames{in})=parSource.(fnames{in});
    end
catch
end
end