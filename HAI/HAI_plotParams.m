function pltparams=HAI_plotParams(MDP)
% function pltparams=HAI_plotParams()

pltparams.t0            =0;
pltparams.factor        =1; % plot first factor (CONTENT)
pltparams.humanlike     =true; %true;  % true: rescale times for human saccades
pltparams.RTstretch     =true;         % true: use machine reaction time
pltparams.fs            = (1/3+1/4)/2; % human saccades rate (saccades per second)
% pltparams.rescale  =1/probLevel{end}(end,2);  % rescale to 1
pltparams.maxVBxn       = false; %16;
pltparams.hfig          = [];
pltparams.rescale       = 1;
pltparams.Steps         = false; % only for PLOT_TimeProbLevel: if true plot an event for each point
% try
    probLevel               = HAI_getTimeProb(MDP);    
%     rsfactor =(length(probLevel{1})*pltparams.fs)/probLevel{end}(end,2);                    % stretch with respect human saccades lenght
%     rsfactor =rsfactor*(HAI_GetLevelSteps(EXPMDP.MDP,ilev)/HAI_GetLevelSteps(EXPMDP.MDP,1));% stretch with respect VB iterations
%     pltparams.rescale   = rsfactor;
% catch
% end
pltparams.smooth           = false;
pltparams.fakeneuron       = 0;%20;
pltparams.numS          = length(probLevel{1});

pltparams.maxVBxn  = 0;%16;
pltparams.numS     = length(probLevel{1});
pltparams.maxTime  = probLevel{end}(end,2);
pltparams.levsteps = HAI_GetLevelSteps(EXPMDP.MDP,ilev);
pltparams.sacsteps = HAI_GetLevelSteps(EXPMDP.MDP,1);

return
%%%%%%%%%%%%%%%%%%%% PARAMETER FOR L3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pltparams.t0            = 0;
pltparams.factor        = 1; % plot first factor (CONTENT)
pltparams.humanlike     = true; %true;  % true: rescale times for human saccades
pltparams.RTstretch     = false;         % true: use machine reaction time
pltparams.fs            = (1/3+1/4)/2; % human saccades rate (saccades per second)
pltparams.maxVBxn       = 16;
% rsfactor =1*(HAI_GetLevelSteps(EXPMDP.MDP,ilev)/HAI_GetLevelSteps(EXPMDP.MDP,1));% stretch with respect VB iterations
% pltparams.rescale       = rsfactor;
pltparams.Steps         = false;
pltparams.smooth        = true;
pltparams.fakeneuron    = 20;

%%%%%%%%%%%%%%%%%%%% PARAMETER FOR L2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pltparams.hfig      = [];
probLevel           = HAI_getTimeProb(EXPMDP.MDP);
pltparams.probLevel = probLevel;
pltparams.t0        = 0;
pltparams.factor    = 1; % plot first factor (CONTENT)
pltparams.humanlike = true; %true;  % true: rescale times for human saccades
pltparams.RTstretch = false;         % true: use machine reaction time
pltparams.fs        = (1/3+1/4)/2; % human saccades rate (saccades per second)
% pltparams.rescale  =1/probLevel{end}(end,2);  % rescale to 1
pltparams.maxVBxn   = 16;%16;
pltparams.numS      = length(probLevel{1});
pltparams.maxTime   = probLevel{end}(end,2);
pltparams.killNNeurons=[29,20];
if pltparams.maxVBxn
    pltparams.levsteps=HAI_GetLevelStepsFixed(EXPMDP.MDP,ilev,pltparams.maxVBxn);
else
    pltparams.levsteps = HAI_GetLevelSteps(EXPMDP.MDP,ilev);
end

rsfactor =1*(HAI_GetLevelSteps(EXPMDP.MDP,ilev)/HAI_GetLevelSteps(EXPMDP.MDP,1));% stretch with respect VB iterations

pltparams.rescale       = 1;%rsfactor;

pltparams.Steps         = false;
pltparams.smooth        = true;
pltparams.fakeneuron    = 0;
pltparams.ylim          = [];