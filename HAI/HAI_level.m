function   Words = HAI_level(MDP,Dspace) 
% function words = DICTIONARY_words(DICTIONARY) 
    Words=MDP.sname{1};
    for is = 1:length(Words)
        Words{is}= [HAI_retrieveLevel(Words{is},Dspace)];
    end
    % words = strsplit(strtrim([Words{:}]), ' ')';
end