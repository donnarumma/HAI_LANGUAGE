% funzione per conoscere il numero di parole delle sentences di ogni lunghezza del
% vocabolario
function [ind_sent,sent_lett_numb,len_sent] = sentlength(sentences)
    
    len_sent = zeros(length(sentences),1);
    for i = 1:length(sentences)
        sentence = sentences{i};
        sentence = sentence(find(~isspace(sentence)));
        len_sent(i) = length(sentence);
    end
    max_numb_lett = max(len_sent);
    min_numb_lett = min(len_sent);
    ind_sent = cell(max_numb_lett,1);
    sent_lett_numb = zeros(max_numb_lett,1);
    for i = min_numb_lett:max_numb_lett
        ind_sent{i,1} = find(len_sent==i);
        sent_lett_numb(i) = length(ind_sent{i});
    end
end
