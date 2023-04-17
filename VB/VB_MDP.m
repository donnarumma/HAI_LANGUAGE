function [MDP] = VB_MDP(MDP,OPTIONS)
fprintf('MDP %s entering %s\n',mfilename,MDP.Hname);
spm_MDP_VB_H=str2func(mfilename);
% active inference and learning using variational message passing
% FORMAT [MDP] = spm_MDP_VB_X_tutorial(MDP,OPTIONS)
%
% Input; MDP(m,n)       - structure array of m models over n epochs
%
% MDP.V(T - 1,P,F)      - P allowable policies (T - 1 moves) over F factors
% or
% MDP.U(1,P,F)          - P allowable actions at each move
% MDP.T                 - number of outcomes
%
% MDP.A{G}(O,N1,...,NF) - likelihood of O outcomes given hidden states
% MDP.B{F}(NF,NF,MF)    - transitions among states under MF control states
% MDP.C{G}(O,T)         - (log) prior preferences for outcomes (modality G)
% MDP.D{F}(NF,1)        - prior probabilities over initial states
% MDP.E(P,1)            - prior probabilities over policies
%
% optional:
% MDP.s(F,T)            - matrix of true states - for each hidden factor
% MDP.o(G,T)            - matrix of outcomes    - for each outcome modality
% or .O{G}(O,T)         - likelihood matrix     - for each outcome modality
% MDP.u(F,T - 1)        - vector of actions     - for each hidden factor
%
% MDP.alpha             - precision - action selection [512]
% MDP.beta              - precision over precision (Gamma hyperprior - [1])
% MDP.chi               - Occams window for deep updates
% MDP.tau               - time constant for gradient descent [4]
% MDP.erp               - resetting of initial states, to simulate ERPs [4]
%
% MDP.link              - link array to generate outcomes from
%                         subordinate MDP; for deep (hierarchical) models
% OPTIONS.plot          - switch to suppress graphics:  (default: [0])
% OPTIONS.gamma         - switch to suppress precision: (default: [0])
% OPTIONS.D             - switch to update initial states over epochs
% OPTIONS.BMR           - Bayesian model reduction for multiple trials
%                         see: spm_MDP_VB_sleep(MDP,BMR)
% Outputs:
%
% MDP.P(M1,...,MF,T)    - probability of emitting action M1,.. over time
% MDP.Q{F}(NF,T,P)      - expected hidden states under each policy
% MDP.X{F}(NF,T)        - and Bayesian model averages over policies
% MDP.R(P,T)            - response: conditional expectations over policies
%
% MDP.un          - simulated neuronal encoding of hidden states    - neuralstates
% MDP.vn          - simulated neuronal prediction error             - neuralprediction
% MDP.xn          - simulated neuronal encoding of policies         - neuralpolicies
% MDP.wn          - simulated neuronal encoding of precision (tonic)- neuralprecision
% MDP.dn          - simulated dopamine responses (phasic)
% MDP.rt          - simulated reaction times
%
% MDP.F           - (P x T) (negative) free energies over time
% MDP.G           - (P x T) (negative) expected free energies over time
% MDP.H           - (1 x T) (negative) total free energy over time
% MDP.Fa          - (1 x 1) (negative) free energy of parameters (a)
% MDP.Fb          - ...
%
% This routine provides solutions of active inference (minimisation of
% variational free energy) using a generative model based upon a Markov
% decision process (or hidden Markov model, in the absence of action). The
% model and inference scheme is formulated in discrete space and time. This
% means that the generative model (and process) are  finite state machines
% or hidden Markov models whose dynamics are given by transition
% probabilities among states and the likelihood corresponds to a particular
% outcome conditioned upon hidden states.
%
% When supplied with outcomes, in terms of their likelihood (O) in the
% absence of any policy specification, this scheme will use variational
% message passing to optimise expectations about latent or hidden states
% (and likelihood (A) and prior (B) probabilities). In other words, it will
% invert a hidden Markov model. When  called with policies, it will
% generate outcomes that are used to infer optimal policies for active
% inference.
%
% This implementation equips agents with the prior beliefs that they will
% maximise expected free energy: expected free energy is the free energy of
% future outcomes under the posterior predictive distribution. This can be
% interpreted in several ways - most intuitively as minimising the KL
% divergence between predicted and preferred outcomes (specified as prior
% beliefs) - while simultaneously minimising ambiguity.
%
% This particular scheme is designed for any allowable policies or control
% sequences specified in MDP.V. Constraints on allowable policies can limit
% the numerics or combinatorics considerably. Further, the outcome space
% and hidden states can be defined in terms of factors; corresponding to
% sensory modalities and (functionally) segregated representations,
% respectively. This means, for each factor or subset of hidden states
% there are corresponding control states that determine the transition
% probabilities.
%
% This specification simplifies the generative model, allowing a fairly
% exhaustive model of potential outcomes. In brief, the agent encodes
% beliefs about hidden states in the past (and in the future) conditioned
% on each policy. The conditional expectations determine the (path
% integral) of free energy that then determines the prior over policies.
% This prior is used to create a predictive distribution over outcomes,
% which specifies the next action.
%
% In addition to state estimation and policy selection, the scheme also
% updates model parameters; including the state transition matrices,
% mapping to outcomes and the initial state. This is useful for learning
% the context. Likelihood and prior probabilities can be specified in terms
% of concentration parameters (of a Dirichlet distribution (a,b,c,..). If
% the corresponding (A,B,C,..) are supplied, they will be used to generate
% outcomes; unless called without policies (in hidden Markov model mode).
% In this case, the (A,B,C,..) are treated as posterior estimates.
%
% If supplied with a structure array, this routine will automatically step
% through the implicit sequence of epochs (implicit in the number of
% columns of the array). If the array has multiple rows, each row will be
% treated as a separate model or agent. This enables agents to communicate
% through acting upon a common set of hidden factors, or indeed sharing the
% same outcomes.
%
% See also: spm_MDP, which uses multiple future states and a mean field
% approximation for control states - but allows for different actions at
% all times (as in control problems).
%
% See also: spm_MDP_game_KL, which uses a very similar formulation but just
% maximises the KL divergence between the posterior predictive distribution
% over hidden states and those specified by preferences or prior beliefs.
%__________________________________________________________________________
% Copyright (C) 2005 Wellcome Trust Centre for Neuroimaging

% Karl Friston
% $Id: spm_MDP_VB_X_tutorial_debug_v2.m 7943 2022-12-24 00:25:00Z thomas $

%==========================================================================

% options
%--------------------------------------------------------------------------
try, OPTIONS.plot;  catch, OPTIONS.plot  = 0;     end
try, OPTIONS.gamma; catch, OPTIONS.gamma = 0;     end
try, OPTIONS.D;     catch, OPTIONS.D     = 0;     end
try, OPTIONS.Ht;    catch, OPTIONS.Ht    = 1;     end
try, OPTIONS.sX;    catch, OPTIONS.sX    = [0,0]; end
% check MDP specification
%--------------------------------------------------------------------------
MDP = spm_MDP_check(MDP);
% set up and preliminaries
%==========================================================================

% defaults
%--------------------------------------------------------------------------
try, alpha    = MDP.alpha;    catch, alpha = 512;       end % action precision
try, beta     = MDP.beta;     catch, beta  = 1;         end % policy precision
try, tau      = MDP.tau;      catch, tau   = 4;         end % update time constant
try, chi      = MDP.chi;      catch, chi   = 1/64;      end % Occam window updates
try, erp      = MDP.erp;      catch, erp   = 4;         end % update reset
try, MDP.VBNi = OPTIONS.VBNi; catch, MDP.VBNi  = 16;    end % number of VB iterations
try, alpha    = OPTIONS.level(MDP.level).alpha; catch, alpha = 512;       end % action precision

% preclude precision updates for moving policies
%--------------------------------------------------------------------------
if isfield(MDP,'U'), OPTIONS.gamma = 1;         end

% number of updates T & policies V (hidden Markov model with no policies)
%--------------------------------------------------------------------------
T           = MDP.T;                    % number of updates
Vset(1,:,:) = MDP.U;                    % allowable actions (1,Np,Nf)
VBNi        = MDP.VBNi;                 % number of VB iterations
% ensure policy length is less than the number of updates
%----------------------------------------------------------------------
if size(Vset,1) > (T - 1)
    Vset = Vset(1:(T - 1),:,:);
end

% numbers of transitions, policies and states
%----------------------------------------------------------------------
NobsFactors      = numel(MDP.A);               % number of outcome factors
NstateFactors    = numel(MDP.B);               % number of hidden state factors
Npolicies        = size(Vset,2);                  % number of allowable policies
for istatef = 1:NstateFactors
    Nstates(istatef)    = size(MDP.B{istatef},1);     % number of hidden states   per factor
    Nactions(istatef)   = size(MDP.B{istatef},3);     % number of hidden controls per factor
end
for iobsf = 1:NobsFactors
    Nobs(iobsf) = size(MDP.A{iobsf},1);     % number of outcomes
end

% parameters of generative model and policies
%======================================================================

% likelihood model (for a partially observed MDP)
%----------------------------------------------------------------------
for iobsf = 1:NobsFactors
    
    % ensure probabilities are normalised  : A
    %------------------------------------------------------------------
    MDP.A{iobsf} = spm_norm(MDP.A{iobsf});
end

% transition probabilities (priors)
%----------------------------------------------------------------------
for istatef = 1:NstateFactors
    for iaction = 1:Nactions(istatef)
        % controllable transition probabilities : B
        %--------------------------------------------------------------
        MDP.B{istatef}(:,:,iaction)          = spm_norm(MDP.B{istatef}(:,:,iaction));       
     end      
    
end

% priors over initial hidden states - concentration parameters
%----------------------------------------------------------------------
for istatef = 1:NstateFactors
    if isfield(MDP,'D')
        Dmatrix{istatef} = spm_norm(MDP.D{istatef});
    else
        Dmatrix{istatef} = spm_norm(ones(Nstates(istatef),1));
        MDP.D{istatef} = Dmatrix{istatef};
    end
end

% priors over policies - concentration parameters
%----------------------------------------------------------------------

if isfield(MDP,'E')
    E    = spm_norm(MDP.E);
else
    E    = spm_norm(ones(Npolicies,1));
end
qE   = spm_log(E);

% prior preferences (log probabilities) : C
%----------------------------------------------------------------------
for iobsf = 1:NobsFactors
    if isfield(MDP,'C')
        C{iobsf}  = MDP.C{iobsf};
    else
        C{iobsf}  = zeros(Nobs(iobsf),1);
    end
    
    % assume time-invariant preferences, if unspecified
    %------------------------------------------------------------------
    if size(C{iobsf},2) == 1
        C{iobsf} = repmat(C{iobsf},1,T);
    end
    C{iobsf} = spm_log(spm_softmax(C{iobsf}));
end

% initialise  posterior expectations of hidden states
%----------------------------------------------------------------------
for istatef = 1:NstateFactors
%     neuralpolicies{istatef}     = zeros(VBNi,Nstates(istatef),1,1,Npolicies) + 1/Nstates(istatef); %%

%     neuralpolicies{istatef}     = zeros(VBNi,Nstates(istatef),T,T,Npolicies) + 1/Nstates(istatef); %%

    neuralpolicies{istatef}     = zeros(VBNi,Nstates(istatef),T,T,Npolicies); %%
%     neuralpolicies{istatef}(:,:,1,1,:) = 1/Nstates(istatef); %%
    
    neuralpredictions{istatef}  = zeros(VBNi,Nstates(istatef),1,1,Npolicies);
    
    pstatesTimePols{istatef}    = zeros(Nstates(istatef),T,Npolicies);%      + 1/Nstates(istatef);
    
    pSTime{istatef}             = repmat(Dmatrix{istatef},1,1);

    for iNp = 1:Npolicies
        pstatesTimePols{istatef}(:,1,iNp)       = Dmatrix{istatef};
        pstatesTimePols{istatef}(:,:,iNp)       = spm_norm(pstatesTimePols{istatef}(:,:,iNp));     
    end
end
%squeeze(MODMDP.xn{2}(1,:,:,:))
% initialise posteriors over polices and action
%----------------------------------------------------------------------
P                            = zeros([Nactions,1]);
neuralstates                 = zeros(Npolicies,1);
policyposteriorTime          = zeros(Npolicies,1);

% if there is only one policy
%----------------------------------------------------------------------
if Npolicies == 1
    policyposteriorTime = ones(Npolicies,T);
end

% if states have not been specified set to 0
%----------------------------------------------------------------------
s        = zeros(NstateFactors,T);
try
    good_s       = find(MDP.s);
    s(good_s) = MDP.s(good_s);
end
MDP.s    = s;

% if outcomes have not been specified set to 0
%----------------------------------------------------------------------
o  = zeros(NobsFactors,T);
try
    good_o       = find(MDP.o);
    o(good_o) = MDP.o(good_o);
end
MDP.o = o;

% (indices of) plausible (allowable) policies
%----------------------------------------------------------------------
pols  = 1:Npolicies;

% expected rate parameter (precision of posterior over policies)
%----------------------------------------------------------------------
qb   = beta;                       % initialise rate parameters
w    = 1/qb;                       % posterior precision (policy)

% support struct for likelihood dot produtct
current_pStates1=cell(1,NstateFactors);
current_pStates2=cell(1,NstateFactors);
current_pStates3=cell(1,NstateFactors);

% belief updating over successive time points
%==========================================================================
for t = 1:T
    
    % generate hidden states and outcomes for each agent or model
    %======================================================================
    % sample state, if not specified
    %--------------------------------------------------------------
    for istatef = 1:NstateFactors
        
        % the next state is generated by action on external states
        %----------------------------------------------------------
        if MDP.s(istatef,t) == 0
            if OPTIONS.sX(1)  % DONNARUMMA Sx if you do not set up s, then s becomes best state guess
                ps = spm_norm(MDP.D{istatef});
                for iAct=2:t
                    stm1=find(rand < cumsum(ps),1);
                    ps = MDP.B{istatef}(:,stm1,MDP.u(istatef,t - 1));
                end
            else
                if t > 1 
                    ps = MDP.B{istatef}(:,MDP.s(istatef,t - 1),MDP.u(istatef,t - 1));
                else
                    ps = spm_norm(MDP.D{istatef});
                end
            end

            MDP.s(istatef,t) = find(rand < cumsum(ps),1);
        end
        
    end
    
    % sample outcome, if not specified
    %--------------------------------------------------------------
    for iobsf = 1:NobsFactors
        % if outcome is not specified
        %----------------------------------------------------------
        if ~MDP.o(iobsf,t)         
            % sample from likelihood given hidden state
            %--------------------------------------------------
            ind           = num2cell(MDP.s(:,t));
            po            = MDP.A{iobsf}(:,ind{:});
            MDP.o(iobsf,t) = find(rand < cumsum(po),1);                   
        end
    end
    % get probabilistic outcomes from samples or subordinate level
    %==================================================================
    
    % get outcome likelihood (ObsProb)
    %------------------------------------------------------------------
    for iobsf = 1:NobsFactors 
        % specified as the sampled outcome
        %----------------------------------------------------------
        ObsProb{iobsf,t} = sparse(MDP.o(iobsf,t),1,1,Nobs(iobsf),1);
    end         
    % or generate outcomes from a subordinate MDP
    %==================================================================
    if isfield(MDP,'link')
        % use previous inversions (if available) to reproduce outcomes
        %--------------------------------------------------------------
        try
            mdp = MDP.mdp(t);
        catch
            mdp = MDP.MDP(1);
            if OPTIONS.sX(2)
                try
                    mdp.s=squeeze(mdp.s(:,:,t));
                catch
                  
                end
            else
                if isfield(mdp,'s')
                    mdp.s=mdp.s(:,:,1);
                else
                    mdp.s=zeros(length(mdp.B),mdp.T);
                end
            end
        end
        
        % posterior predictive density over hidden (external) states
        %--------------------------------------------------------------
        for istatef = 1:NstateFactors
            %----------------------------------------------------------
            current_pStates1{istatef} = pSTime{istatef}(:,t);
        end
    
        % priors over states (of subordinate level)
        %--------------------------------------------------------------
        mdp.factor = [];
        for istatef = 1:size(MDP.link,1)
            for iobsf = 1:size(MDP.link,2)
                if ~isempty(MDP.link{istatef,iobsf})
                    
                    % subordinate state has hierarchical constraints
                    %--------------------------------------------------
                    mdp.factor(end + 1)     = istatef;
                                            
                    % empirical priors over initial states
                    %--------------------------------------------------
                    ObsProb{iobsf,t}        = spm_dot(MDP.A{iobsf},current_pStates1);
                    mdp.D{istatef}          = MDP.link{istatef,iobsf}*ObsProb{iobsf,t};
                    
                    % hidden state for lower level is the outcome
                    %--------------------------------------------------
                    if isfield(mdp,'s')
                        sinds = mdp.s(istatef,:)==0;
                    else
                        sinds = 1:mdp.T;
                    end
                    if ~isempty(sinds)
                        ps                  = MDP.link{istatef,iobsf}(:,MDP.o(iobsf,t));
                        mdp.s(istatef,sinds)= find(ps); % DONNARUMMA
                    end
                end
            end
        end
                    
        % infer hidden states at lower level (outcomes at this level)
        %==============================================================
        MDP.mdp(t) = spm_MDP_VB_H(mdp,OPTIONS);

        % get inferred outcomes from subordinate MDP
        %==============================================================
        for istatef = 1:size(MDP.link,1)
            for iobsf = 1:size(MDP.link,2)
                if ~isempty(MDP.link{istatef,iobsf})
                    if OPTIONS.Ht
                        ObsProb{iobsf,t} = MDP.link{istatef,iobsf}'*MDP.mdp(t).X{istatef}(:,1);
                    else
                        %% DONNARUMMA VERSION: take the latest probability on hidden states (end)
                        ObsProb{iobsf,t} = MDP.link{istatef,iobsf}'*MDP.mdp(t).X{istatef}(:,end);
                    end
                end
            end
        end
    end % end of hierarchical mode (link)
    
    % Likelihood of hidden states
    %==================================================================
    Likelihood{t} = 1;
    for iobsf = 1:NobsFactors
        Likelihood{t} = Likelihood{t}.*spm_dot(MDP.A{iobsf},ObsProb{iobsf,t});
    end
    
    % Variational updates 
    %==================================================================
    % processing time and reset
    %--------------------------------------------------------------
    tstart = tic;
    for istatef = 1:NstateFactors
        pstatesTimePols{istatef}    = spm_softmax(spm_log(pstatesTimePols{istatef})/erp);
    end
    
    % Variational updates (hidden states) under sequential policies
    %==============================================================
    
    % variational message passing (VMP)
    %--------------------------------------------------------------
    TimeHorizon        = size(Vset,1) + 1;   % horizon
    FreeEnergyPols     = zeros(Npolicies,1);  
    for iNp = pols                      % loop over plausible policies               
        [pstatesTimePols,neuralpolicies,neuralpredictions,FreeEnergy]=VB_iterate(pstatesTimePols,neuralpolicies,neuralpredictions,t,TimeHorizon,Likelihood,iNp,Vset,Dmatrix,MDP);
        FreeEnergyPols(iNp)=FreeEnergy;
    end
    
    % accumulate expected free energy of policies (Q)
    %==============================================================
    policyprior         = 1;                        % empirical prior   (pu)
    policyposterior     = 1;                        % posterior         (qu)
    ExpectedFreeEnergy  = zeros(Npolicies,1);       % expected free energy
    for iNp = pols     
        for iTH = t:TimeHorizon
            
            % get expected states for this policy and time
            %--------------------------------------------------
            for istatef = 1:NstateFactors
                current_pStates3{istatef} = pstatesTimePols{istatef}(:,iTH,iNp);
            end
            
            % (negative) expected free energy
            %==================================================                
            % Bayesian surprise about states
            %--------------------------------------------------
            ExpectedFreeEnergy(iNp) = ExpectedFreeEnergy(iNp) + spm_MDP_G(MDP.A(:),current_pStates3);
            
            for iobsf = 1:NobsFactors
                % prior preferences about outcomes
                %----------------------------------------------
                qo   = spm_dot(MDP.A{iobsf},current_pStates3);
                ExpectedFreeEnergy(iNp) = ExpectedFreeEnergy(iNp) + qo'*(C{iobsf}(:,iTH));
            end
        end
    end % end loop over policies
    
    % variational updates - policies and precision
    %==========================================================
    
    % previous expected precision
    %----------------------------------------------------------
    if t > 1
        w(t) = w(t - 1);
    end
    % posterior and prior beliefs about policies
    %------------------------------------------------------
    %% DONNARUMMA POLICY PRIORS
    try
        loc_t   = MDP.s(2,t);
        if t==1
            loc_tm1=0;
        else
            loc_tm1 = MDP.s(2,t-1);
        end

        EPpr  = HAI_getLocationPriors(loc_tm1,Npolicies,OPTIONS.level(MDP.level)); 
        EPpr  = spm_norm(EPpr);
        qEpr  = spm_log(EPpr);
        % if MDP.level==3
        %     if  OPTIONS.level(MDP.level).location_priors
        %         fprintf('lello\n')
        %     end
        % end

        EPps  = HAI_getLocationPriors(  loc_t,Npolicies,OPTIONS.level(MDP.level)); 
        EPps  = spm_norm(EPps);
        qEps  = spm_log(EPps);
    catch
        qEpr=qE;
        qEps=qE;
    end
    policyposterior = spm_softmax(qEps(pols) + w(t)*ExpectedFreeEnergy(pols) + FreeEnergyPols(pols));
    policyprior     = spm_softmax(qEpr(pols) + w(t)*ExpectedFreeEnergy(pols));
    
    % precision (w) with free energy gradients (v = -dF/dw)
    %------------------------------------------------------
    
    if OPTIONS.gamma
        w(t) = 1/beta;
    else
        eg      = (policyposterior - policyprior)'*ExpectedFreeEnergy(pols);
        dFdg    = qb - beta + eg;
        qb   = qb - dFdg/2;
        w(t) = 1/qb;
    end
    policyposteriorTime(pols,t)             = policyposterior;
        
    for iVB = 1:VBNi     
        % simulated dopamine responses (expected precision)
        %------------------------------------------------------
        n                           = (t - 1)*VBNi + iVB;
        neuralprecision(n,1)        = w(t);
        neuralstates(pols,n)        = policyposterior;      
    end               
    
    
    % Bayesian model averaging of hidden states (over policies)
    %--------------------------------------------------------------
    if OPTIONS.Ht
        Ht = 1;
    else
        %% DONNARUMMA VERSION: do not reset hidden states probabilities for time < t
        Ht = t;
    end
    for istatef = 1:NstateFactors
        for iTH = Ht:TimeHorizon
            pSTime{istatef}(:,iTH) = reshape(pstatesTimePols{istatef}(:,iTH,:),Nstates(istatef),Npolicies)*policyposteriorTime(:,t);
        end
    end
    
    % processing (i.e., reaction) time
    %--------------------------------------------------------------
    rt(t)      = toc(tstart);
    
    % record (negative) free energies
    %--------------------------------------------------------------
    MDP.F(:,t) = FreeEnergyPols;
    MDP.G(:,t) = ExpectedFreeEnergy;
    MDP.H(1,t) = policyposterior'*MDP.F(pols,t) - policyposterior'*(spm_log(policyposterior) - spm_log(policyprior));
    
    % check for residual uncertainty (in hierarchical schemes)
    %--------------------------------------------------------------
    if isfield(MDP,'factor') 
        
        for istatef = MDP.factor(:)'
            %% DONNARUMMA VERSION: consider uncertainty only on future time
            qx     = pSTime{istatef}(:,Ht);
%             qx     = pstatesTime{m,istatef}(:,end); % take last 
            H(istatef) = qx'*spm_log(qx);
        end
        
        % break if there is no further uncertainty to resolve
        %----------------------------------------------------------
        if sum(H(:)) > - chi
            fprintf('NO MORE IN DOUBT! %s Exiting at %g\n',MDP.Hname,t);
            T = t;
        end
    end
    
    % action selection
    %==============================================================
    if t < T
        
        % marginal posterior over action (for each factor)
        %----------------------------------------------------------
        Pu    = zeros([Nactions,1]);
        for iVB = 1:Npolicies
            sub        = num2cell(Vset(t,iVB,:));
            Pu(sub{:}) = Pu(sub{:}) + policyposteriorTime(iVB,t);
        end
        
        % action selection (softmax function of action potential)
        %----------------------------------------------------------
        sub            = repmat({':'},1,NstateFactors);
        Pu(:)          = spm_softmax(alpha*log(Pu(:)));
        P(sub{:},t)    = Pu;
        
        % next action - sampled from marginal posterior
        %----------------------------------------------------------
        try
            MDP.u(:,t) = MDP.u(:,t);
        catch
            ind           = find(rand < cumsum(Pu(:)),1);
            MDP.u(:,t) = spm_ind2sub(Nactions,ind);
        end
        
        % update policy and states for moving policies
        %----------------------------------------------------------
        if isfield(MDP,'U')
            
            for istatef = 1:NstateFactors
                Vset(t,:,istatef) = MDP.u(istatef,t);
            end
            for iaction = 1:size(MDP.U,1)
                if (t + 1) < T
                    Vset(t + 1,:,:) = MDP.U(:,:);
                end
            end
            
            % and re-initialise expectations about hidden states
            %------------------------------------------------------
            for istatef = 1:NstateFactors
                for iNp = 1:Npolicies
                    pstatesTimePols{istatef}(:,:,iNp) = 1/Nstates(istatef);
                end
            end
        end
        
    end % end of state and action selection
    
    % terminate evidence accumulation
    %----------------------------------------------------------------------
    if t == T
        if T == 1
            MDP.u  = zeros(NstateFactors,0);
        end
        MDP.o  = MDP.o(:,1:T);        % outcomes at 1,...,T
        MDP.s  = MDP.s(:,1:T);        % states   at 1,...,T
        MDP.u  = MDP.u(:,1:T - 1);    % actions  at 1,...,T - 1
        break;
    end

    fprintf('Loop in t\n');
    MDP.X=pSTime;TRACE_printHierarchicalLevel(MDP,t);
end % end of loop over time

% learning - accumulate concentration parameters
%==========================================================================
% simulated dopamine (or cholinergic) responses
%----------------------------------------------------------------------
if Npolicies > 1
    dn = 8*gradient(neuralprecision) + neuralprecision/8;
else
    dn = [];
    neuralprecision = [];
end

% Bayesian model averaging of expected hidden states over policies
%----------------------------------------------------------------------
for istatef = 1:NstateFactors
    Xn{istatef} = zeros(VBNi,Nstates(istatef),T,T);
    Vn{istatef} = zeros(VBNi,Nstates(istatef),T,T);
    for iTH = 1:T
        for iNp = 1:Npolicies
            Xn{istatef}(:,:,1:T,iTH) = Xn{istatef}(:,:,1:T,iTH) + neuralpolicies   {istatef}(:,:,1:T,iTH,iNp)*policyposteriorTime(iNp,iTH);
            Vn{istatef}(:,:,1:T,iTH) = Vn{istatef}(:,:,1:T,iTH) + neuralpredictions{istatef}(:,:,1:T,iTH,iNp)*policyposteriorTime(iNp,iTH);
        end
    end
    %% DONNARUMMA: only good T
    pstatesTimePols{istatef} = pstatesTimePols{istatef}(:,1:T,:);
    pSTime{istatef}     = pSTime{istatef}(:,1:T);

end

% use penultimate beliefs about moving policies
%----------------------------------------------------------------------
if isfield(MDP,'U')
    policyposteriorTime(:,T)  = [];
    try neuralstates(:,(end - VBNi + 1):end) = []; catch, end
end

% assemble results and place in NDP structure
%----------------------------------------------------------------------
MDP.T  = T;                     % number of belief updates
MDP.O  = ObsProb;               % outcomes
MDP.P  = P;                     % probability of action at time 1,...,T - 1
MDP.R  = policyposteriorTime;   % conditional expectations over policies
MDP.Q  = pstatesTimePols;       % conditional expectations over N states
MDP.X  = pSTime;                % Bayesian model averages over T outcomes
MDP.C  = C;                     % utility

MDP.w  = w;                     % posterior expectations of precision (policy)
MDP.vn = Vn;                    % simulated neuronal prediction error
MDP.xn = Xn;                    % simulated neuronal encoding of hidden states
MDP.un = neuralstates;          % simulated neuronal encoding of policies
MDP.wn = neuralprecision;       % simulated neuronal encoding of precision
MDP.dn = dn;                    % simulated dopamine responses (deconvolved)
MDP.nP = neuralpolicies;
MDP.rt = rt;                    % simulated reaction time (seconds)


% plot
%==========================================================================
if OPTIONS.plot
%     if ishandle(OPTIONS.plot)
%         figure(OPTIONS.plot); clf
%     else
%         spm_figure('GetWin','MDP'); clf
%     end
%     spm_MDP_VB_trial(MDP(1))
end

fprintf('BEFORE EXIT\n');
TRACE_printHierarchicalLevel(MDP,t);
fprintf('MDP %s exiting %s\n',mfilename,MDP.Hname);

% auxillary functions
%==========================================================================
function sub = spm_ind2sub(siz,ndx)
% subscripts from linear index
%--------------------------------------------------------------------------
n = numel(siz);
k = [1 cumprod(siz(1:end-1))];
for i = n:-1:1
    vi       = rem(ndx - 1,k(i)) + 1;
    vj       = (ndx - vi)/k(i) + 1;
    sub(i,1) = vj;
    ndx      = vi;
end

return