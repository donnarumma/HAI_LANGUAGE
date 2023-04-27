function   [TokenGuessed, pbscores]=chatGPT_getNextTokenWP(input_str,params)
% function [Words, Probs]=chatGPT_getNextToken(input_str,params)

% import necessary code for net access
import matlab.net.*;
import matlab.net.http.*;

prompt=chatGPT_getPrompt(input_str,params.HM,params.HORIZON,4);
fprintf('Question: %s\n',prompt);
parameters      = struct('prompt', prompt, 'max_tokens', 3000);
% Define request message using the above parameters
request         = matlab.net.http.RequestMessage('post', params.headers, parameters);
t=tic;
fprintf('Ask question to GPT\n');
response        = send(request, matlab.net.URI(params.api_endpoint));
fprintf('Answer ready. Time Elapsed %g s\n',toc(t)); 
response_text   = response.Body.Data;
response_text2  = response_text.choices(1).text;
fprintf('%s\n',response_text2);

resp            =strsplit(response_text2,'Words');
resp            =strsplit(resp{2},'Probs');
eval(['Words' resp{1}]);
eval(['Probs' resp{2}]);
TokenGuessed    =upper(Words(:)); 
pbscores        =Probs./sum(Probs);