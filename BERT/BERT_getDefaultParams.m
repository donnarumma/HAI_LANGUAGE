function   bertparams = BERT_getDefaultParams(bertmodel)
% function bertparams = BERT_getDefaultParams(bertmodel)
if nargin > 0
    bertparams.bert = bertmodel;
    
else
    fprintf('Loading Bert model\n');t=tic;
    bertparams.bert = bert;
    fprintf('Done. Elapsed time %g s\n',toc(t));
end
bertparams.HM           = 10;   % how many alteratives allowed
bertparams.forwardMasks = 4;    % forward steps imagined in BERT
bertparams.HORIZON      = 4;    % Number of word actually sampled by BERT
bertparams.Nsentences   = 100;  % how many guessed senteces
