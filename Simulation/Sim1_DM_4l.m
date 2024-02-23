% main Simulation 1 word reading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clear MDPsub;
rtmode                             = 0;  % 1 reaction time, 0 recognition steps

irng                               = randi([1 10],1); %'default';
% imode                              = 0; OLD COMMAND TO RETURN TO FRISTON MODE

paramsmodes                        = 13;
numb_run                           = 100;
noise                              = 15;

NSubs = 1;
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedescription                   = cell(NSubs,1);
dictionary                         = 'BERT_100_SY';
     %% get params with the selected dictionary
    [par_series,noisedescription]      = HAI_getParams_bis(paramsmodes,dictionary);   
    par_series                         = HAI_initialiseParams(par_series);
    %% set seed
    par_series.irng                     = irng;
    maxT                                = par_series.level(end).maxT;       % initial      sentence state


%     pause;
%%-----SENTENCE SELECTION
idsentences = zeros(1,paramsmodes);
Accuracy = cell(numb_run,1);
numb_sacc_lev_LOW = cell(numb_run,1);
numb_sacc_lev_HIGH =  cell(numb_run,1);
numb_of_extra = cell(numb_run,1);
sent_eval = cell(numb_run,1);
    
length_of_words = 4;
load BERT_100_SY.mat
    
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
        MDP                             = HAI_smartMDP(MDPsub);
        fprintf('Ended computation for SubjectID%g\n',paramsmodes);
    
        SEP = '//';
        root_dir = ['.' SEP 'HAI_LANGUAGE_TESTS'];
        save_dir =[root_dir  SEP   dictionary SEP int2str(noise) SEP 'FOUR_LETT' SEP id_route SEP];
        %% save MDP in directory
        expID=fromNumToOrderedString(paramsmodes,100);
            sub_save_dir = strcat(sprintf('%s/ID%s/',save_dir,expID));
            if ~isfolder(sub_save_dir)
                mkdir(sub_save_dir);
        end
    
    save([sub_save_dir SEP strcat('MDPsub_',id_route)],'MDP','-v7.3');
end