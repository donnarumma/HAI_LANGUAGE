function   MDP=HAI_createLevel(params)
% function MDP=HAI_createLevel(params)
STATES          = params.STATES;
OBS             = params.OBS;
T               = params.maxT;
obsnoise        = params.obsnoise;
statesnoise     = params.statesnoise;
stnm            = params.StateName;
obnm            = params.ObsName;
lcnm            = [params.ObsName 'Location'];

%% Level State Priors
%==========================================================================
% D matrix: Prior beliefs about Initial state
% D{1} = [1 1 1 1 1 1]';   % Sentences:   {'Sentence1',...,'Sentence6'}
D{1}            = ones(length(STATES),1);
D{2}            = zeros(length(STATES{1}),1);
D{2}(1)         = 1;
% D{2} = [1 0 0 0]';       % Words Location:  {'Location1',...,'Location4'}
forceSimmetry=isempty(params.CLASSES);
if ~isempty(params.CLASSES)
    CLASSES         = params.CLASSES;
    CLASSNAMES      = cell(1,length(CLASSES)+1);
    CLASSNAMES{1}   ='Unk';
    for iC=1:length(CLASSES)
        CLASSNAMES{iC+1}=sprintf('C%g',iC);
    end
    FEEDBACKS={'null','correct','wrong'};
    
    % D{3}    = zeros(length(CLASSES)+1,1);
    % D{3}(1) = 1;                % start with 'unknown'
    D{3}    = ones(length(CLASSES)+1,1);
    % D{3} = [1 0 0 0]';        % report: {'unknown','Eat','Drink','Sleep'}
end

NLocations=length(D{2});
LOCATIONS =cell(NLocations,1);
for iL=1:NLocations
    LOCATIONS{iL}=sprintf('%sL%g',params.ObsName(1:2),iL); 
end
Nf    = numel(D);       %% number of state factors
Ns    = nan(size(D));   %% number of states per factor
for f = 1:Nf
    Ns(f) = numel(D{f});
end
oval    =1-obsnoise;
sval    =1-statesnoise;
%% Level likelihood p(o|s)
% probabilistic mapping from hidden states to outcomes: A
if forceSimmetry
    No  = [length(OBS),length(LOCATIONS)];                  % number of obs per factor
    A   = HAI_getA(OBS,STATES,length(LOCATIONS),oval);
else
    No  = [length(OBS),length(LOCATIONS),length(FEEDBACKS)];% number of obs per factor
    A   = HAI_getAContext(OBS,STATES,CLASSES,length(LOCATIONS),oval);
end
%% Level Transition matrix p(St+1|St)
B       = HAI_getB(Ns,sval,params.jump);
%--------------------------------------------------------------------------
Ng      = length(No);           % number of obs factors
% if context
% allowable policies (specified as the next action) U
% --------------------------------------------------------------------------
if (~forceSimmetry)% && (~params.jump)% || params.umode==0) % deprecated
     try
         mdp.U=HAI_getU(params.umode,CLASSES); % allowable policies
     catch
     end
end
    
if ~forceSimmetry 
    %% Second Level priors: (utility) C 
    %  prior on observations
    %--------------------------------------------------------------------------
    C   = cell(1,Ng);
    for ig = 1:Ng
        C{ig}  = zeros(No(ig),1);
    end
%     C{3}(2,:) =  0;                 % the agent expects to be right
    C{3}(3,:) = -4;                 % and not wrong
    mdp.C = C;                      % preferred outcomes
end
%% MDP structure 
if ~isempty(params.MDP)
    % Link hierarchical connections
    % First factor of S1{1} (words) links to  % numel(MDP.D) are the number of factor of the first level
    % First factor of O2{1} (words) 
    mdp.MDP  = params.MDP;
    mdp.link = sparse(1,1,1,numel(mdp.MDP.D),Ng);  
end
mdp.T = T;                  % number of moves
mdp.A = A;                  % observation model
mdp.B = B;                  % transition probabilities
mdp.D = D;                  % prior over initial states

if forceSimmetry
    mdp.Aname   = {stnm,lcnm};
    mdp.Bname   = {obnm,lcnm};
else
    mdp.Aname   = {stnm,lcnm,'Context' };
    mdp.Bname   = {obnm,lcnm,'Feedback'};
end
if params.chi
    mdp.chi     = params.chi;
    mdp.tau     = 2;                      % alto-convergenza lenta del gradiente ma sistema più stabile
end
mdp.sname{1}= STATES;
mdp.sname{2}= LOCATIONS;
mdp.oname{1}= OBS;
mdp.oname{2}= LOCATIONS;
mdp.level   = params.level;
mdp.Hname   = sprintf('Level %g',mdp.level);

if forceSimmetry
    mdp.Aname=mdp.Aname(1:2);
    mdp.Bname=mdp.Bname(1:2);
else
    mdp.sname{3}= CLASSNAMES;
    mdp.oname{3}= FEEDBACKS;
end
if ~isempty(params.factor)
    mdp.factor=params.factor;
end
 
MDP = spm_MDP_check(mdp);