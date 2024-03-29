function  isGoodToken   = BERT_checkTokens(Tokens)
%function isGoodToken   = BERT_checkTokens(Tokens)

cleanTokens             = erasePunctuation(Tokens);

isNotPunctuation        = strcmp(Tokens,cleanTokens);

isNotEmpty              = ~strcmp('',strtrim(Tokens));

lenT                    = length(Tokens);
notnumbers              = true(lenT,1);
isgoodChar              = true(lenT,1);
for it=1:lenT
    tokenconverted      = str2double(Tokens{it});
    if ~isnan(tokenconverted) && isnumeric(tokenconverted)
        notnumbers(it)  = false;
    end
    isgoodChar(it)      =BERT_checkWord(Tokens{it});
end
isGoodToken             = isNotPunctuation & notnumbers & isNotEmpty & isgoodChar;

