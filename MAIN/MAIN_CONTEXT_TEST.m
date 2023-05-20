% function MAIN_CONTEXT_TEST
rng(0);
DIC         =DICTIONARY_v5();
N_TRIALS    =100;
ID_sequence =[];
% can be substituted by a 
% ID_sequence=randi(length(DIC.Sentence),1,N_TRIALS); 
% however this allows that the difference for the number of times a 
% sentence is selected is at most one

while length(ID_sequence)<N_TRIALS 
    ID_sequence=[ID_sequence,randperm(length(DIC.Sentence))]; 
end
irngs        = randi(1000,N_TRIALS,1);
%                    NO CONTEXT      CONTEXT
% DICTIONARIES = {'DICTIONARY_v5','DICTIONARY_v6'};     % 2 Levels
DICTIONARIES   = {'DICTIONARY_v7','DICTIONARY_v8'};     % 3 Levels

ID_sequence  =ID_sequence(1:N_TRIALS);
for i_trial=1:N_TRIALS
    irng        = irngs(i_trial);
    idsentence  = ID_sequence(i_trial);
    for i_dic=1:length(DICTIONARIES)
        dictionary  = DICTIONARIES{i_dic};
        fprintf('Trial:%g/%g | SentenceID: %g | Dic: %s\n',i_trial,N_TRIALS,idsentence,dictionary)
        RUN_HAI_COMPARE_CONTEXT(dictionary,idsentence,irng);
    end
end