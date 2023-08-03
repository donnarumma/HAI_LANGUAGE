function   h=PLOT_FiringRates(MDP,params)
% function h=PLOT_FiringRates(MDP,params)
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
hai_neu = HAI_getNeuralStatistics(MDP,params);
z       = hai_neu.z;            % neuron potentials
% dt      = 1/64;                 % time bin (seconds)
% Nt      = length(MDP);          % number of trials
Ne      = size(z{1},1);         % number of epochs        
% Nb      = size(z{1}{1},1);      % number of time bins per epochs
% Nx      = size(z{1},2)/Ne;      % number of states

[z,t]=HAI_humanlike(MDP,z,params);

qx   = spm_cat(z);

if params.initialNoise
    qx(1:2,:)=0.5;
end
if params.smooth
    newT = 1000;
    tu=linspace(min(t),max(t),newT);
    [~,Ns]=size(qx);
    newqx=zeros(newT,Ns);
    qx=full(qx);
    for is=1:Ns
        newqx(:,is)=interp1(t,qx(:,is),tu,'cubic');
    end
    t = tu; 
    qx=newqx;
end



plot(t,qx,'linewidth',2), hold on, a = axis;
grid on, 
% set(gca,'XTick',(1:(Ne*Nt))*Nb*dt), axis(a)
title('Firing rates','FontSize',16)
xlabel('time [s]','FontSize',12)
ylabel('response','FontSize',12)

dy=0.015;
ylim([0-dy,1+dy])
xlim([t(1),t(end)]);