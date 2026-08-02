function   [dFE,sx,v]= VB_compute(nFactors,      ...
                                  iVB,                ...
                                  TimeHorizon,        ...
                                  pStatesXtime,       ... % MDP.Q{iFactor}(:,:,iPolicy),
                                  Vset,               ...
                                  tau,                ...
                                  R,                  ...
                                  dF,                 ...
                                  qL,                 ...
                                  Dmatrix,            ...
                                  iTH,                ...
                                  Bmat)
% function [dFE,sx,v]= VB_compute(nFactors,           ...
%                                 iVB,                ...
%                                 TimeHorizon,        ...
%                                 pStatesXtime,       ...
%                                 Vset,               ...
%                                 tau,                ...
%                                 R,                  ...
%                                 dF,                 ...
%                                 qL,                 ...
%                                 Dmatrix,            ...
%                                 iTH,                ...
%                                 Bmat)

% aBmat=zeros(size(Bmat));
% aBmat=permute(aBmat,[2,1,3]);
aBmat=Bmat;
for iaction = 1:size(Bmat,3)      
    % transposed normalize parameters B
    %--------------------------------------------------------------            
    % aBmat(:,:,iaction)    = spm_norm(Bmat(:,:,iaction)');
    % aBmat(:,:,iaction)    = spm_norm(Bmat(:,:,iaction));
    % aBmat(:,:,iaction)    = Bmat(:,:,iaction)./sum(Bmat(:,:,iaction)); 
end      
sx = pStatesXtime(:,iTH);

% hidden states for this time and policy
%----------------------------------------------
v = 0;
% evaluate free energy and gradients (v = dFdx)
%----------------------------------------------
if dF > exp(-8) || iVB > 4     
    % entropy
    %------------------------------------------
    qx  = spm_log(sx);
    % emprical priors (forward messages)
    %------------------------------------------
    if iTH < 2
        px = spm_log(Dmatrix);
        v  = v + px + qL - qx;
    else
        if ndims(Bmat)>3
            % for is=1:(ndims(Bmat)-1)
            %     index{is}=':';
            % end
            % Bmat{istatef}(index{:},iaction)     = spm_norm(Bmat(index{:},iaction));
            try
                % factor1 and 4 factor fixed: temporary coding
                px=zeros(size(sx));
                for j3=size(Bmat,3)
                    for j4=size(Bmat,4)
                        px = px + spm_log(Bmat(:,:,j3,j4,Vset(iTH - 1))*pStatesXtime(:,iTH - 1));
                    end
                end
            catch
                fprintf('LELLO!')
            end
        else
            px = spm_log(Bmat(:,:,Vset(iTH - 1))*pStatesXtime(:,iTH - 1));   
        end
        v  = v + px + qL - qx;
    end    
    % empirical priors (backward messages)
    %------------------------------------------
    if iTH < R
        if ndims(Bmat)>3
            % factor1 and 4 factor fixed: temporary coding    
            px=zeros(size(sx));
            for j3=size(Bmat,3)
                for j4=size(Bmat,4)
                    px = px + spm_log(Bmat(:,:,j3,j4,Vset(iTH))*pStatesXtime(:,iTH + 1));
                end
            end
        else
            px = spm_log(aBmat(:,:,Vset(iTH))*pStatesXtime(:,iTH + 1));    
        end
        v  = v + px + qL - qx;
    end
    % (negative) free energy
    %------------------------------------------
    if iTH == 1 || iTH == TimeHorizon
        dFE = sx'*0.5*v;
    else
        dFE = sx'*(0.5*v - (nFactors-1)*qL/nFactors);
    end    
    % update
    %------------------------------------------
    v    = v - mean(v);
    sx   = spm_softmax(qx + v/tau);    
else
    dFE = 0;
end