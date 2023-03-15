function   [TokenGuessed, pbscores]=BERT_getNextToken(input_str,params)
% function [TokenGuessed, pbscores]=BERT_getNextToken(input_str,params)
%% Predict Masked Tokens Using BERT

%% Load Pretrained BERT Model
% Load a pretrained BERT model using the |bert| function. The model
% consists of a tokenizer that encodes text as sequences of integers, and a
% structure of parameters.
mdl                 = params.bert;            % preloaded bert model
HM                  = params.HM;              % how many alternatives
forwardMasks        = params.forwardMasks;    % horizon of the sentence
%%
% View the BERT model tokenizer. The tokenizer encodes text as sequences of
% integers and holds the details of padding, start, separator and mask
% tokens.
tokenizer           = mdl.Tokenizer;
%% Calculate Prediction Scores
% To get the prediction scores for each word in the model vocabulary, you
% can evaluate the language model directly using the |bert.languageModel|
% function.

%%
% First, tokenize the input sentence with the BERT model tokenizer using
% the |tokenize| function. Note that the tokenizer may split single words
% and also prepends a [CLS] token and appends a [SEP] token to the input.
tokens              = tokenize(tokenizer,input_str);
% add a token mask in the last place
idx                 = length(tokens{1});
closet              = tokens{1}(end);
for t=1:forwardMasks
    tokens{1}(idx+t-1)  = tokenizer.MaskToken;
    tokens{1}(idx+t)    = closet;
end
%%
% Encode the tokens using the BERT model tokenizer using the |encodeTokens|
% function.
Xenc                = encodeTokens(tokenizer,tokens);
%%
% To get the predictions scores from for the encoded tokens, evaluate the
% BERT language model directly using the |bert.languageModel| function. The
% language model output is a VocabularySize-by-SequenceLength array.
scores              = bert.languageModel(Xenc{1},mdl.Parameters);

%%
% View the tokens of the BERT model vocabulary corresponding to the top HM
% prediction scores for the mask token.
[~,idxTop]          = maxk(extractdata(scores(:,idx)),HM);
TokenGuessed        = arrayfun(@(x) decode(tokenizer,x), idxTop);
% TokenGuessed        = getTokens(tokenizer,idxTop);
TokenGuessed        = upper(TokenGuessed);
pbscores            = double(extractdata(scores(idxTop,idx)));
pbscores            = pbscores./sum(pbscores);


end

function   GuessedTokens=getTokens(tokenizer,idxTop)
% function GuessedTokens=getTokens(tokenizer,idxTop)
    [r,c]=size(idxTop);
    GuessedTokens=strings(r,c);
    for i=1:r 
        for j=1:c
            GuessedTokens(i,j)=decode(tokenizer,idxTop(i,j)); 
        end
    end
end