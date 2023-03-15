% function main_BERT_OLD

if ~exist('bertparams','var')
    bertparams=getDefaultBertParams;
else
    bertparams=getDefaultBertParams(bertparams.bert);
end

DICTIONARY=VARIABLES_DYSLEXIA_v6;
WDS       = DICTIONARY.Word;
IW        = DICTIONARY.iW;
sentence = {WDS{IW.I},WDS{IW.OFTEN},WDS{IW.GO},WDS{IW.TO}};
input_str = retrieveLevel_backup(sentence,' ',1);

irng=9;
rng(irng);

% Step 1 forward
GuessedSentences=cell(bertparams.HM,1);
GuessedTokens   =cell(bertparams.HM,1);
pbscores        =cell(bertparams.HM,1);
[Tokens1, pbscores1]=DONNARUMMA_BERT(input_str,bertparams);
for iGT=1:length(Tokens1)
    idx                     = find(rand < cumsum(pbscores1),1);
    input_str_tmp           = [input_str Tokens1{idx} ' '];
    [GuessedTokens{iGT}, pbscores{iGT}]=DONNARUMMA_BERT(input_str_tmp,bertparams);
    GuessedSentences{iGT}    = input_str_tmp;
end
% remaining step forward
for it=1:bertparams.HORIZON-1 
    [GuessedSentences, GuessedTokens, newpbscores] = getLello(GuessedSentences,GuessedTokens,pbscores,bertparams);
end

unique(GuessedSentences)

return
% return

% if 1
%     rng(irng)
%     for is=1:length(GuessedSentences)
%         idx                     = find(rand < cumsum(pbscores{is}),1);
%         input_str_tmp = [GuessedSentences{is}, GuessedTokens{is}{idx} ' '];
%         [GuessedTokens{is}, pbscores{is}]=DONNARUMMA_BERT(input_str_tmp,bertparams);
%         GuessedSentences{is}    = input_str_tmp;
%     end
% end
% return
% rng(irng)
% [GuessedSentences, GuessedTokens, newpbscores] = getLello(GuessedSentences,GuessedTokens,pbscores,bertparams);
return
function [GuessedSentences, GuessedTokens, newpbscores] = getLello(Sentences,Tokens,pbscores,bertparams)
    HMsen           = length(Sentences);
    GuessedSentences= cell(HMsen,1);
    for is=1:HMsen
        idx                     = find(rand < cumsum(pbscores{is}),1);
        input_str_tmp = [Sentences{is}, Tokens{is}{idx} ' '];
        [GuessedTokens{is}, newpbscores{is}]=DONNARUMMA_BERT(input_str_tmp,bertparams);
        GuessedSentences{is}             = input_str_tmp;
    end
end