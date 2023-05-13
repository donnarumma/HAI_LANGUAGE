% function main_BERT2
if ~exist('bertparams','var')
    bertparams=BERT_getDefaultParams;
else
    bertparams=BERT_getDefaultParams(bertparams.bert);
end

DICTIONARY=VARIABLES_DYSLEXIA_v6;
WDS       = DICTIONARY.Word;
IW        = DICTIONARY.iW;
sentence  = {WDS{IW.I},WDS{IW.OFTEN},WDS{IW.GO},WDS{IW.TO}};
input_str = retrieveLevel(sentence);
input_str = 'IN THIS PAPER';
input_str = 'IN THIS PAPER A BIG SECRET IS';
input_str = 'IN THIS PAPER A BIG SECRET IS IS FINALLY PUT ON THE';
input_str = 'Researchers seeking FUNDING within this panel can expect their work to be evaluated by a panel of experts dedicated to advancing knowledge and addressing societal challenges';
input_str = upper(input_str);
% input_str = 'IN THIS PAPER APPEAR THE FOLLOWING TWO NEW';
% input_str = 'IN THIS PAPER IS THE FIRST FULL INTERNATIONAL';
irng=11;
rng(irng);
fprintf('BERT PARAMS: HORIZON: %g ',bertparams.HORIZON);
fprintf('Number of hypotheses: %g\n',bertparams.HM);
fprintf('Input String: "%s"\n', input_str);
t=tic;
[GuessedSentences, GuessedTokens, pbscores]=BERT_forwardSteps(input_str,bertparams);
fprintf('Time Elapsed %g s\n',toc(t));

GuessedSentences=unique(GuessedSentences);
newwords  = LANGUAGE_getWords(GuessedSentences);

dic_dir   = './LANGUAGE';
dic_name  = 'provadic';

deleteoldsentences=1;
LANGUAGE_saveDICTIONARY(dic_name,dic_dir,newwords,GuessedSentences,deleteoldsentences);
LANGUAGE_printDICTIONARY(provadic());

return
function words = LANGUAGE_getWords(GuessedSentences) 
    for is = 1:length(GuessedSentences)
        GuessedSentences{is}= [GuessedSentences{is} ' '];
    end
    words = strsplit(strtrim([GuessedSentences{:}]), ' ')';
end
