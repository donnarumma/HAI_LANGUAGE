function   h=PLOT_SimulatedRasters(MDP,params)
% function h=PLOT_SimulatedRasters(MDP,params)
if ~exist('params','var')
    params.hfig     =[];
    params.factor   =1;
    params.nla      =0.05;  % neuron line alpha
    params.sa       =0.1;   % step alpha
end
if isempty(params.hfig) || ~isvalid(params.hfig)
    h=figure;
else
    h=params.hfig;
end
factor = params.factor;
nla    = params.nla;
sa     = params.sa;
hai_neu= HAI_getNeuralStatistics(MDP,params);
z      = hai_neu.z;   % neuron potentials



dt  = 1/64;                 % time bin (seconds)
% dt  = 3/48;
Nt  = length(MDP);          % number of trials
Ne  = size(z{1},1);         % number of epochs        
Nb  = size(z{1}{1},1);      % number of time bins per epochs
Nx =  size(z{1},2)/Ne;      % number of states
newsteps=Ne*Nb;
rescale=1;
if params.humanlike
    [z,rescale,newsteps]=HAI_humanlike(MDP,z);
end
% t   = (1:(Nb*Ne*Nt))*dt;    % time (seconds)
t = (1:(sum(newsteps)*Nt))*dt;    % time (seconds)
t = t*rescale/t(end);

%% %%%%%% POPULATION CODING %%%%%%%
hold on; 
Nnr   = 16;      % Number of duplicate neurons per state
Nev   = 16;      % Number of duplicate events
SpT   = 1/16;   % Threshold to spikes
% SpT   = 1/2;
R  = kron(spm_cat(z)',ones(Nnr,Nev));
R  = rand(size(R)) > R*(1 - SpT);
imagesc(t,1:(Nx*Ne + 1),R),title('Unit firing','FontSize',16)
xlabel('time [s]','FontSize',12)
colormap gray;

grid on, 
% set(gca,'XTick',(1:(Ne*Nt))*Nb*dt)

ylabel(sprintf('Population Coding C^{%i} (%s x time step)',MDP(1).level,MDP(1).Aname{factor})); %% DONNARUMMA

yt   =yticks;
% Nlabels=length(yticks);

allyticks= 1:(Ne*Nx);
allyticks(1)=1;         % start from
grid on, set(gca,'YTick',allyticks)  % set y ticks for each neuron
HN=yline(allyticks);
set(HN,'alpha',nla);

ylim([1-0.0,Ne*Nx+0.0]);
if Ne*Nx>50
    str=cell(Ne*Nx,1);               %% DONNARUMMA all strings reset
    str(1)=num2cell(allyticks(1));
    str(yt(2:end))=num2cell(yt(2:end));
end                         %% comment if you want disable DONNARUMMA
set(gca,'YTickLabel',str),
xlim([t(1),t(end)]);
% %%%%% FILL STEP LINES %%%%%%
ylines  = 0:Nx:Ne*Nx;
istart  = 1;
ylines  = ylines(2:end);
cmaps   = lines(length(ylines));
for iy = 1:length(ylines)
    iend = ylines(iy);
    H(iy)=fill([t(1),t(1),t(end),t(end)],[istart,iend,iend,istart],cmaps(iy,:));
    istart=iend;
    set(H(iy),'facealpha',sa)
    HL{iy}=['Step: ' num2str(iy)];
end
% 
legend(H,HL,'location','northwest')
%%%%%%%%%%%
