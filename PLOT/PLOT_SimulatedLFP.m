function   h=PLOT_SimulatedLFP(MDP,params)
% function h=PLOT_SimulatedLFP(MDP,params)
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
hai_neu=HAI_getNeuralStatistics(MDP,params);
x       = hai_neu.x;  %% difference in potential (neurons)
z       = hai_neu.z;  %% neuron potentials

dt  = 1/64;                 % time bin (seconds)
% dt  = 3/48;
Nt  = length(MDP);          % number of trials
Ne  = size(z{1},1);         % number of epochs        
Nb  = size(z{1}{1},1);      % number of time bins per epochs
% Nx =  size(x{1},2)/Ne;      % number of states
newsteps=Ne*Nb;
rescale=1;
if params.humanlike
    % [x,rescale,newsteps]=HAI_humanlike(MDP,x);
    [z,rescale,newsteps]=HAI_humanlike(MDP,z);
    x=HAI_computeGradient(z);
end
% t   = (1:(Nb*Ne*Nt))*dt;    % time (seconds)
t   = (1:(sum(newsteps)*Nt))*dt;    % time (seconds)
t=t*rescale/t(end);

a = axis;
LFP=spm_cat(x);     
plot(t,LFP,'linewidth',2),     hold off, axis(a)
grid on
% set(gca,'XTick',(1:(Ne*Nt))*Nb*dt), 
% for i = 2:2:Nt
%     h = patch(((i - 1) + [0 0 1 1])*Ne*Nb*dt,a([3,4,4,3]),-[1 1 1 1],'w');
%     set(h,'LineStyle',':','FaceColor',[1 1 1] - 1/32);
% end
title('Local field potentials','FontSize',16)
xlabel('time [s]','FontSize',12)
ylabel('response','FontSize',12)
dy=0.015;
ylim([min(LFP(:))-dy,max(LFP(:))+dy])
xlim([t(1),t(end)]);
% if Nt == 1, axis square, end, box off