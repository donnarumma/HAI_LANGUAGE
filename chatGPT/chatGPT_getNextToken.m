function   [TokenGuessed, pbscores]=chatGPT_getNextToken(input_str,params)
% function [TokenGuessed, pbscores]=chatGPT_getNextToken(input_str,params)
TokenGuessed=cell(0,0); pbscores=[];
% import necessary code for net access
import matlab.net.*;
import matlab.net.http.*;

prompt=chatGPT_getPrompt(input_str,params.HM,params.HORIZON,1);
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
resp            =strsplit(response_text2,'<<');
resp            =strsplit(resp{2},'>>');
eval(resp{1});
% resp            =strsplit(response_text2,'SENTENCES');
% eval(['SENTENCES' resp{2}]);
% if length(strsplit(SENTENCES,'SENTENCES'))>1 || length(strsplit(SENTENCES,'1'))>1
    % return;
% end
ILen = length(strsplit(input_str, ' '));
Tokens=cell(length(SENTENCES),1);
good = true(length(SENTENCES),1);
for is=1:length(SENTENCES)
    sp=strsplit(SENTENCES{is},' ');
    s='';
    for ic=1:ILen
        s=sprintf('%s %s',s,sp{ic}); 
    end 
    s=strtrim(upper(s));
    if ~strcmp(s,input_str)
        good(is)=false;
    end
    Tokens{is}=upper(sp{ILen+1});
end

Tokens=Tokens(good);
Tokens=erasePunctuation(Tokens);
[TokenGuessed,~,scores]=unique(Tokens);
pbscores=nan(1,length(TokenGuessed));
for it=1:length(TokenGuessed)
    pbscores(it)= sum(scores==it);
end
pbscores=pbscores./sum(pbscores);

return