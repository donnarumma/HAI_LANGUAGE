function   params = chatGPT_getDefaultParams()
% function params = chatGPT_getDefaultParams()

% import necessary code for net access
% import matlab.net.*;
% import matlab.net.http.*;

params.apifile          ='API-key.txt';
params.api_key          = string(fileread(params.apifile));
% Maximum number of times to try before giving up.
params.num_solution     = 1;
params.max_attempt      = 6;
params.attempt_counter  = 0;
% define api endpoint
params.api_endpoint     = "https://api.openai.com/v1/engines/text-davinci-003/completions";
% define headers for the API request
params.headers          = matlab.net.http.HeaderField('Content-Type', 'application/json');
params.headers(2)       = matlab.net.http.HeaderField('Authorization', 'Bearer ' + params.api_key);
% define parameters required

params.HM               = 10;   % how many alteratives allowed
params.forwardMasks     = 4;    % forward steps imagined in BERT
params.HORIZON          = 4;    % Number of word actually sampled by BERT
params.Nsentences       = 100;  % how many guessed senteces

return
%prompt = "input sentence: <<This paper is about a hierachical language model capable of reading sentences>> Predict how the sentence continue (give me 5 sentences with 3 more words and the probability for each word and sentence";
% Horizon         = 23;
% HorStr          = num2str(Horizon);
% NumAlternatives = 10;
% NumStr          = num2str(NumAlternatives);



input_str = "This paper is about a hierachical language model capable of simulate human reading. The goal of ";

prompt=getGPTprompt(input_str,NumStr,HorStr,1);
fprintf('Question: %s\n',prompt);
parameters      = struct('prompt', prompt, 'max_tokens', 3000);
% Define request message using the above parameters
request         = matlab.net.http.RequestMessage('post', headers, parameters);
t=tic;
fprintf('Ask question to GPT\n');
response = send(request, URI(api_endpoint));
fprintf('Answer ready. Time Elapsed %g s\n',toc(t)); 
response_text = response.Body.Data;
response_text2 = response_text.choices(1).text;
fprintf('%s\n',response_text2);

resp=strsplit(response_text2,'Words');
resp=strsplit(resp{2},'Probs');
eval(['Words' resp{1}]);
eval(['Probs' resp{2}]);
