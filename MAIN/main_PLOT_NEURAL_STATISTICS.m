%% main_PLOT_NEURAL_STATISTICS
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_PAPER/IMAGES/';
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_S02/IMAGES/';
save_dir='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA3/';
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_DEBUG/IMAGES/';

ext = 'fig';
% ext = 'pdf';

ilev=1;
% ilev=2;
% ilev=3;
if ~isfolder(save_dir)
    mkdir(save_dir);
end
if ilev==3
    itimes=1;
elseif ilev==2
    itimes=1:4;
elseif ilev==1
    itimes=1:8;
    itime3=[1,1; ...
            1,2; ...
            2,1; ...
            2,2; ...
            3,1; ...
            3,2; ...
            4,1; ...
            4,2];    
    itimes=[1,3,4,6,7];
    itimes=4;
end
%%
pltparams.hfig      = [];
probLevel           = HAI_getTimeProb(EXPMDP.MDP);
pltparams.probLevel = probLevel;
pltparams.t0        = 0;
pltparams.factor    = 1; % plot first factor (CONTENT)
pltparams.humanlike = true; %true;  % true: rescale times for human saccades
pltparams.RTstretch = false;         % true: use machine reaction time
pltparams.fs        = (1/3+1/4)/2; % human saccades rate (saccades per second)
% pltparams.rescale  =1/probLevel{end}(end,2);  % rescale to 1
pltparams.maxVBxn   = 0;%16;%16;
pltparams.numS      = length(probLevel{1});
pltparams.maxTime   = probLevel{end}(end,2);
pltparams.killNNeurons=0;%[29,20];
pltparams.killNNeurons=[11];%[29,20];
pltparams.initialNoise=true;



if pltparams.maxVBxn
    pltparams.levsteps=HAI_GetLevelStepsFixed(EXPMDP.MDP,ilev,pltparams.maxVBxn);
else
    pltparams.levsteps = HAI_GetLevelSteps(EXPMDP.MDP,ilev);
end
% pltparams.levsteps = 16*length(itimes);%HAI_GetLevelSteps(EXPMDP.MDP,ilev);
% pltparams.sacsteps = HAI_GetLevelSteps(EXPMDP.MDP,1);
% pltparams.sacsteps = 16*length(itimes);%HAI_GetLevelSteps(EXPMDP.MDP,ilev);

% (number of saccades * saccades in one seconds) / (total period * saccades level steps) 
% rsfactor =(length(probLevel{1})*pltparams.fs);                 % stretch with respect human saccades lenght
% rsfactor = 1;
rsfactor =1*(HAI_GetLevelSteps(EXPMDP.MDP,ilev)/HAI_GetLevelSteps(EXPMDP.MDP,1));% stretch with respect VB iterations
% rsfactor =1*pltparams.maxVBxn*2*8/HAI_GetLevelSteps(EXPMDP.MDP,1);% stretch with respect VB iterations

pltparams.rescale       = 1;%rsfactor;
% if ~pltparams.humanlike && ~pltparams.RTstretch 
%     pltparams.dt            = 1/64;
% elseif pltparams.humanlike && ~pltparams.RTstretch
%     pltparams.dt            = (pltparams.fs*pltparams.numS/256);  %% humanlike
%     pltparams.dt            = pltparams.fs*pltparams.numS/HAI_GetLevelSteps(EXPMDP.MDP,ilev);
% elseif pltparams.humanlike && pltparams.RTstretch
%     pltparams.dt            = pltparams.fs*pltparams.numS/probLevel{end}(end,2);
% end

% pltparams.rescale  = 0;
pltparams.Steps         = false;
pltparams.smooth        = true;
pltparams.fakeneuron    = 0;
%%
for itime=itimes
fprintf('Level%g, t=%g\n',ilev,itime); 
if ilev==3
    MDP=EXPMDP.MDP;
     %rsfactor*HAI_GetLevelSteps(MDP,ilev); % rescale times for human saccades
elseif ilev==2
    MDP=EXPMDP.MDP.mdp(itime);
elseif ilev==1
    MDP=EXPMDP.MDP.mdp(itime3(itime,1)).mdp(itime3(itime,2));
end
% ilev=3;itime=1;
% 
% t0(3,1)=0;
% t0(2,1)=0;
% t0(1,1)=0;
pltparams.t0=0;
if itime>1
    % for it=2:itime
    pltparams.t0=0;
    for it=1:itime-1
        if ilev==2
            pre_MDP=EXPMDP.MDP.mdp(it);
        elseif ilev==1
            t3=itime3(it,:);
            pre_MDP=EXPMDP.MDP.mdp(t3(1)).mdp(t3(2));
        end

        hai_neu     = HAI_getNeuralStatistics(pre_MDP,pltparams);
        [~,t,dt]    = HAI_humanlike(pre_MDP,hai_neu.z,pltparams);
        pltparams.t0= t(end)+dt;
    end  
