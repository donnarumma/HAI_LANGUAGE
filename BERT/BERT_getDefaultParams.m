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
bertparams.DICTIONARY   = [];
% param for for BERT_getNewSentence
% 0 sample from the first HM alternatives allowed
% 1 get the best aleternative 
% 2 get the nearest word in editdistance (need dictionary field not empty)
bertparams.samplemode   = 0;    