% function HAI_LANGUAGE_DICTIONARY_v5_sample_main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEVEL 1 ------------------------------------ %
%              letter    syllable   letter loc %
%                 27   x    203   x     2      %
%            letter loc  syllable   letter loc %
%                  2   x    203   x     2      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEVEL 2 ------------------------------------ %
%              syllable    word   syllable loc %
%                203   x   142   x      2      %
%            syllable loc  word   syllable loc %
%                  2   x   142   x      2      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEVEL 3 ------------------------------------ %
%                word    sentence    word loc  %
%                142   x   348     x    2      %
%             word loc   sentence    word loc  %
%                  2   x   348     x    2      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear MDPsub;
rtmode                             = 0;  % 1 reaction time, 0 recognition steps
% idsentence                         = 8;
ID_HighLevS                         = 4;

irng                               = 10; %'default';
% imode                              = 0; OLD COMMAND TO RETURN TO FRISTON MODE

paramsmodes                        = 24;
NSubs                              = length(paramsmodes);
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedescription                   = cell(NSubs,1);
dictionary                         = 'DICTIONARY_v5'; % no class
% dictionary                         = 'DICTIONARY_v6'; % class

dictionaryfunction                = str2func(dictionary);       
DICTIONARY                        = dictionaryfunction();
% GT=[HAI_retrieveLevel(DICTIONARY.Syllable{names(1)}),HAI_retrieveLevel(DICTIONARY.Syllable{names(2)})];
% GT=[DICTIONARY.Syllable{names(1)}),HAI_retrieveLevel(DICTIONARY.Syllable{names(2)})];
% DICTIONARY.CLASSES                = {[], [], []}; % no context

ind=1;
idsentences(1)=24;
for iSub=1:NSubs
     %% get params with the selected dictionary
    [par_series{iSub},noisedescription{iSub}] = HAI_getParams(paramsmodes(iSub),dictionary);   
    par_series{iSub}                          = HAI_initialiseParams(par_series{iSub});
    %% set seed
    par_series{iSub}.irng                     = irng;
    %% set higher level to true sentence
    maxT                                      = par_series{iSub}.level(end).maxT;
    par_series{iSub}.level(end).s(1,:)        = ones(1,maxT)*idsentences(ind);          % initial      sentence state
    %% run the inference
    MDPsub{iSub}                              = HAI_RUN(par_series{iSub},dictionary);
  
%     par_series{iSub}.idhighest                = idsentence;
%     MDPsub{iSub}=Dyslexia_RUN(par_series{iSub},dictionary);
    fprintf('Ended computation for SubjectID%g\n',paramsmodes(iSub));
%     pause;
end

SEP = filesep;%'//';
root_dir =[SEP 'tmp' SEP 'HAI_LANGUAGE' SEP];
save_dir =[root_dir SEP dictionary SEP];

PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,GT,save_dir);
return