function   [GuessedSentences, GuessedTokens, pbscores]=BERT_forwardSteps(input_str,bertparams)
% function [GuessedSentences, GuessedTokens, pbscores]=BERT_forwardSteps(input_str,bertparams)
NS                                      = bertparams.Nsentences;
GuessedSentences                        = cell(NS,1);
GuessedTokens                           = cell(NS,1);
pbscores                                = cell(NS,1);
[Tokens0, pbscores0]                    = BERT_getNextToken(input_str,bertparams);
%% clean  Tokens
isGoodToken                             = BERT_checkTokens(Tokens0);
cleanTokens                             = Tokens0(isGoodToken);
scores                                  = pbscores0(isGoodToken);
scores                                  = scores./sum(scores);
%% create NS GuessedSentences, GuessedTokens and pbscores
cumpb               = cumsum(scores);
for is=1:NS
    idx                                 = find(rand < cumpb,1);
    input_str_tmp                       = [input_str ' ' cleanTokens{idx}];   
    [GuessedTokens{is}, pbscores{is}]   = BERT_getNextToken(input_str_tmp,bertparams);
    GuessedSentences{is}                = strtrim(input_str_tmp);
end
% remaining step forward
for it=1:bertparams.HORIZON-1 
    bertparamsit=bertparams;
    bertparamsit.forwardMasks                   = bertparams.forwardMasks-it;
    [nGuessedSentences,nGuessedTokens,npbscores]= BERT_getNextGuess(GuessedSentences,GuessedTokens,pbscores,bertparamsit);

    GuessedSentences=nGuessedSentences;
    GuessedTokens   =nGuessedTokens;
    pbscores        =npbscores;
%     [GuessedSentences, GuessedTokens, pbscores] = BERT_getNextGuess(GuessedSentences,GuessedTokens,pbscores,bertparams);
    
    
end
% unique(GuessedSentences)
