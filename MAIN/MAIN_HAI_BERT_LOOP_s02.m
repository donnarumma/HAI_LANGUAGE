% function MAIN_HAI_BERT_LOOP_s02
deleteoldsentences              =  1;
langparamsmode                  = 23; % 3 levels Poisson priors % 20 % 3 levels;
rtmode                          =  0;
SEP                             = filesep;%'//';
dohyphen                        = 1;
starting_dic                    = 'BERT_v1';
expname                         = 'S02';                                        
dic_dir                         = ['.' SEP 'DICTIONARY' SEP 'BERT_DIC' SEP starting_dic '_S02' SEP];
resetall                        =  1;
if ~isfolder(dic_dir)
    mkdir(dic_dir)
else
    if resetall
        delete([dic_dir SEP '*']);
    end
end
addpath(dic_dir);
root_dir                        = [SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS' SEP];
   
%% bertparams
bertparams                      = BERT_getDefaultParams;
input_str                       = 'We present a novel computational model that uses hierarchical active inference to simulate the reading process and eye movements during reading.';
input_str                       = upper(input_str);
Nsteps                          = 1;
SENTENCE_LENGTH                 = 20+length(strsplit(input_str,' '));         % number of words of the sentence to read
dic_name                        = starting_dic;
idsentences                     = [19,19,84,73]; % 'THE COMPUTATIONAL MODEL IS ABLE TO PREDICT A TIME HORIZON FOR READING DURING A GIVEN TIME OR PLACE PERIOD'
irngBERT                        = [ 6, 6, 6, 6];
irngHAI                         = [ 7, 7, 7, 7];


step                            = 0;
allread                         = false;  
try % to add word from the starting dictionary (if exist)
    dictionaryfunction              = str2func(dic_name);       
    DICTIONARY                      = dictionaryfunction();
    curwords                        = DICTIONARY_words(DICTIONARY);
catch
    curwords                        = cell(0,0);
end
while (~allread)
    step                        = step+1;
    rng(irngBERT(step));                % initialise seed for BERT;
    

    if step>1
        dictionaryfunction      = str2func(dic_name);       
        DICTIONARY              = dictionaryfunction();
        curwords                = DICTIONARY_words(DICTIONARY);
        lastread                = HAI_retrieveLevel(DICTIONARY.Sentence{MDP.s(1,end)}); % last read sentence
        spI                     = strsplit(input_str,' ');
        spL                     = strsplit(lastread, ' ');
        spL(1:length(spI))      = spI;
        s=''; for is=1:length(spL); s=sprintf('%s %s',s,spL{is}); end; s=strtrim(s);
        input_str               = s; 
    end
    % next LOCATION
    wstart                      = length(strsplit(input_str,' '))+1;
    
    %% BERT PREDICTION
    bertparams.forwardMasks     = SENTENCE_LENGTH-wstart;
    if bertparams.forwardMasks<6
        bertparams.HORIZON      = bertparams.forwardMasks;
        allread                 = true;              % read last words
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
    if length(GuessedSentences) < 2
        fprintf('Error: BERT failed to predict new sentences!');
        return
    end
    newwords                        = DICTIONARY_getWords(GuessedSentences);
    newwords                        = erasePunctuation(newwords);
    %% update dictionary with last words (curwords) plus new words in GuessedSentences (newwords)
    dic_name                        = sprintf('%s_%s_%s',starting_dic,expname,fromNumToOrderedString(step));
    GuessedSentences                = erasePunctuation(GuessedSentences);
    DICTIONARY=DICTIONARY_save(dic_name,dic_dir,[curwords;newwords],GuessedSentences,deleteoldsentences,dohyphen);
    % DICTIONARY_print(eval(dic_name));
    pause(1);                       % wait the correct updating of the dictionary
    %% langparams for Hiearchical Active Inference (HAI)
    [langparams,noisedesc]          = HAI_getParams(langparamsmode,dic_name);
    langparams                      = HAI_initialiseParams(langparams);
    maxT2                           = langparams.level(end).maxT;
    % update initial conditions (s) of the upper level
    sen                             = idsentences(step);
    langparams.level(end).s(1,:)    = sen*ones(1,maxT2);          % initial fixed sentence identity for all the AI step
    langparams.level(end).s(2,1)    = wstart;                     % initial new word (next after last read) location on the current sentence
    
    %% HIERARCHICAL ACTIVE INFERENCE  
    % run the inference
    rng(irngHAI(step));              % initialise seed for HAI;
    MDP                             = HAI_RUN(langparams,dic_name);
    % save only saccades:
    MDP                             = HAI_smartMDP(MDP);
    fprintf('Saving %s\n',[dic_dir SEP 'MDP_STEP' fromNumToOrderedString(step)]);
    save([dic_dir SEP 'MDP_STEP' fromNumToOrderedString(step)],'MDP','langparams','GuessedSentences');
    MDP_STEPS{step}                 = MDP; % save MDP step
    %% save graphic results
    save_dir                        = [root_dir SEP dic_name SEP];
    if 0 % failes on the third level
        PLOT_BAR_modes({MDP},{noisedesc},dic_name,langparamsmode,rtmode,input_str,save_dir);
    end
    % dictionaryfunction              = str2func(dic_name);       
    % DICTIONARY                      = dictionaryfunction();
    % curwords                        = DICTIONARY_words(DICTIONARY);
        
end
InputSentence=GuessedSentences{sen};
rmpath(dic_dir);
fprintf(['Process Finished:\nInput Sentence:<<%s>>\n' ...
         'I think I read the sentence:\n<<%s>>\n' ...
         'I am sure with probability: P(sentence)=%g\n'], ...
         InputSentence,HAI_retrieveLevel(MDP.sname{1}{MDP.s(1,end)},' '),MDP.X{1}(MDP.s(1,end),end));