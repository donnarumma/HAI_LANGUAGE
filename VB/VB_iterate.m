function   [MDP, FreeEnergy] = VB_iterate(MDP,t,Likelihood,iNp,Vset)
% function [MDP, FreeEnergy] = VB_iterate(MDP,t,Likelihood,iNp,Vset)
dF              = 1;
NstateFactors   = length(MDP.Q);
Nstates         = nan(1,NstateFactors);
TimeHorizon     = size(Vset,1) + 1;   % horizon
   
for is=1:NstateFactors
    Nstates(is) =size(MDP.Q{is},1);
end
current_pStates2=cell(1,NstateFactors);
for iVB = 1:MDP.VBNi            % iterate belief updates
    FreeEnergy  = 0;            % reset free energy for this policy
    for iTH = 1:TimeHorizon     % loop over future time points             
        %--------------------------------------------------
        
        % for is=1:NstateFactors
            % Q{is}       =MDP.Q{is}(:,:,iNp);
        % end
        for istatef = 1:NstateFactors
            % marginal likelihood over outcome factors (qL)
            %------------------------------------------
            qL = zeros(Nstates(istatef),1);
            if iTH <= t
                for is = 1:NstateFactors
                    current_pStates2{is} = full(MDP.Q{is}(:,iTH,iNp));
                    % current_pStates2{is} = full(Q{is}(:,iTH,1));
                    % lello{is} = full(Q{is}(:,iTH,1));
                    % ciccio=abs(lello{is}-current_pStates2{is});
                    % if ~isequal(lello{is},current_pStates2{is})
                        % sum(ciccio(:))
                    % end
                end
                qL = spm_dot(Likelihood{iTH},current_pStates2,istatef);
                qL = spm_log(qL(:));
            end

            [dFE,sx,v]=VB_compute(NstateFactors,           ...
                                  iVB,                     ...
                                  TimeHorizon,             ...
                                  MDP.Q{istatef}(:,:,iNp), ... MDP.Q{istatef}(:,:,iNp), Q{istatef}(:,:), ..., ... MDP.Q{istatef}(:,iTH,iNp),... %sx
                                  Vset(:,iNp,istatef),     ...
                                  MDP.tau,...
                                  t,...  %Rlook
                                  dF,...
                                  qL,...
                                  MDP.D{istatef}, ...
                                  iTH,...
                                  MDP.B{istatef});
            FreeEnergy = FreeEnergy + dFE;            
            % store update neuronal activity
            %----------------------------------------------
            MDP.Q {istatef}(:,iTH,iNp)        = sx; 
            MDP.xnP{istatef}(iVB,:,iTH,t,iNp) = sx;
            MDP.vnP{istatef}(iVB,:,iTH,t,iNp) = v;
        end
        
    end
    % convergence
    %------------------------------------------------------
    if iVB > 1
        dF = FreeEnergy - oldFE;
    end
    oldFE = FreeEnergy;           
end

