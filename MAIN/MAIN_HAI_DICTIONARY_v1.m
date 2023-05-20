% function MAIN_HAI_DICTIONARY_v1
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
paramsmodes                        = 1:15;
% subs                                 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
idsentences(paramsmodes)           = [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1];
irng                               = 10; %'default';

NSubs                              = length(paramsmodes);
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedesc                          = cell(NSubs,1);
% dictionary                         = 'VARIABLES_DYSLEXIA_v1';
dictionary                         = 'DICTIONARY_v1';
for iSub=1:NSubs  
    %% get params with the selected dictionary
    [par_series{iSub},noisedesc{iSub}]  = HAI_getParams(paramsmodes(iSub),dictionary);  
    par_series{iSub}                    = HAI_initialiseParams(par_series{iSub});
    %% set seed
    par_series{iSub}.irng               = irng;
    %% set higher level to true sentence
    maxT                                = par_series{iSub}.level(end).maxT;
    par_series{iSub}.level(end).s(1,:)  = ones(1,maxT)*idsentences(paramsmodes(iSub));  % initial sentence state
    %% other options if needed
    
    %% run the inference
    MDPsub{iSub}                        = HAI_RUN(par_series{iSub},dictionary);
    
    fprintf('Ended computation for SubjectID%g\n',paramsmodes(iSub));
%     pause;
end

%% create BAR NOISE PLOT
SEP = filsep;%'//';
root_dir =[SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS' SEP]; % saving in results /tmp/HAI_LANGUAGE_TESTS/
save_dir =[root_dir SEP dictionary SEP];

PLOT_BAR_modes(MDPsub,noisedesc,dictionary,paramsmodes,rtmode,'',save_dir)
save([save_dir SEP 'MDPsub'],'MDPsub');

return