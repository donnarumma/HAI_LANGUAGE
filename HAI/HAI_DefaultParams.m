function   params=HAI_DefaultParams(dictionary)
% function params=HAI_DefaultParams(dictionary)
params.irng         ='default';
params.idhighest    =1;
params.imode        =0;                             % to emulate Friston (Ryan Smith version) default is 1 and (should make) makes its behaviour 
                                                    % overimposable to Friston's code. 
                                                    % Ht make do not overwrite past hidden states
                                                    % probabilities at the end of the run (OPTIONS.HT)
params.sX           =[1,1];                         % code on s: with 1 s becomes sample guess when s assumes initial values -1
params.DICTIONARY                       = str2func(dictionary);                                                       
DICTIONARY                              = params.DICTIONARY();
params.version                          ='v12';         
% params.maxT                           =[ 3 5];     % Friston default

params.getDescription                   = str2func('HAI_getDescription');
NLevels=length(DICTIONARY.STATES);
for iLev=1:NLevels
    %% states
    params.level(iLev).STATES           = DICTIONARY.STATES{iLev};     
    params.level(iLev).StateName        = DICTIONARY.StateNames{iLev}; 
    %% observations
    params.level(iLev).OBS              = DICTIONARY.OBS{iLev};        
    params.level(iLev).ObsName          = DICTIONARY.ObsNames{iLev};   
    %% noise on  likelihood p( obs|state )
    params.level(iLev).obsnoise         = zeros(1,2 + ~isempty(DICTIONARY.CLASSES{iLev}));
    %% noise on transitions p(state(t+1)|state(t),action)
    params.level(iLev).statesnoise      = zeros(1,2 + ~isempty(DICTIONARY.CLASSES{iLev}));
    %%
    params.level(iLev).CLASSES          = DICTIONARY.CLASSES{iLev};
    params.level(iLev).maxT             = 20;                               % max time depth per level  (Default 20)
    params.level(iLev).create           = str2func('HAI_buildLevel');       % initialization function   (Default HAI_createLevel)
    params.level(iLev).getA             = str2func('HAI_getA_Likelihood');  % likelihood function       (Default HAI_getA_Likelihood)
    params.level(iLev).getB             = str2func('HAI_getB_Transitions');% Transition Matrix
    params.level(iLev).SaccadesLocation = true;                         % point to the first state of the second factor
    params.level(iLev).plan2D           = [];                        % planar navigation
    params.level(iLev).MDP              = [];                           % sublevel (Default empty sublevel) 
    
    params.level(iLev).C                = []; % preferences                           % sublevel (Default empty sublevel) 
    
    params.level(iLev).VBNi             = 16;                           % number of iterations of variational bayes
    params.level(iLev).jump             = 1;                            % 1 location can be reached from any state | 0 sequential location steps
    params.level(iLev).umode            =-1;                            % DEPRECATED: -1 all possible policies, 0 remove policy [1,1,1]
    params.level(iLev).chi              = 1/64;                         % Occams window for deep updates
    params.level(iLev).tau              = 2;                            % update time constant -> high -> low convergenge of the gradient but more stable
    params.level(iLev).factor           = [];                           % exit factor on upper level 2: I am sure of the sentence;
    
    params.level(iLev).V                = [];            

    params.level(iLev).level            = iLev;                         % level number (higher level in hiearchy -> higher numbers)
    params.level(iLev).location_priors  = 0;                            % priors on locations (default 0) | 0 flat, 1 Poisson with LocPrLambda parameter
    params.level(iLev).LocPrLambda      = 6;                            % LocPrLambda parameter for Poisson priors (Default 6)
    params.level(iLev).alpha            = 512;                          % softmax parameter for action selection (Default 512). if Poisson Priors, good alpha=4 
    params.level(iLev).unknown          = false;   % if CLASSES is present add 'unknown' class together with 'null' report 
    params.level(iLev).maskval          = 0;       % uniform
end

% simulation function
% params.spm_MDP_VB_H                = str2func('spm_MDP_VB_X_tutorial_debug_v0');      % Friston original
% params.spm_MDP_VB_H                = str2func('spm_MDP_VB_X_tutorial_debug_v2_bis');  % Friston simulation with friendly variable
% params.spm_MDP_VB_H                = str2func('spm_MDP_VB_X_tutorial_debug_v11');     % Last debug version
params.spm_MDP_VB_H                  = str2func('VB_MDP');                              % Latest version

params.debugmode                     = false;       % 1 verbose printing mode
