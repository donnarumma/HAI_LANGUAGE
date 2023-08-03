function   sentence=BERT_getNewSentence(start_sen,Wid,bertparams)
% function sentence=BERT_getNewSentence(start_sen,Wid,bertparams)
samplemode              = bertparams.samplemode;
if samplemode==2
    DICTIONARY = bertparams.DICTIONARY();
else
    [TokenGuessed, pbscores]= BERT_getTokenIdx(start_sen,Wid,bertparams);
    isGoodToken             = BERT_checkTokens(TokenGuessed);
    cleanTokens             = TokenGuessed(isGoodToken);
end
%idx                     = find(rand < cumsum(scores),1);
words                   = DICTIONARY_getWords({start_sen});

if samplemode==0
    scores      = pbscores(isGoodToken);
    scores      = scores./sum(scores);
    idx         = find(rand < cumsum(scores),1);
    words{Wid}  = cleanTokens{idx}; 
elseif samplemode==1
    words{Wid}  = cleanTokens{1};
elseif samplemode==2
    word       = words{Wid};
    dicwords   = cellfun(@(x)(HAI_retrieveLevel(x,'')),DICTIONARY.Word,'UniformOutput',false);
    dicwords   = dicwords(~strcmp(dicwords,word));
    sends      = cellfun(@(x)(editDistance(x,word)),dicwords);
    [~,inds]   = sort(sends);
    scores     = softmax(-sends(inds(1:bertparams.HM)));
    scores     = scores/sum(scores);
    idx        = find(rand < cumsum(scores),1);
    cleanTokens= dicwords(inds);      
    words{Wid} = cleanTokens{idx};
end
sentence    = DICTIONARY_WordsToSentence(words);
