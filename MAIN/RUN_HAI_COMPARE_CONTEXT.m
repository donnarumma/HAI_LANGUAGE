function   MDP=RUN_HAI_COMPARE_CONTEXT(dictionary,idsentence,irng,context_prior)
% function MDP=RUN_HAI_COMPARE_CONTEXT(dictionary,idsentence,irng,context_prior)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wstart                             = 1;
dic_fun                            = str2func(dictionary);
DIC                                = dic_fun();

%% get params with the selected dictionary
% langparams                         = HAI_getDefaultParams(dictionary);
langparams                         = HAI_getParams(1,dictionary);
langparams.level(end).jump         = 1;                            % 1 location can be reached from any state | 0 sequential location steps
langparams.level(end).umode        =-1;                            % DEPRECATED: -1 all possible policies, 0 remove policy [1,1,1]
langparams.ID                      =100;
for il=1:length(langparams.level)
    langparams.level(il).obsnoise     = [0.0,0.0];  % noise on [word    ,Location,  report] recognition 
    langparams.level(il).statesnoise  = [0.0,0.0];  % noise on [sentence,Location, context]  transitionlangparams                         = HAI_initialiseParams(langparams);
end

if ~isempty(langparams.level(end).CLASSES)
    langparams.level(end).obsnoise     = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
    langparams.level(end).statesnoise  = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transitionlangparams                         = HAI_initialiseParams(langparams);
    LABELS                             = zeros(length(DIC.Sentence),1);
    for ic=1:length(DIC.CLASSES{end})
        LABELS(DIC.CLASSES{end}{ic})=ic;
    end
end
%% set seed
langparams.irng                    = irng;
%% set higher level to true sentence
% 
langparams.level(end).maxT         = 16;
langparams.level(end).unknown      = false;
langparams                         = HAI_initialiseParams(langparams);
if ~isempty(langparams.level(end).CLASSES) && context_prior
    langparams.level(end).D{end}   =langparams.level(end).D{end}*0;
    langparams.level(end).D{end}(LABELS(idsentence))=1;
end
maxT                               = langparams.level(end).maxT;
langparams.level(end).s(1,:)       = ones(1,maxT)*idsentence;  % initial sentence state
langparams.level(end).s(2,1)       = wstart;
%% other options if needed
for iLev=1:length(langparams.level)
    langparams.level(iLev).chi     = 1/8; % confidence level on exit level iLev
    langparams.level(iLev).factor  = 1;
end
%% run the inference

MDP                                = HAI_RUN(langparams,dictionary);

%% create BAR NOISE PLOT
SEP = filesep;
root_dir =[SEP 'tmp' SEP 'TESTS' SEP 'HAI_LANGUAGE_TESTS' SEP 'LEVEL' num2str(MDP.level) SEP]; % saving in results /tmp/HAI_LANGUAGE_TESTS/
save_dir =[root_dir SEP dictionary SEP 'SENTENCE' fromNumToOrderedString(idsentence) SEP];

MDP      = HAI_smartMDP(MDP);
if ~isfolder(save_dir) 
    mkdir(save_dir); 
end
fprintf('Saving %s.mat\n',[save_dir SEP 'MDP']);
save([save_dir SEP 'MDP'],'MDP');

return