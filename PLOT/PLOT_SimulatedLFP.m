function   h=PLOT_SimulatedLFP(MDP,params)
% function h=PLOT_SimulatedLFP(MDP,params)
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
hai_neu= HAI_getNeuralStatistics(MDP,params);
% x       = hai_neu.x;  %% difference in potential (neurons)
z       = hai_neu.z;  %% neuron potentials

% dt  = 1/64;                 % time bin (seconds)
% dt  = 3/48;
% Nt  = length(MDP);          % number of trials
% Ne  = size(z{1},1);         % number of epochs        
% Nb  = size(z{1}{1},1);      % number of time bins per epochs
% Nx =  size(x{1},2)/Ne;      % number of states

% [z,rescale,newsteps]=HAI_humanlike(MDP,z,params);
[z,t]   = HAI_humanlike(MDP,z,params);
x       = HAI_computeGradient(z);
LFP     = spm_cat(x);

% t = (1:(sum(newsteps)*Nt))*dt;    % time (seconds)
% t = t*rescale/t(end);

% t   = (1:(Nb*Ne*Nt))*dt;    % time (seconds)


a = axis;

if params.initialNoise
    qx   = spm_cat(z);
    act  = sum(qx,1);
    indact=act>0.3;
    val  = 0.2;
    inoi = 2;
    LFP(inoi,indact) =+val;
    nact = find(~indact);
    % nact = nact(end);%
    nact=  nact(randi(length(nact)));
    LFP(inoi,nact)=-val;

    % qx(1:2,:)=0.5
end

if params.smooth
    newT = 1000;
    tu=linspace(min(t),max(t),newT);
    [~,Ns]=size(LFP);
    newLFP=zeros(newT,Ns);
    LFP=full(LFP);
    for is=1:Ns
        newLFP(:,is)=interp1(t,LFP(:,is),tu,'cubic');
    end
    t = tu; 
    LFP=newLFP;
end
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
box on; grid on; 
dy=0.015;
ylim([min(LFP(:))-dy,max(LFP(:))+dy])
xlim([t(1),t(end)]);
% if Nt == 1, axis square, end, box off