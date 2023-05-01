function   params=PLOT_defaultParams()
% function params=PLOT_defaultParams()

params.hfig         = [];   % pointer to the figure. If not present new figure is created
params.NUMBW_LINE   = 11;   % number of words for line
params.INT_LINE     = 0.2;  % interline length
params.STEP         = [];   % choose last step
params.GT           = [];   % text read. If not present take the most probable
params.SAVE_MOVIE   = [];   % name of directory to save picture of the saccades
params.ms           = 5;    % marker size of the saccadic points
params.lw           = 2;    % linewidth of the saccadic lines
