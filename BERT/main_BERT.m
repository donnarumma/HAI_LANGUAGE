% function main_BERT

if ~exist('bertparams','var')
    bertparams=getDefaultBertParams;
else
    bertparams=getDefaultBertParams(bertparams.bert);
end

DICTIONARY=VARIABLES_DYSLEXIA_v6;
WDS       = DICTIONARY.Word;
IW        = DICTIONARY.iW;
sentence = {WDS{IW.I},WDS{IW.OFTEN},WDS{IW.GO},WDS{IW.TO}};
input_str = retrieveLevel(sentence,' ',1);

irng=9;
rng(irng);
fprintf('BERT PARAMS: HORIZON: %g ',bertparams.HORIZON);
fprintf('Number of hypotheses: %g\n',bertparams.HM);
fprintf('Input String: "%s"\n', input_str);
% Step 1 forward
GuessedSentences=cell(params.HM,1);
GuessedTokens   =cell(params.HM,1);
pbscores        =cell(params.HM,1);
[Tokens1, pbscores1]=BERT_getNextToken(input_str,bertparams);
for iGT=1:length(Tokens1)
    idx                     = find(rand < cumsum(pbscores1),1);
    input_str_tmp           =[input_str ' ' Tokens1{idx}];
    [GuessedTokens{iGT}, pbscores{iGT}]=BERT_getNextToken(input_str_tmp,bertparams);
    GuessedSentences{iGT}    = input_str_tmp;
end
% remaining step forward
for it=1:bertparams.HORIZON-1 
    [GuessedSentences, GuessedTokens, pbscores] = BERT_getNextGuess(GuessedSentences,GuessedTokens,pbscores,bertparams);
end
unique(GuessedSentences)

return

function [GuessedSentences, GuessedTokens, newpbscores] = getNextGuess(Sentences,Tokens,pbscores,bertparams)
    HMsen           = length(Sentences);
    GuessedSentences= cell(HMsen,1);
    for is=1:HMsen
        idx                     = find(rand < cumsum(pbscores{is}),1);
        input_str_tmp = [Sentences{is}, Tokens{is}{idx} ' '];
        [GuessedTokens{is}, newpbscores{is}]=DONNARUMMA_BERT(input_str_tmp,bertparams);
        GuessedSentences{is}             = input_str_tmp;
    end
end
