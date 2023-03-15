% function main_BERT_AI_LOOP
irng                            =  6;
deleteoldsentences              =  1;
langparamsmode                  = 21;
rtmode                          =  0;
SEP                             = '//';
starting_dic                    = 'BERT_sequence';
dic_dir                         = ['.' SEP 'LANGUAGE' SEP starting_dic SEP];
resetall                        =  1;
if ~isfolder(dic_dir)
    mkdir(dic_dir)
else
    if resetall
        delete([dic_dir SEP '*']);
    end
end
addpath(dic_dir);
root_dir                        = [SEP 'tmp' SEP 'DYSLEXIA' SEP];

   
%% bertparams
bertparams                      = BERT_getDefaultParams;
input_str                       = 'THIS PAPER';
Nsteps                          = 1;
SENTENCE_LENGTH                 = 20;  % number of words of the sentence to read
dic_name                        = starting_dic;
% idsentences                     = [72,79,6,4,3,1,1,1,1];
idsentences                     = [13, 93, 1 , 1]; % THIS PAPER IS ALSO MENTIONED IN THE SCIENTIFIC JOURNAL OF MATHEMATICS AND COMPUTER SCIENCE AND

rng(irng);                      % initialise seed;
step                            = 0;
allread                         = false;    
% for step=1:Nstps
while (~allread)
    step                        = step+1;
    if step>1 
        dictionaryfunction      = str2func(dic_name);       
        DICTIONARY              = dictionaryfunction();
%         input_str               = retrieveLevel(DICTIONARY.Sentence{sen});
        input_str               = HAI_retrieveLevel(DICTIONARY.Sentence{MDP.s(1,end)}); % last read phrase
    end
    % next LOCATION
    wstart                      = length(strsplit(input_str,' '))+1;
    
    %% BERT PREDICTION
    bertparams.forwardMasks     = SENTENCE_LENGTH-wstart;
    if bertparams.forwardMasks<6
        bertparams.HORIZON      = bertparams.forwardMasks;
        allread                 = true;             % read last words
    else
        bertparams.HORIZON      = 2+randi(3);        % uniform distribution in {3,4,5}: how many words to read
    end
    fprintf('BERT PARAMS: HORIZON: %g ', bertparams.HORIZON);
    fprintf('Number of hypotheses: %g\n',bertparams.HM);
    fprintf('Input String: "%s"\n', input_str);
    t=tic;
    GuessedSentences                = BERT_forwardSteps(input_str,bertparams);
    fprintf('Time Elapsed %g s\n',toc(t));  
    GuessedSentences                = BERT_cleanSentences(GuessedSentences); % get well formed sentences
    if length(GuessedSentences) < 1
        fprintf('Error: BERT failed to predict new sentences!');
        return
    end
    newwords                        = DICTIONARY_getWords(GuessedSentences);
    
    %% update dictionary
    dic_name                        = sprintf('%s_%s',starting_dic,fromNumToOrderedString(step));
    DICTIONARY_save(dic_name,dic_dir,newwords,GuessedSentences,deleteoldsentences);
    % DICTIONARY_print(eval(dic_name));
    pause(1);                       % wait the correct updating of the dictionary
    %% langparams for Hiearchical Active Inference (HAI)
    [langparams,noisedesc]          = HAI_getParams(langparamsmode,dic_name);
    langparams.spm_MDP_VB_H         = str2func('VB_MDP');
%     langparams.spm_MDP_VB_H         = str2func('spm_MDP_VB_X_tutorial_debug_v11');
    langparams                      = HAI_initialiseParams(langparams);
    maxT2                           = langparams.level(end).maxT;
    % update initial conditions (s) of the upper level
    sen                             = idsentences(step);
    langparams.level(end).s(1,:)    = sen*ones(1,maxT2);          % initial sentence state
    langparams.level(end).s(2,1)    = wstart;                     % initial new word location
    
    %% HIERARCHICAL ACTIVE INFERENCE  
    % run the inference
    MDP                             = HAI_RUN(langparams,dic_name);
    MDP_STEPS{step}                 = MDP; % save MDP step
    %% save graphic results
    save_dir                        = [root_dir SEP dic_name SEP];
    BAR_SUBS_plot({MDP},{noisedesc},dic_name,langparamsmode,rtmode,input_str,save_dir);
end

save([dic_dir SEP 'MDP_STEPS'],'MDP_STEPS');
rmpath(dic_dir);