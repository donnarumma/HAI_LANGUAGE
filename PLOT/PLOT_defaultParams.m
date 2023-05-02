function   params=PLOT_defaultParams()
% function params=PLOT_defaultParams()

params.hfig         = [];   % pointer to the figure. If not present new figure is created
params.NUMBW_LINE   = 7;%11;   % number of words for line
params.INT_LINE     = 1;%0.2;  % interline length
params.STEP         = [];      % choose last step
params.GT           = [];      % text to read.  If not present take the most probable
params.GT2          = [];      % text to print. If not present take GT
params.SAVE_MOVIE   = [];      % name of directory to save picture of the saccades
params.ms           = 15;%5;   % marker size of the saccadic points
params.lw           = 8;    % linewidth of the saccadic lines
% params.LETTERSIZE   = 430;%500;%250