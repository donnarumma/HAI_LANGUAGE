% function tmp_SPECTRAL

% function [u,v] = spm_MDP_VB_LFP(MDP,UNITS,f,SPECTRAL)
% auxiliary routine for plotting simulated electrophysiological responses
% FORMAT [u,v] = spm_MDP_VB_LFP(MDP,UNITS,FACTOR,SPECTRAL)
%
% MDP        - structure (see spm_MDP_VB_X.m)
%  .xn       - neuronal firing
%  .dn       - phasic dopamine responses
%
% UNITS(1,j) - hidden state                           [default: all]
% UNITS(2,j) - time step
%
% FACTOR     - hidden factor to plot                  [default: 1]
% SPECTRAL   - replace raster with spectral responses [default: 0]
%
% u - selected unit rate of change of firing (simulated voltage)
% v - selected unit responses {number of trials, number of units}
%
% This routine plots simulated electrophysiological responses. Graphics are
% provided in terms of simulated spike rates (posterior expectations).
%
% see also: spm_MDP_VB_ERP (for hierarchical belief updating)
%__________________________________________________________________________
% Copyright (C) 2005 Wellcome Trust Centre for Neuroimaging
 
% Karl Friston
% $Id: spm_MDP_VB_LFP.m 7760 2019-12-29 17:45:58Z karl $
%%
EXPMDP=load('~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_PAPER/MDP_STEP001.mat'); 
MDP=EXPMDP.MDP;
%%
EXPMDP=load('~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_S02/MDP_STEP001.mat');
MDP=EXPMDP.MDP;
%%
EXPMDP=load('~/TESTS/HAI_LANGUAGE_TESTS/LEVEL3/DICTIONARY_v11/SENTENCE003/MDP.mat');
MDP=EXPMDP.MDP;
%%
addpath ('~/tools/spm12');
addpath ('~/tools/matlab-tree/');
addpath ('~/tools/transformer-models/');
addpath ('~/tools/export_fig/');
addpath ('~/tools/utilities/')
%%
% defaults
%==========================================================================
try, f;          catch, f        = 1;  end
try, UNITS;      catch, UNITS    = []; end
try, SPECTRAL;   catch, SPECTRAL = 0;  end
try, MDP = spm_MDP_check(MDP);         end
f=1;
% dimensions
%--------------------------------------------------------------------------
Nt = length(MDP);               % number of trials
Ne = size(MDP(1).xn{f},4);      % number of epochs
Nx = size(MDP(1).D{f}, 1);      % number of states
Nb = size(MDP(1).xn{f},1);      % number of time bins per epochs

% units to plot
%--------------------------------------------------------------------------
UNITS   = [];
for i = 1:Ne
    for j = 1:Nx
        UNITS(:,end + 1) = [j;i];
    end
end
    
