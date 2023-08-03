cleanpast                       = true;
dohyphen                        = true;
deleteoldsentences              = true;
langparamsmode                  = 23; % 3 levels Poisson priors % 20 % 3 levels;
SEP                             = filesep;%'//';
starting_dic                    = 'DICTIONARY_v15';
dictionary_func                 = str2func(starting_dic);
DICTIONARY                      = dictionary_func();
expname                         = 'SHOW';                                        
dic_dir                         = ['DICTIONARY' SEP 'BERT_DIC' SEP starting_dic '_' expname SEP];
resetall                        =  1;
save_dir                        = '~/TESTS/HAI_LANGUAGE_TESTS/SHOW/';
dic_dir                         = [save_dir dic_dir];
bertparams                      = BERT_getDefaultParams;

% start_sen                       = upper('Hierarchical active inference model of eye movements');
start_sen                       = upper('active inference model of eye movements');
% GuessedSentences{1}             =start_sen;

curwords                        = cellfun(@(x)(HAI_retrieveLevel(x,'')),DICTIONARY.Word,'UniformOutput',false);
senwords                        = DICTIONARY_getWords({start_sen});
LEN_SEN                         = length(senwords);
newwords                        = [senwords; 'HOERARCHICAL'; 'HIERARCHIC'; 'HIERARCHY'; 'ACTIVITY' ;'DIFFERENCE';'INFERENTIAL','MODAL','MODULAR','MOVEABLE','MOVEMENT'];
sentences                       = {start_sen};
step                            = 1;
dic_name                        = sprintf('%s_%s_%s',starting_dic,expname,fromNumToOrderedString(step));
if ~isfolder(dic_dir)
    mkdir(dic_dir);
end
addpath(dic_dir);
if 0
    GuessedSentences                = sentences;      
    bertparams.samplemode           = 2;
    MAXS                            = 50;
    DICTIONARY                      = DICTIONARY_save(dic_name,dic_dir,[curwords;newwords],GuessedSentences,deleteoldsentences,dohyphen);
    bertparams.DICTIONARY           = str2func(dic_name); 
    % GuessedSentences=cell(MAXS,1);
    rng(step);
    while length(GuessedSentences)<MAXS
        Wid                           = randi(LEN_SEN);
        sentence                      = BERT_getNewSentence(start_sen,Wid,bertparams);
        GuessedSentences{end+1}       = sentence;
        GuessedSentences              = BERT_cleanSentences(GuessedSentences); % get well formed sentences
        fprintf('Sentences: %g\n',length(GuessedSentences));
    end
else
    clear GuessedSentences;
    GuessedSentences{1}    = start_sen;
    GuessedSentences{end+1}='ACTIVITY INFERENCE MODEL OF EYE MOVEMENTS';
    GuessedSentences{end+1}='ACTIVE INFERENTIAL MODEL OF EYE MOVEMENTS';
    GuessedSentences{end+1}='ACTIVE INFERENCE MODAL OF EYE MOVEMENTS';
    GuessedSentences{end+1}='ACTIVE INFERENCE MODEL OF EYE MOVEMENT';
    %% SUFFICIENT
    GuessedSentences{end+1}='INACTIVE INFERENCE MODEL OF EYE MOVEMENTS';
    GuessedSentences{end+1}='INTERACTIVE INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='PASSIVE INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='REMOTE INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='PROBABILISTIC INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='BAYESIAN INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='REACTIVE INFERENCE MODEL OF EYE MOVEMENT';
    GuessedSentences{end+1}='ACTIVES INFERENCE MODEL OF EYE MOVEMENT';
    
end   
% if ~isfolder(dic_dir)
%     mkdir(dic_dir)
% else
%     if resetall
%         delete([dic_dir SEP '*']);
%     end
% end
addpath(dic_dir);
pause(5);
%%
DICTIONARY=DICTIONARY_save(dic_name,dic_dir,[curwords;newwords;DICTIONARY_getWords(GuessedSentences)],GuessedSentences(:),deleteoldsentences,dohyphen,[],cleanpast);
while(size(DICTIONARY.Sentence,1)==1)
    pause(10);
    clear DICTIONARY;
    DICTIONARY=DICTIONARY_save(dic_name,dic_dir,[curwords;newwords;DICTIONARY_getWords(GuessedSentences)],GuessedSentences(:),deleteoldsentences,dohyphen,[],cleanpast);
end
%%
sends = cellfun(@(x)(editDistance(x,start_sen)),DICTIONARY_sentences(DICTIONARY));
[~,sen] = min(sends);

root_dir                        = [SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS' SEP];
step=1;
% sen                             = 24;    
irngHAI                         = 1;
pause(1);
langparams                      = HAI_getParams(langparamsmode,dic_name);
for ilev=1:length(langparams.level)
    langparams.level(ilev).VBNi=ilev*2^4;
end
langparams                      = HAI_initialiseParams(langparams);
wstart                          = 1;
langparams.level(end).s(1,:)    = sen*ones(1,langparams.level(end).maxT);          % initial fixed sentence identity for all the AI step
% langparams.level(end).s(2,1:5)  =[1,2,3,4,7]; % initial new word (next after last read) location on the current sentence
langparams.level(end).s(2,1:4)  =[1,2,3,6]; % initial new word (next after last read) location on the current sentence

%% HIERARCHICAL ACTIVE INFERENCE  
% run the inference
rng(irngHAI(step));              % initialise seed for HAI;
MDP                             = HAI_RUN(langparams,dic_name);
% save only saccades:
MDP                             = HAI_smartMDP(MDP);
fprintf('Saving %s\n',[dic_dir SEP 'MDP_STEP' fromNumToOrderedString(step)]);
save([dic_dir SEP 'MDP_STEP' fromNumToOrderedString(step)],'MDP','langparams','GuessedSentences');
EXPMDP.MDP=MDP;
HAI_disp(MDP);
return
%%

pltparams               = PLOT_defaultParams;
pltparams.hfig          = figure('visible','off');
pltparams.NUMBW_LINE    = 4;
% pltparams.NUMBW_LINE    = 6;

sub_save_dir = '~/TESTS/HAI_LANGUAGE_TESTS/IMAGES/';
ext='pdf'; hfig=pltparams.hfig ;
nf  = sprintf('SACCADES_DEDICATED_SHOW_%g.%s',pltparams.NUMBW_LINE,'pdf');
fprintf('Saving %s\n',[sub_save_dir nf]);
PLOT_Saccades_paragraph({MDP},pltparams);
exportgraphics(hfig,[sub_save_dir nf]);
% EXPMDP.MDP=MDP;
%%
probLevel   = HAI_getTimeProb(EXPMDP.MDP);
hai_neu     = HAI_getNeuralStatistics(EXPMDP.MDP,pltparams);
[x,t,dt]    = HAI_humanlike(EXPMDP.MDP,hai_neu.z,pltparams);

HAI_GetLevelSteps
16*3*size(probLevel{3},1);
16*2*size(probLevel{2},1);
16*1*size(probLevel{1},1);