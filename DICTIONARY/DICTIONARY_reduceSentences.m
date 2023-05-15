function   GuessedSentences=DICTIONARY_reduceSentences(GuessedSentences,newlength,istail)
% function GuessedSentences=DICTIONARY_reduceSentences(GuessedSentences,newlenght,istail)

for is=1:length(GuessedSentences)
    Sentence=GuessedSentences{is};
    words=strsplit(Sentence,' ');
    LEN_S =length(words);
    if istail
        iwords=(LEN_S-newlength+1):LEN_S;
    else
        iwords=1:newlength;
    end
    s='';
    for iw=iwords
        s=sprintf('%s %s',s,words{iw});
    end
    GuessedSentences{is}=strtrim(s);
end
end