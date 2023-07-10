function   h=PLOT_Units(MDP,params)
% function h=PLOT_Units(MDP,params)
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
hai_neu = HAI_getNeuralStatistics(MDP,params);
z=hai_neu.z;

dt  = 1/64;                 % time bin (seconds)
Nt  = length(MDP);          % number of trials
Ne  = size(z{1},1);         % number of epochs        
Nb  = size(z{1}{1},1);      % number of time bins per epochs
Nx =  size(z{1},2)/Ne;      % number of states
t   = (1:(Nb*Ne*Nt))*dt;    % time (seconds)


factor = params.factor;
% scale=240;%200;%2^8; %64
% imagesc(t,1:(Nx*Ne),scale*(1 - spm_cat(z)'))
imagesc(t,1:(Nx*Ne),(1 - spm_cat(z)'));

ylabel(MDP(1).Aname{factor},'FontSize',16)
title('Unit values','FontSize',12);

xlabel('time (sec)','FontSize',12)
hold on
colormap gray
if Nx*Ne < 16
   grid on, set(gca,'YTick',1:(Ne*Nx))
   set(gca,'YTickLabel',hai_neu.Sstr)
end
grid on, set(gca,'XTick',(1:(Ne*Nt))*Nb*dt)
if Ne*Nt > 32, set(gca,'XTickLabel',{}), end