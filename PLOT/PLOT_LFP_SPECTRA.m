function   h=PLOT_LFP_SPECTRA(MDP,params)
% function h=PLOT_LFP(MDP,params)
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
hai_neu = HAI_getNeuralStatistics(MDP,params);
% x       = hai_neu.x;  %% difference in potential (neurons)
z       = hai_neu.z;  %% neuron potentials

% dt      = 1/64;                 % time bin (seconds)
% dt      = 3/48;
% Nt      = length(MDP);          % number of trials
% Ne      = size(z{1},1);         % number of epochs        
% Nb      = size(z{1}{1},1);      % number of time bins per epochs
% Nx      = size(x{1},2)/Ne;      % number of states

[z,t,dt]=HAI_humanlike(MDP,z,params);
x = HAI_computeGradient(z);

% newsteps=Ne*Nb;
% rescale=1;
% if params.humanlike
%     % [x,rescale,newsteps]=HAI_humanlike(MDP,x);
%     [z,rescale,newsteps]=HAI_humanlike(MDP,z);
%     x = HAI_computeGradient(z);
% end
% phase amplitude coupling
%==========================================================================
% t       = (1:(Nb*Ne*Nt))*dt;    % time (seconds)
% t       = (1:(sum(newsteps)*Nt))*dt;    % time (seconds)

% t=t*rescale/t(end);

Hz  = 4:32;                     % frequency range
n   = 1/(4*dt);                 % window length
w   = Hz*(dt*n);                % cycles per window

LFP = spm_cat(x);
wft = spm_wft(LFP,w,n);
csd = sum(abs(wft),3);
lfp = sum(LFP,2);
phi = spm_iwft(sum(wft(1,:,:),3),w(1),n);
lfp = 4*lfp/std(lfp) + 16;
phi = 4*phi/std(phi) + 16;
 
imagesc(t,Hz,csd), axis xy, hold on
colormap gray;
plot(t,lfp,'w:',t,phi,'w','linewidth',2), hold off
grid on, 
% plt=(1:(Ne*Nt))*Nb*dt;

% set(gca,'XTick',plt)

title('Time-frequency response','FontSize',16)
xlabel('time [s]','FontSize',12), ylabel('frequency (Hz)','FontSize',12)
%if N