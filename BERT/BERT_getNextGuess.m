function   [GuessedSentences, GuessedTokens, newpbscores] = BERT_getNextGuess(Sentences,Tokens,pbscores,bertparams)
% function [GuessedSentences, GuessedTokens, newpbscores] = BERT_getNextGuess(Sentences,Tokens,pbscores,bertparams)
    HMsen           = length(Sentences);
    GuessedSentences= cell(HMsen,1);
    GuessedTokens   = Tokens;
    newpbscores     = pbscores;
    for is=1:HMsen
        %% clean  Tokens
        isGoodToken                         = BERT_checkTokens(GuessedTokens{is});
        cleanTokens                         = GuessedTokens{is}(isGoodToken);
        scores                              = newpbscores{is}(isGoodToken);
        scores                              = scores./sum(scores);
        %% sample token with corresponding score
        idx                                 = find(rand < cumsum(scores),1);
        input_str_tmp                       = [Sentences{is}, ' ' cleanTokens{idx}];
        [GuessedTokens{is}, newpbscores{is}]= BERT_getNextToken(input_str_tmp,bertparams);
        GuessedSentences{is}                = strtrim(input_str_tmp);
    end
end
