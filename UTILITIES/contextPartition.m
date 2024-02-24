function   [ctx_ind,ctx_size,ctx_len] = contextPartition(contexts)
% function [ctx_ind,ctx_size,ctx_len] = contextPartition(contexts)
% number of words of different lengths 
    
    ctx_len = zeros(length(contexts),1);
    for i = 1:length(contexts)
        context = contexts{i};
        context = context(find(~isspace(context)));
        ctx_len(i) = length(context);
    end
    max_numb_lett = max(ctx_len);
    min_numb_lett = min(ctx_len);
    ctx_ind = cell(max_numb_lett,1);
    ctx_size = zeros(max_numb_lett,1);
    for i = min_numb_lett:max_numb_lett
        ctx_ind{i,1} = find(ctx_len==i);
        ctx_size(i) = length(ctx_ind{i});
    end
end
