function   [MDP, FreeEnergy] = VB_iterate(MDP,time,Likelihood,iPolicy,Vset)
% function [MDP, FreeEnergy] = VB_iterate(MDP,time,Likelihood,iPolicy,Vset)
dF              = 1;
nFactors        = length(MDP.Q);    % number of Factors for each state
nStates         = nan(1,nFactors);
TimeHorizon     = size(Vset,1) + 1; % horizon
   
for is=1:nFactors
    nStates(is) =size(MDP.Q{is},1);
end
pStateXpolicy=cell(1,nFactors);     % save current pStates: probability of being in a state given the iPolicy 
for iVB = 1:MDP.VBNi                % iterate belief updates
    FreeEnergy  = 0;                % reset free energy for this policy
    for iTH = 1:TimeHorizon         % loop over future time points             
        %--------------------------------------------------
        for iFactor = 1:nFactors
            % marginal likelihood over outcome factors (qL)
            %------------------------------------------
            qL = zeros(nStates(iFactor),1);
            if iTH <= time
                for is = 1:nFactors
                    pStateXpolicy{is} = full(MDP.Q{is}(:,iTH,iPolicy));
                end
                qL = spm_dot(Likelihood{iTH},pStateXpolicy,iFactor);
                qL = spm_log(qL(:));
            end

            [dFE,sx,v]=VB_compute(nFactors,                     ...
                                  iVB,                          ...
                                  TimeHorizon,                  ...
                                  MDP.Q{iFactor}(:,:,iPolicy),  ... 
                                  Vset(:,iPolicy,iFactor),      ...
                                  MDP.tau,                      ...
                                  time,                         ...
                                  dF,                           ...
                                  qL,                           ...
                                  MDP.D{iFactor},               ...
                                  iTH,                          ...
                                  MDP.B{iFactor});
            FreeEnergy = FreeEnergy + dFE;            
            % store update neuronal activity
            %----------------------------------------------
            MDP.Q {iFactor} (:,iTH,iPolicy)          = sx; 
            MDP.xnP{iFactor}(iVB,:,iTH,time,iPolicy) = sx;
            MDP.vnP{iFactor}(iVB,:,iTH,time,iPolicy) = v;
        end
        
    end
    % convergence
    %------------------------------------------------------
    if iVB > 1
        dF = FreeEnergy - oldFE;
    end
    oldFE = FreeEnergy;           
end

