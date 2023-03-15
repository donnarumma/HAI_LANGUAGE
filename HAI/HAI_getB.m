function   B = HAI_getB(Ns,val,jump)
% function B = HAI_getB(Ns,val,jump)
% Level Transition matrix p(St+1|St)
% val(1) good value on p(s{1}(t)|s(t-1))
% val(2) good value on p(s{2}(t)|s(t-1))
% controlled transitions: B{f} for each factor
%--------------------------------------------------------------------------
Nf      = length(Ns);
antival =(1-val)./(Ns-1);
B       = cell(1,Nf);
for f = 1:Nf
    B{f} = eye(Ns(f));          %% defalt no-action
end
% transitions on states (no transitions, only info disruption with noise) 
B{1}    = eye(Ns(1))*val(1) + (1-eye(Ns(1)))*(antival(1));
 
% transitions on locations
% controllable fixation points: action(k) = move to the k-th location
%--------------------------------------------------------------------------
for k = 1:Ns(2)
    B{2}(:,:,k) = antival(2);
    B{2}(k,:,k) = val(2);
end

if Nf>2
    for k = 1:Ns(3)
        B{3}(:,:,k) = antival(3);
        B{3}(k,:,k) = val(3);
    end
end

if ~jump % (sequenzial transition) - no jump
    B{2} = eye(Ns(2));  % reset B{2}
% % control states B(2) - Words Location:  {'Location1',...,'Location4'}
% %--------------------------------------------------------------------------
    B{2}(:,:,1)     = spm_speye(Ns(2),Ns(2), 0)*val(2)+(1-spm_speye(Ns(2),Ns(2), 0))*antival(2);
    B{2}(:,:,2)     = spm_speye(Ns(2),Ns(2),-1)*val(2)+(1-spm_speye(Ns(2),Ns(2),-1))*antival(2); 
    B{2}(end,end,2) = val(2);
end
