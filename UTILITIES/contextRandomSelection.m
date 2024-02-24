function   ctxs = contextRandomSelection(ctx_ind,ctc_len,Nsels)
% function sent = contextRandomSelection(ind_sent,length_of_words,numb_run)
% select Nsels random contexts from ctx_ind, of length  
        ind_eval    = ctx_ind{ctc_len};
        
        rand_sent   = randi([1 length(ind_eval)],Nsels,1);
        ctxs        = ind_eval(rand_sent);
end