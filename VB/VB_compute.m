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
aBmat=zeros(size(Bmat));
aBmat=permute(aBmat,[2,1,3]);
for iaction = 1:size(Bmat,3)      
    % transposed normalize parameters B
    %--------------------------------------------------------------            
    aBmat(:,:,iaction)    = spm_norm(Bmat(:,:,iaction)');
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
        px = spm_log(Bmat(:,:,Vset(iTH - 1))*pStatesXtime(:,iTH - 1));   
        v  = v + px + qL - qx;
    end    
    % empirical priors (backward messages)
    %------------------------------------------
    if iTH < R
        px = spm_log(aBmat(:,:,Vset(iTH))*pStatesXtime(:,iTH + 1));    
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