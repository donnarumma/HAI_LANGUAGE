% main HAI_LANGUAGE_DICTIONARY_main_Frosolone
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clear MDPsub;
rtmode                             = 0;  % 1 reaction time, 0 recognition steps

irng                               = randi([1 10],1); %'default';
% imode                              = 0; OLD COMMAND TO RETURN TO FRISTON MODE

paramsmodes                        = 25;
numb_run                           = 1;

NSubs = 1;
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedescription                   = cell(NSubs,1);
dictionary                         = 'BERT_1_8';
     %% get params with the selected dictionary
    [par_series,noisedescription] = HAI_getParams(paramsmodes,dictionary);   
    par_series                         = HAI_initialiseParams(par_series);
    %% set seed
    par_series.irng                     = irng;
    maxT                                = par_series.level(end).maxT;       % initial      sentence state


%     pause;
%%-----SENTENCE SELECTION
idsentences = zeros(paramsmodes);
Accuracy = cell(numb_run,1);
numb_sacc_lev_LOW = cell(numb_run,1);
numb_sacc_lev_HIGH =  cell(numb_run,1);
numb_of_extra = cell(numb_run,1);
sent_eval = cell(numb_run,1);
    
length_of_words = 8;
load BERT_1_8.mat
    
[ind_sent,sent_lett_numb,len_sent] = sentlength(sentences);
    
id_sent_run = [sentence_choise(ind_sent,length_of_words,numb_run)];

for var = 1:numb_run
    idsentences(paramsmodes) = id_sent_run(var);
    id_route = sentences{idsentences(paramsmodes)};
    id_route = strrep(id_route,' ','_');
    sent_eval(var,1) = {id_route};
    % idsentences(paramsmodes)          = randi([1 length(words)]);

     %% set higher level to true sentence
%     maxT                                      = par_series.level(end).maxT;
    par_series.level(end).s(1,:)        = ones(1,maxT)*idsentences(paramsmodes); 
    %% run the inference
        MDPsub                             =HAI_RUN(par_series,dictionary);
        fprintf('Ended computation for SubjectID%g\n',paramsmodes);
    
        SEP = '//';
        root_dir = ['.' SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS'];
        save_dir =[root_dir  SEP          dictionary  SEP id_route SEP];
%     
%     
%         PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,'',save_dir,id_route)
        %% save MDP in directory
        expID=fromNumToOrderedString(paramsmodes,100);
            sub_save_dir = strcat(sprintf('%s/ID%s/',save_dir,expID));
            if ~isfolder(sub_save_dir)
                mkdir(sub_save_dir);
        end
    
    save([sub_save_dir SEP strcat('MDPsub_',id_route)],'MDPsub','-v7.3');
    %% evaluate Accuracy and Saccades
    T_H = MDPsub.T;
    [v,m] = max(MDPsub.X{1, 1}(:,T_H));
    if T_H  == maxT
        numb_of_extra(var,1) = {1};
    else
        numb_of_extra(var,1) = {0};
    end
    if MDPsub.s(1,end) == m
        Acc = 1;
    else
        Acc = 0;
    end
    Accuracy(var,1) = {Acc};
    
    sacc_low = zeros(1,length(MDPsub.mdp));
    for i = 1:length(MDPsub.mdp)
        sacc_low(i) = MDPsub.mdp(i).T;
    end
    numb_sacc_lev_LOW(var,1) = {sacc_low};
    
    numb_sacc_lev_HIGH(var,1) = {T_H};
end
%% Save Accuracy and Saccades
Result = struct('Accuracy',Accuracy,'numb_sacc_lev_LOW',numb_sacc_lev_LOW,'numb_sacc_lev_HIGH',numb_sacc_lev_HIGH,'sent_eval',sent_eval,'numb_of_extra',numb_of_extra);
char = strcat('Result_','numRun',int2str(numb_run), '_lengWords',int2str(length_of_words));
root_result = strcat(root_dir, SEP, dictionary, SEP, 'Results' );
if ~isfolder(root_result)
                mkdir(root_result);
end
save([root_result SEP char],'Result_PROVA','-v7.3');
return