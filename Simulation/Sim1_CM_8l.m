% main Sim1_CM_8l.m
% Simulation 1: reading 100 words of eight letters from the BERT Dictionary, Control Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

irng                                = randi([1 10],1);  %'default';
length_of_words                     = 8;                % words of eight letters
paramsmodes                         = 20;               % select the SUB parameter: Control Model, two level (Syllables, Words), no noise
Nruns                               = 100;              % number of runs
dictionary                          = 'BERT_100_SY';
fundic                              = str2func(dictionary);
BERT_dic                            = fundic();
WORDS                               = DICTIONARY_words(BERT_dic);
%% get params with the selected dictionary
[par_series,noisedescription]       = HAI_getParams_bis(paramsmodes,dictionary);   
par_series                          = HAI_initialiseParams(par_series);
%% set seed
par_series.irng                     = irng;
maxT                                = par_series.level(end).maxT;       % max number of iterations
SEP                                 = filesep;
% save in current dir - change to save in other dirs
root_dir                            = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP];
    
%%----- WORD SELECTION
word_eval                           = cell(Nruns,1);  
ctx_ind                             = contextPartition(WORDS);
expID                               = fromNumToOrderedString(paramsmodes,100);
        
id_ctx_sel_run                      = contextRandomSelection(ctx_ind,length_of_words,Nruns);
for i_run = 1:Nruns
    t_run=tic;
    fprintf('Run%g: reading simulation for Subject ID%s\n',i_run,expID);
    idword                          = id_ctx_sel_run(i_run);
    word                            = WORDS{idword};
    save_dir                        = [root_dir dictionary SEP mfilename SEP word SEP];
    %% set real state prior to word to read
    par_series.level(end).s(1,:)    = ones(1,maxT)*idword; 
    %% run the inference
    MDPsub                          = HAI_RUN(par_series,dictionary);
    MDP                             = HAI_smartMDP(MDPsub);    
    %% save MDP in directory
    if ~isfolder(save_dir)
        mkdir(save_dir);
    end
    nf                              = [save_dir sprintf('MDP_ID%s',expID)];
    fprintf('Saving %s.mat...',nf) 
    save(nf,'MDP','-v7.3');
    fprintf(' | Time Elapsed %g s\n',toc(t_run));
    word_eval(i_run,1)              = {word};       % record structure with the words read
end