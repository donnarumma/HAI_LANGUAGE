% function main_BERT_ERC_DIctionary
if ~exist('bertparams','var')
    bertparams=BERT_getDefaultParams;
else
    bertparams=BERT_getDefaultParams(bertparams.bert);
end
% bertparams.Nsentences=3;%10;
bertparams.HM           =10;
CLASSNAMES={'Social Sciences and Humanities','Physical Sciences and Engineering','Life Sciences'};
% 1) Social Sciences and Humanities
% 2) Physical Sciences and Engineering
% 3) Life Sciences
GuessedSentences        =cell(0,0);
WORDS_TO_READ           = 7;%8;
LABELS                  = [];
clindexes               = cell(0,0);
input_strs              = cell(0,0);
class_specific_words    = cell(0,length(CLASSNAMES));
input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           'dedicated to advancing scientific knowledge and addressing societal challenges'];  clindexes{end+1}= 26;
input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           'dedicated to advancing cultural knowledge and addressing societal challenges'];  clindexes{end+1} = [22, 26];
% input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           % 'dedicated to advancing societal issues in supported proposals'];        clindexes = [clindexes, 22];

class_specific_words{end+1}= upper({'societal','technological','health'});

class_specific_words{end+1}= [upper({'cultural','computational','medical'});upper({'societal','technological','health'})];

% class_specific_words    = upper(class_specific_words);
Labels                  = [];
N_LABS                  = length(class_specific_words);
class_labels            = 1:N_LABS;

for i_string=1:length(input_strs) % iterate on number of initial sentences
    input_str               = input_strs{i_string};
    input_str               = upper(input_str);
    words                   = strsplit(input_str,' ');
    LEN_S                   = length(words);
    idxes                   = (length(words)-WORDS_TO_READ+1):length(words);
    N_non_specific_words    = length(idxes(~ismember(idxes,clindexes{i_string})));
    for idx = idxes(~ismember(idxes,clindexes{i_string})) % iterate on number of non class specific words
        TokenGuessed            = BERT_getTokenIdx(input_str,idx,bertparams);
        isGoodToken             = BERT_checkTokens(TokenGuessed);
        TokenGuessed            = TokenGuessed(isGoodToken);
        NS                      = length(TokenGuessed);
        for ic=1:N_LABS                             % iterate on number of labels
            Sentences        = cell(NS,1);
            
            for iS=1:NS                             % iterate on number new sentence to create for each non specific word
                Sentences{iS}='';
                
                for iw=1:LEN_S                      % iterate on words in the sentence
                    if iw==idx
                        w = TokenGuessed{iS};
                    elseif ismember(iw,clindexes{i_string})
                        cli=find(clindexes{i_string}==iw);
                        w = class_specific_words{i_string}{cli,ic};
                    else
                        w = words{iw};
                    end 
                    Sentences{iS} = [Sentences{iS} ' ' w];
                end
                
                Sentences{iS}     = strtrim(Sentences{iS});
            end        
            
            Sentences             = BERT_cleanSentences(Sentences);
            GuessedSentences      = [GuessedSentences; Sentences];
            Labels                = [Labels; ic*ones(length(Sentences),1)];
        end
    end
    
end

TOTAL           =length(GuessedSentences);
GuessedSentences=DICTIONARY_reduceSentences(GuessedSentences,WORDS_TO_READ+2,1);

[~,iA,~]        =unique(GuessedSentences);
Labels          =Labels(iA);
GuessedSentences=GuessedSentences(iA);

LABS                    = unique(Labels);
N_LABS                  = length(LABS);
lenlabs=nan(1,N_LABS);
for il=1:N_LABS
    lenlabs(il)=sum(Labels==LABS(il));
end
labperclass=min(lenlabs);
goodlabels=true(size(Labels));
for il=1:N_LABS
    lbs = find(Labels==LABS(il));
    goodlabels(lbs(labperclass+1:end))=false;
end


dohyphen                            = false;
dohyphen                            = true;
if dohyphen
    dic_name                        = 'DICTIONARY_v7';  % no class
    dic_name_class                  = 'DICTIONARY_v8';  % class
else
    dic_name                        = 'DICTIONARY_v5';  % no class
    dic_name_class                  = 'DICTIONARY_v6';  % class
end

Labels          =Labels(goodlabels);
GuessedSentences=GuessedSentences(goodlabels);

CLASSES=cell(1,dohyphen+2);
for il=1:N_LABS
    lab=LABS(il);
    CLASSES{dohyphen+2}{il}=(find(Labels==lab))';
end
NO_CLASSES=cell(1,dohyphen+2);
for il=1:length(GuessedSentences)
    NO_CLASSES{dohyphen+2}{il}=il;
end
% NO_CLASSES{dohyphen+2}{1}=1:length(GuessedSentences);
newwords                        = DICTIONARY_getWords(GuessedSentences);
% dic_name                        = 'DICTIONARY_v5';  % no class
% dic_name_class                  = 'DICTIONARY_v6';  % class
dic_dir                         = 'DICTIONARY';
cleanpast                       = true;
DICTIONARY                      = DICTIONARY_save(dic_name      ,dic_dir,newwords,GuessedSentences,1,dohyphen,        [],cleanpast);
% DICTIONARY                      = DICTIONARY_save(dic_name      ,dic_dir,newwords,GuessedSentences,1,dohyphen,NO_CLASSES,cleanpast);
DICTIONARY_CLASS                = DICTIONARY_save(dic_name_class,dic_dir,newwords,GuessedSentences,1,dohyphen,CLASSES   ,cleanpast);




fprintf('Expected:%g ,Total:%g, Remaining:%g, Discarded:%g\n',N_non_specific_words*length(class_specific_words)*bertparams.HM*length(input_strs),TOTAL,length(GuessedSentences),TOTAL-length(GuessedSentences));

return

