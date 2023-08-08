function   Sentences = DICTIONARY_sentences(DICTIONARY) 
% function words = DICTIONARY_words(DICTIONARY) 
    Sentence=DICTIONARY.Sentence;
    for is = 1:length(Sentence)
        Sentences{is}= [HAI_retrieveLevel(Sentence{is},' ') ' '];
    end
    Sentences=strtrim(Sentences(:));
    % Sentence;
end