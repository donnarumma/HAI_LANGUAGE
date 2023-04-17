function   words = DICTIONARY_words(DICTIONARY) 
% function words = DICTIONARY_words(DICTIONARY) 
    Words=DICTIONARY.Word;
    for is = 1:length(Words)
        Words{is}= [HAI_retrieveLevel(Words{is},'') ' '];
    end
    words = strsplit(strtrim([Words{:}]), ' ')';
end
