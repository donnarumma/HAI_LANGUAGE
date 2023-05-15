function   words = DICTIONARY_getWords(Sentences) 
% function words = DICTIONARY_getWords(Sentences) 
for is = 1:length(Sentences)
    Sentences{is}= [Sentences{is} ' '];
end
words = strsplit(strtrim([Sentences{:}]), ' ')';
words=unique(words);
end

