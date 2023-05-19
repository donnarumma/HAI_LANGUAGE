function main_TEST_CONTEXT
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
% DICTIONARIES = {'DICTIONARY_v5','DICTIONARY_v6'};
DICTIONARIES = {'DICTIONARY_v7','DICTIONARY_v8'};
% DICTIONARIES = {'DICTIONARY_v8'}; % DICTIONARIES = {'DICTIONARY_v6'};
ID_sequence  =ID_sequence(1:N_TRIALS);
for i_trial=1:N_TRIALS
    irng        = irngs(i_trial);
    idsentence  = ID_sequence(i_trial);
    for i_dic=1:length(DICTIONARIES)
        dictionary  = DICTIONARIES{i_dic};
        fprintf('Trial:%g/%g | SentenceID: %g | Dic: %s\n',i_trial,N_TRIALS,idsentence,dictionary)
        HAI_LANGUAGE_DICTIONARY_run(dictionary,idsentence,irng);
    end
end