end
ison=false;
level=ilev;
%%  Probabilities
pltparams.hfig  =figure('visible',ison);
pltparams.ylim=[];
% pltparams.t0       =t0;
h=PLOT_TimeProbLevel(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Probabilities_t%g',ilev,itime);
fprintf('Saving %s\n',[save_dir nf]);
% print(h,[save_dir nf],'-depsc2')
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
%% Raster plot
pltparams.hfig     =figure('visible',ison);
pltparams.nla      =0.05;  % neuron line alpha
pltparams.sa       =0.1;   % step alpha
h=PLOT_SimulatedRasters(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Raster_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
%% Output units
pltparams.ylim=[];
pltparams.hfig     =figure('visible',ison);
h=PLOT_Units(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Units_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
%% neuron LFP + firing rates
% pltparams.hfig=figure('visible',ison);
% subplot(2,1,1)
% h=PLOT_SimulatedLFP(MDP,pltparams);
% optionsPlot(h);
% subplot(2,1,2)
% h=PLOT_FiringRates(MDP,pltparams);
% optionsPlot(h);
% nf=sprintf('L%g_LFPplusFR_t%g',ilev,itime);
% % print(h,[save_dir nf],'-depsc2')
% fprintf('Saving %s\n',[save_dir nf]);
% if strcmp(ext,'fig')
%     savefig([save_dir nf '.' ext])
% else
%     export_fig([save_dir nf '.' ext]);
% end
% close all;
%% LFP
pltparams.hfig=figure('visible',ison);
pltparams.ylim=[];

h=PLOT_SimulatedLFP(MDP,pltparams);
% optionsPlot(h);
p=[0,0,1500,300];
fs=16;
set(gca,'fontsize',fs);
set(h, 'PaperPositionMode','auto');
set(h,'color','w');
set(h,'Position',p);
nf=sprintf('L%g_LFP_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
%% FIRING RATES
pltparams.hfig=figure('visible',ison);
pltparams.ylim=[];
h=PLOT_FiringRates(MDP,pltparams);
fs=16;
p=[0,0,1500,300];
set(gca,'fontsize',fs);
set(h, 'PaperPositionMode','auto');
set(h,'color','w');
set(h,'Position',p);
nf=sprintf('L%g_FR_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
%% SPECTRA
pltparams.hfig=figure('visible',ison);
pltparams.ylim=[];
h=PLOT_LFP_SPECTRA(MDP,pltparams);
optionsPlot(h);
% nf='L3_SPECTRA';
nf=sprintf('L%g_SPECTRA_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
close all;
end
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compose Raster
ext ='pdf';
ext ='fig';
pltparams.ylim=[];
close all;
rsfiles =sprintf('%s%sL%g_Raster*.fig',save_dir, filesep, ilev);
rsfiles =dir(rsfiles);
N_files = length(rsfiles);
dir_figs=cell(N_files,1);
for irs=1:length(rsfiles)
    dir_figs{irs}=[rsfiles(irs).folder, filesep,rsfiles(irs).name];
end
% pltparams.hfig=figure('visible',ison);
h3=putsFigsOn(dir_figs,pltparams);
if ~ison; optionsPlot(h3); end
nf=sprintf('L%g_COMPOSE_Raster',ilev);
% print(h,[save_dir nf],'-depsc2')
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
if ~ison; close all; end
%% compose Spectra
pltparams.ylim=[];
ext='pdf';
close all;
rsfiles =sprintf('%s%sL%g_SPECTRA*.fig',save_dir, filesep, ilev);
rsfiles =dir(rsfiles);
N_files = length(rsfiles);
dir_figs=cell(N_files,1);
for irs=1:length(rsfiles)
    dir_figs{irs}=[rsfiles(irs).folder, filesep,rsfiles(irs).name];
end
h3=putsFigsOn(dir_figs,pltparams);
if ~ison; optionsPlot(h3); end
nf=sprintf('L%g_COMPOSE_SPECTRA',ilev);
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
if ~ison; close all; end
%% compose LFP
ext='pdf';
close all;
pltparams.ylim=[-0.5,0.5];
rsfiles =sprintf('%s%sL%g_LFP*.fig',save_dir, filesep, ilev);
rsfiles =dir(rsfiles);
N_files = length(rsfiles);
dir_figs=cell(N_files,1);
for irs=1:length(rsfiles)
    dir_figs{irs}=[rsfiles(irs).folder, filesep,rsfiles(irs).name];
end
h3=putsFigsOn(dir_figs,pltparams);
if ~ison; optionsPlot(h3); end
fs=16;
p=[0,0,1500,300];
set(gca,'fontsize',fs);
set(h3, 'PaperPositionMode','auto');
set(h3,'color','w');
set(h3,'Position',p);
nf=sprintf('L%g_COMPOSE_LFP',ilev);
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
if ~ison; close all; end
%% compose FR
pltparams.ylim=[-0.0150, 1.0150];
ext='pdf';
close all;
rsfiles =sprintf('%s%sL%g_FR*.fig',save_dir, filesep, ilev);
rsfiles =dir(rsfiles);
N_files = length(rsfiles);
dir_figs=cell(N_files,1);
for irs=1:length(rsfiles)
    dir_figs{irs}=[rsfiles(irs).folder, filesep,rsfiles(irs).name];
end
h3=putsFigsOn(dir_figs,pltparams);
if ~ison; optionsPlot(h3); end
fs=16;
p=[0,0,1500,300];
set(gca,'fontsize',fs);
set(h3, 'PaperPositionMode','auto');
set(h3,'color','w');
set(h3,'Position',p);
nf=sprintf('L%g_COMPOSE_FR',ilev);
fprintf('Saving %s\n',[save_dir nf]);
if strcmp(ext,'fig')
    savefig([save_dir nf '.' ext])
else
    export_fig([save_dir nf '.' ext]);
end
if ~ison; close all; end

%%
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L3_Probabilities_t1';
% figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L3_Raster_t1.fig';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L3_SPECTRA_t1.fig';
% figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L3_LFP_t1.fig';
% figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L3_FR_t1.fig';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA3/L2_COMPOSE_Raster';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA3/L1_SPECTRA_t8.fig';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA3/L1_Raster_t8.fig';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L1_FR_t1.fig';
figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA3/L1_COMPOSE_Raster';
% figtopen='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA2/L1_LFP_t1.fig';

hl=openfig(figtopen); set(hl,'visible',true);
%%