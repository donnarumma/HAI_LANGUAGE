function   Sentences = BERT_cleanSentences(Sentences)
% function Sentences = BERT_cleanSentences(Sentences)

Sentences           = unique(Sentences);
LenS                = length(Sentences);
[issame, lens] = BERT_checkSentenceLength(Sentences);
if ~issame
    goodidx=find(~diff(lens),1);
    goodlen=lens(goodidx);
    finalidx=lens==goodlen;
    Sentences=Sentences(finalidx);
end