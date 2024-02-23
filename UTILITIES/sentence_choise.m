% funzione per la scelta random della sentences
function sent = sentence_choise(ind_sent,length_of_words,numb_run)

        ind_eval = ind_sent{length_of_words};
        
        rand_sent = randi([1 length(ind_eval)],numb_run,1);
        sent = ind_eval(rand_sent);
end