% summary statistics
%==========================================================================
for i = 1:Nt
    
    % all units
    %----------------------------------------------------------------------
    str    = {};
    try
        xn = MDP(i).xn{f};
    catch
        xn = MDP(i).xn;
    end
    for j = 1:size(UNITS,2)
        for k = 1:Ne
            zj{k,j} = xn(:,UNITS(1,j),UNITS(2,j),k);
            xj{k,j} = gradient(zj{k,j}')';
        end
        % str{j} = sprintf('%s: t=%i',MDP(1).label.name{f}{UNITS(1,j)},UNITS(2,j));
        % str{j} = sprintf('(%i,%i):',UNITS(1,j),UNITS(2,j));
        % str{j} = sprintf('%s:%i)',MDP(1).Aname{2},UNITS(2,j));
        str{j} = sprintf('C^{%g}_{%g}: t=%i',MDP(1).level,UNITS(1,j),UNITS(2,j));
        % str{j} = sprintf('C^{%g}: t=%i',MDP(1).level,UNITS(2,j));
    end
    z{i,1} = zj;
    x{i,1} = xj;
    
    % selected units
    %----------------------------------------------------------------------
    for j = 1:size(UNITS,2)
        for k = 1:Ne
            vj{k,j} = xn(:,UNITS(1,j),UNITS(2,j),k);
            uj{k,j} = gradient(vj{k,j}')';
        end
    end
    v{i,1} = vj;
    u{i,1} = uj;
    
    % dopamine or changes in precision
    %----------------------------------------------------------------------
    % dn(:,i) = mean(MDP(i).dn,2);

end

% phase amplitude coupling
%==========================================================================
dt  = 1/64;                              % time bin (seconds)
% dt  = 3000/48;

t   = (1:(Nb*Ne*Nt))*dt;                 % time (seconds)

% dt=mean(diff(t));
Hz  = 4:32;                              % frequency range
n   = 1/(4*dt);                          % window length
w   = Hz*(dt*n);                         % cycles per window
 
% % simulated firing rates and local field potential
% image(t,1:(Nx*Ne),64*(1 - spm_cat(z)'))
% xlabel('time (sec)','FontSize',12)

LFP = spm_cat(x);
wft = spm_wft(LFP,w,n);
csd = sum(abs(wft),3);
lfp = sum(LFP,2);
phi = spm_iwft(sum(wft(1,:,:),3),w(1),n);
lfp = 4*lfp/std(lfp) + 16;
phi = 4*phi/std(phi) + 16;
 
% if Nt == 1, subplot(3,2,3), else, subplot(4,1,2),end
% t=newt;

imagesc(t,Hz,csd), axis xy, hold on
colormap gray;
plot(t,lfp,'w:',t,phi,'w'), hold off
grid on, 
plt=(1:(Ne*Nt))*Nb*dt;

% set(gca,'XTick',plt)

title('Time-frequency response','FontSize',16)
xlabel('time (sec)','FontSize',12), ylabel('frequency (Hz)','FontSize',12)
%if Nt == 1, axis square, end


%% %%%%%% POPULATION CODING %%%%%%%
hfig=figure; hold on; 
Nr    = 16;%16;
R  = kron(spm_cat(z)',ones(Nr,Nr));
R  = rand(size(R)) > R*(1 - 1/Nr);
imagesc(t,1:(Nx*Ne + 1),R),title('Unit firing','FontSize',16)
xlabel('time (sec)','FontSize',12)
colormap gray;

grid on, set(gca,'XTick',(1:(Ne*Nt))*Nb*dt)

ylabel(sprintf('Population Coding C^{3} (%s x time step)',MDP(1).Aname{f})); %% DONNARUMMA

yt   =yticks;
yt(1)=1;
Nlabels=length(yticks);
allyticks= 1:(Ne*Nx);
grid on, set(gca,'YTick',allyticks)  % set y ticks for each neuron
HN=yline(allyticks);
set(HN,'alpha',0.1);
ylim([1-0.0,Ne*Nx+0.0]);
% nolabels=1;
% if ~nolabels
strnew=cell(Ne*Nx,1);               %% DONNARUMMA all strings reset
% ytks=1:Nx:Ne*Nx; strnew(ytks)=str(ytks);  %% put anly wanted strings 
strnew(yt)=num2cell(yt);
str=strnew;                         %% comment if you want disable DONNARUMMA
set(gca,'YTickLabel',str),
xlim([t(1),t(end)]);
% %%%%% FILL LINES %%%%%%
ylines  = 0:Nx:Ne*Nx;
istart  = 1;
ylines  = ylines(2:end);
cmaps   = lines(length(ylines));
for iy = 1:length(ylines)
    iend = ylines(iy);
    H(iy)=fill([t(1),t(1),t(end),t(end)],[istart,iend,iend,istart],cmaps(iy,:));
    istart=iend;
    set(H(iy),'facealpha',.1)
    HL{iy}=['Step=' num2str(iy)];
end
% 
legend(H,HL,'location','northwest')
%%%%%%%%%%%

%%
diffReal=diff([0;RealTime]);
NrPop   =16;    % Number of neuron per population    
Nr2     = round(diffReal/min(diffReal)*16);

%%
hfig=figure;
% Nr=round(diff(ciccio)/min(diff(ciccio))*16);
% Nr    = 16;%16;
Nr1                         =[16,32];
Nr2     =[16,16];
Z_cat = spm_cat(z{1}(1,:))';
R1  = kron(Z_cat,ones(Nr1(1),Nr1(2)));
R1  = rand(size(R1)) > R1*(1 - 1/Nr1(1));

Z_cat = spm_cat(z{1}(2,:))';
R2  = kron(Z_cat,ones(Nr2(1),Nr2(2)));
R2  = rand(size(R2)) > R2*(1 - 1/Nr2(1));

% Z_cat = spm_cat(z{1}(2,:))';
% R2  = kron(Z_cat,ones(Nr(2),Nr(2)));
% R2  = rand(size(R2)) > R2*(1 - 1/Nr(2));

R = [R1,R2];
% imagesc(t,1:(Nx*Ne + 1),R(100:120,:)),title('Unit firing','FontSize',16)

imagesc(t,1:(Nx*Ne + 1),R),title('Unit firing','FontSize',16)
% figure;
% imagesc(R),title('Unit firing','FontSize',16)

xlabel('time (sec)','FontSize',12)
colormap gray;
grid on, set(gca,'XTick',(1:(Ne*Nt))*Nb*dt)
ytks=1:(Ne*Nx);
% grid on, set(gca,'YTick',ytks)
ylabel(sprintf('Population Coding (%s,%s)',MDP(1).Aname{1},MDP(1).Aname{2}));
return;

% str=str(ytks); set(gca,'YTickLabel',str),
str=cell(length(ytks),1);
str([1,10:10:length(ytks)])=num2cell(ytks([1,10:10:length(ytks)]));
set(gca,'YTickLabel',str),


%%



