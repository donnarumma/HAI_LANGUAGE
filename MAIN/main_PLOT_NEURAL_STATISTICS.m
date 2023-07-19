% main_PLOT_NEURAL_STATISTICS
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_PAPER/IMAGES/';
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_S02/IMAGES/';
save_dir='~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/';
% save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_DEBUG/IMAGES/';

if ~isfolder(save_dir)
    mkdir(save_dir);
end
ilev=2;
itime=3;
% 
% t0(3,1)=0;
% t0(2,1)=0;
% t0(1,1)=0;
pltparams.t0       =0;
pltparams.factor   =1; % plot first factor (CONTENT)
pltparams.humanlike=true; %true;  % true: rescale times for human saccades
pltparams.RTstretch=false;        % true: use machine reaction time

if ilev==3
    MDP=EXPMDP.MDP;
elseif ilev==2
    MDP=EXPMDP.MDP.mdp(itime);
    if itime>1
        pre_MDP=EXPMDP.MDP.mdp(itime-1);
    end
end
if itime>1
    hai_neu = HAI_getNeuralStatistics(pre_MDP,pltparams);
    [~,t,dt] =HAI_humanlike(pre_MDP,hai_neu.z,pltparams);
    pltparams.t0=t(end)+dt;
end
ison=false;
level=ilev;
%%  Probabilities
pltparams.hfig  =figure('visible',ison);
% pltparams.t0       =t0;
h=PLOT_TimeProbLevel(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Probabilities_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% Raster plot
pltparams.hfig     =figure('visible',ison);
pltparams.nla      =0.05;  % neuron line alpha
pltparams.sa       =0.1;   % step alpha
h=PLOT_SimulatedRasters(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Raster_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% Output units
pltparams.hfig     =figure('visible',ison);
h=PLOT_Units(MDP,pltparams);
optionsPlot(h);
nf=sprintf('L%g_Units_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);

%% neuron LFP + firing rates
pltparams.hfig=figure('visible',ison);
subplot(2,1,1)
h=PLOT_SimulatedLFP(MDP,pltparams);
optionsPlot(h);
subplot(2,1,2)
h=PLOT_FiringRates(MDP,pltparams);
optionsPlot(h);
% nf='L3_LFFplusFR';
nf=sprintf('L%g_LFFplusFR_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% SPECTRA
pltparams.hfig=figure('visible',ison);

h=PLOT_LFP_SPECTRA(MDP,pltparams);
optionsPlot(h);
% nf='L3_SPECTRA';
nf=sprintf('L%g_SPECTRA_t%g',ilev,itime);
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);


%%