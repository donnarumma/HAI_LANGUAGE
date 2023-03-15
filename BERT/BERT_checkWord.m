function   isgood = BERT_checkWord(word)
% function isgood = BERT_checkWord(word)
isgood=false(length(word),1);
for i=1:length(word)
    isgood(i)=ismember(word(i),'A':'Z');
end
isgood = all(isgood);
