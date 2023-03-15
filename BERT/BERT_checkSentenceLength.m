function   [issame, lens] = BERT_checkSentenceLength(Sentences)
% function [issame, lens] = BERT_checkSentenceLength(Sentences)
LENS=length(Sentences);
lens = zeros(LENS,1);
for is=1:LENS
    sentence=strtrim(Sentences{is});
    lens(is)=length( strsplit( sentence , ' ' ) );
end
issame = ~sum(abs(diff(lens)));
end