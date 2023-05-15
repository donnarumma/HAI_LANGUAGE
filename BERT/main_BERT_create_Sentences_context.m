% function main_BERT2
if ~exist('bertparams','var')
    bertparams=BERT_getDefaultParams;
else
    bertparams=BERT_getDefaultParams(bertparams.bert);
end
bertparams.Nsentences=10;

% 1) Social Sciences and Humanities
% 2) Physical Sciences and Engineering
% 3) Life Sciences
GuessedSentences=cell(0,0);
WORDS_TO_READ           = 4;
LABELS                  = [];
clindexes               = [];
input_strs              = cell(0,0);
input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           'dedicated to advancing knowledge and addressing societal challenges'];      LABELS=[LABELS,1]; clindexes = [clindexes, 25];
input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           'dedicated to advancing knowledge and addressing technological challenges']; LABELS=[LABELS,2]; clindexes = [clindexes, 25];
input_strs{end+1}       = ['Researchers seeking funding within this domain can expect their work to be evaluated by a panel of experts ' ...
                           'dedicated to advancing knowledge and addressing health challenges'];        LABELS=[LABELS,3]; clindexes = [clindexes, 25];
% input_strs{end+1}       = ['Researchers seeking funding within this panel can expect their work to be evaluated by a panel of experts ' ...
%                            'dedicated to advancing societal issues in supported proposals'];            LABELS=[LABELS,1]; clindexes = [clindexes, 22];
% input_strs{end+1}       = ['Researchers seeking funding within this panel can expect their work to be evaluated by a panel of experts ' ...
%                            'dedicated to advancing technological issues in supported proposals'];      LABELS=[LABELS,2];  clindexes = [clindexes, 22];
% input_strs{end+1}       = ['Researchers seeking funding within this panel can expect their work to be evaluated by a panel of experts ' ...
%                            'dedicated to advancing health issues in supported proposals'];             LABELS=[LABELS,3];  clindexes = [clindexes, 22];

Labels                  = [];
bertparams.Nsentences   =  2;

for i_string=1:length(input_strs) % iterate on number of initial sentences
    input_str               = input_strs{i_string};
    input_str               = upper(input_str);
    words                   = strsplit(input_str,' ');
    LEN_S                   = length(words);
    idxes                   = (length(words)-WORDS_TO_READ+1):length(words);
    N_sub_words             = length(idxes(~ismember(idxes,clindexes(i_string))));
    for idx = idxes(~ismember(idxes,clindexes(i_string))) % iterate on number of non class specific words
        TokenGuessed            = BERT_getTokenIdx(input_str,idx,bertparams);
        isGoodToken             = BERT_checkTokens(TokenGuessed);
        TokenGuessed            = TokenGuessed(isGoodToken);
        NS                      = length(TokenGuessed);
        Sentences        = cell(NS,1);
        for iS=1:NS                             % iterate on number new sentence to create for each non specific word
            Sentences{iS}='';
            for iw=1:LEN_S                      % iterate on words in the sentence
                if iw==idx
                    w = TokenGuessed{iS};
                else
                    w = words{iw};
                end 
                Sentences{iS} = [Sentences{iS} ' ' w];
            end
            Sentences{iS}     = strtrim(Sentences{iS});
        end
        try
            Sentences             = BERT_cleanSentences(Sentences);
        catch
            fprintf('WTF\n');
        end
        GuessedSentences        = [GuessedSentences; Sentences];
        Labels                  = [Labels; LABELS(i_string)*ones(length(Sentences),1)];
    end
    
end

TOTAL           =length(GuessedSentences);
GuessedSentences=DICTIONARY_reduceSentences(GuessedSentences,3,1);

[~,iA,~]        =unique(GuessedSentences);
Labels          =Labels(iA);
GuessedSentences=GuessedSentences(iA);

LABS   = unique(Labels);
N_LABS = length(LABS);

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

Labels          =Labels(goodlabels);
GuessedSentences=GuessedSentences(goodlabels);
fprintf('Expected:%g ,Total:%g, Discarderd:%g, Remaining:%g\n',N_sub_words*bertparams.Nsentences*length(input_str),TOTAL,length(GuessedSentences),TOTAL-length(GuessedSentences));

dohyphen                        = false;
CLASSES=cell(1,2+dohyphen);
for il=1:N_LABS
    lab=LABS(il);
    CLASSES{2+dohyphen}{il}=(find(Labels==lab))';
end

newwords                        = unique(DICTIONARY_getWords(GuessedSentences));
dic_name                        = 'DICTIONARY_v7';  % no class
dic_name_class                  = 'DICTIONARY_v8';  % class
dic_dir                         = 'DICTIONARY';
cleanpast                       = true;
DICTIONARY                      = DICTIONARY_save(dic_name      ,dic_dir,newwords,GuessedSentences,1,dohyphen,[]     ,cleanpast);
DICTIONARY_CLASS                = DICTIONARY_save(dic_name_class,dic_dir,newwords,GuessedSentences,1,dohyphen,CLASSES,cleanpast);

return
