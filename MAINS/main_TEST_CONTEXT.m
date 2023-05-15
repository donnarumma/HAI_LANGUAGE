% function main_TEST_CONTEXT
rng(0);
DIC         =DICTIONARY_v5();
N_TRIALS    =100;
ID_sequence =[];
while length(ID_sequence)<N_TRIALS
    ID_sequence=[ID_sequence,randperm(length(DIC.Sentence))];
end
irngs        = randi(1000,N_TRIALS,1);
DICTIONARIES = {'DICTIONARY_v5','DICTIONARY_v6'};
ID_sequence  =ID_sequence(1:N_TRIALS);
for i_trial=1:N_TRIALS
    idsentence=ID_sequence(i_trial);
    for i_dic=1:length(DICTIONARIES)
        dictionary  = DICTIONARIES{i_dic};
        irng        = irngs(i_dic);
        HAI_LANGUAGE_DICTIONARY_run(dictionary,idsentence,irng);
    end
end