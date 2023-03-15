% function HAI_LANGUAGE_DICTIONARY_v0_sample_main
% Level 2, Time 0:
% Sentence(1):BDAA BCBA BCAA BCBA
% Sentence(2):BCBA BCBA BCBA BCAA
% Sentence(3):BCBA BDAA BCBA BCAA
% Sentence(4):BDAA BCBA BCAA BDAA
% Sentence(5):BCBA BCBA BCBA BDAA
% Sentence(6):BCBA BDAA BCBA BDAA
% WordLocation(1):WoL1
% WordLocation(2):WoL2
% WordLocation(3):WoL3
% WordLocation(4):WoL4
% 
% Level 1, Time 0:
% Word(1):BDAA
% Word(2):BCAA
% Word(3):BCBA
% LetterLocation(1):LeL1
% LetterLocation(2):LeL2
% LetterLocation(3):LeL3
% LetterLocation(4):LeL4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear MDPsub;
rtmode                             = 0;  % 1 reaction time, 0 recognition steps
idsentence                         = 1;
irng                               = 10; %'default';

dictionary                         = 'DICTIONARY_v0';
%% get params with the selected dictionary
langparams                         = HAI_getDefaultParams(dictionary);
% langparams                       = HAI_getParams(17,dictionary);
langparams                         = HAI_initialiseParams(langparams);
%% set seed
langparams.irng                    = irng;
%% set higher level to true sentence
maxT                               = langparams.level(end).maxT;
langparams.level(end).s(1,:)       = ones(1,maxT)*idsentence;  % initial sentence state
%% other options if needed
langparams.level(1).chi            = 1/8; % confidence level on exit level 1 
langparams.level(2).chi            = 1/8; % confidence level on exit level 2 
%% run the inference
MDP                                = HAI_RUN(langparams,dictionary);

%% create BAR NOISE PLOT
SEP = '//';
root_dir =[SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS' SEP]; % saving in results /tmp/HAI_LANGUAGE_TESTS/
save_dir =[root_dir SEP dictionary SEP];
desc     = 'default parameters';
PLOT_BAR_modes({MDP},{desc},dictionary,0,rtmode,'',save_dir)
save([save_dir SEP 'MDP'],'MDP');

return