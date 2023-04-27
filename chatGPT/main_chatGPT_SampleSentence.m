% function main_chatGPT_SampleSentence
% sample a sentence asking to chat GPT API
GPTparams       = chatGPT_getDefaultParams;
% input_str       = 'WE PRESENT A NOVEL COMPUTATIONAL MODEL THAT USES HIERARCHICAL ACTIVE INFERENCE TO SIMULATE THE READING PROCESS AND EYE MOVEMENTS DURING READING.';
% input_str       = "This paper is about a hierachical language model capable of simulate human reading.";
input_str       = "We present a novel computational model that uses hierarchical active inference to simulate the reading process and eye movements during reading.";

FinalLen        = 20;
startN          = length(strsplit(input_str', ' '));
input_str       = upper(input_str);
TotalN          = startN+FinalLen;
GPTparams.HORIZON=TotalN;
iw              = startN+1;
while iw<TotalN+1
    iw=iw+1;
    try
        clear Tokens0 pbscores0;
        [Tokens0, pbscores0]  = chatGPT_getNextToken(input_str,GPTparams);
        pbscores0
        if ~isempty(Tokens0)
            [val,ind]=max(pbscores0);
           
            fprintf('Chosen: %s (p=%g)\n',Tokens0{ind},val);
            input_str=[input_str + " " + Tokens0{ind}];
        else
            iw=iw-1;
        end
    catch
        iw = iw-1;
    end
    fprintf('End of GPT request\n\n');
end
Sentence = input_str;
fprintf('Final Sentence: %s\n',Sentence)
return

% https://it.mathworks.com/matlabcentral/fileexchange/128093-autonomous-collaborative-between-gpt-and-matlab