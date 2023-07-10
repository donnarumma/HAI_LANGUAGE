% main_PLOT_NEURAL_STATISTICS
save_dir='~/TESTS/HAI_LANGUAGE_TESTS/BERT_LOOP/DICTIONARY/BERT_DIC/BERT_v1_PAPER/IMAGES/';
if ~isfolder(save_dir)
    mkdir(save_dir);
end
ison=false;
%%  Probabilities
pltparams.factor=1; % plot first factor (CONTENT)
pltparams.hfig  =figure('visible',ison);
h=PLOT_TimeProbLevel(MDP,pltparams);
optionsPlot(h);
nf='L3_Probabilities';
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% Raster plot
pltparams.hfig     =figure('visible',ison);
pltparams.factor   =1;
pltparams.nla      =0.05;  % neuron line alpha
pltparams.sa       =0.1;   % step alpha
pltparams.humanlike=true;  % rescale times for human saccades
h=PLOT_SimulatedRasters(MDP,pltparams);
optionsPlot(h);
nf='L3_Raster';
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% Output units
pltparams.hfig     =figure('visible',ison);
h=PLOT_Units(MDP,pltparams);
optionsPlot(h);
nf='L3_Units';
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
nf='L3_LFFplusFR';
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%% SPECTRA
pltparams.hfig=figure('visible',ison);

h=PLOT_LFP_SPECTRA(MDP,pltparams);
optionsPlot(h);
nf='L3_SPECTRA';
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);


%%