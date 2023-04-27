%% MAIN WITH BERT WITH A SENTENCE THAT HAS A NEW WORD (BUTTER) IN IT
clear all;
SEP                 =filesep;
% DICTIONARY          =BERT_v1_001();
MDP_s1              =load ('DICTIONARY/BERT_DIC/BERT_v1_S01/MDP_STEP001.mat');
GuessedSentences    =MDP_s1.GuessedSentences;
MDP                 =MDP_s1.MDP;
langparams          =MDP_s1.langparams;
% words               =DICTIONARY_words(DICTIONARY);
% syllables           =HAI_level(MDP.MDP.MDP,'');
words               =HAI_level(MDP.MDP,'');
sentences           =HAI_level(MDP,' ');

dohyphen            =1;
deleteoldsentences  =1;
dic_name            ='BERT_v1_tmp';

dic_dir             = ['.' SEP 'BERT' SEP dic_name  SEP];
mkdir(dic_dir);
addpath(dic_dir);

% new sentence with a new unknown word (BUTTER) with known syllables (BUT and TER) 
newsentence = {'THIS PAPER IS ALSO BUTTER IN THE'}; 
% sentences   = [newsentence;sentences];
% https://it.mathworks.com/help/textanalytics/ref/editdistance.html
sends = cellfun(@(x)(editDistance(x,newsentence{1})),sentences);
[~,sen] = min(sends);
fprintf('Saving %s in %s\n',dic_name,dic_dir);
words=['BITTER';words];
DICTIONARY_save(dic_name,dic_dir,words,sentences,deleteoldsentences,dohyphen);


% max saccades on letters    syllables     words
nmaxT          = [   8,          8,          8  ];
nmaxT          = [   5,          6,          7  ];
dictionary_function = str2func(dic_name);

DICTIONARY          =dictionary_function();

syllables           =cellfun(@(x)(HAI_retrieveLevel(x)),DICTIONARY.Syllable,'UniformOutput',false);
words               =cellfun(@(x)(HAI_retrieveLevel(x)),DICTIONARY.Word,    'UniformOutput',false);
sentences           =cellfun(@(x)(HAI_retrieveLevel(x)),DICTIONARY.Sentence,'UniformOutput',false);


%% NEW WORD
newword             = 'BUTTER';
newwordsplitted     = DICTIONARY_hyphenate(newword);
hmsyllables         = length(newwordsplitted);
names               = nan(1,hmsyllables);
for isy=1:hmsyllables
    names(isy)      = find(strcmp(syllables,newwordsplitted{isy}));
end

%% NEW PARAMS
unparams            = HAI_getParams(23,dic_name);
for il = 1:length(unparams.level); unparams.level(il).maxT=nmaxT(il); end
unparams            = HAI_initialiseParams(unparams);

syllables_location_states       = randi(length(names),1,nmaxT(2)); 
while (syllables_location_states(1)~=1)
    syllables_location_states=circshift(syllables_location_states,1);
end
% set corresponding saccades on the second level location states
wolocs  = MDP.s(2,1):length(MDP.sname{2});
seq     = [];
while length(seq)<nmaxT(3)
    seq = [seq,wolocs(randperm(length(wolocs)))];
end
%     1    2   3   4     5    6   7
%  'THIS PAPER IS ALSO BUTTER IN THE'
seq=[3     5     4     6     4     6     7     5];
seq                         =seq(1:nmaxT(3));
% set true states syllables first level states 

% level 1
% states x nmaxT(1), nmaxT(2), nmaxT(3)
for iT2=1:nmaxT(2)
    for iT3=find(seq==5)%1:nmaxT(2)
        unparams.level(1).s(1,:,iT2,iT3)=ones(1,nmaxT(1))*names(syllables_location_states(iT2));
    end
end
% level 2
% states x nmaxT(2), nmaxT(3)
% when word is 'BUTTER', set up locations
for iT3=find(seq==5)
    unparams.level(2).s(2,:,iT3)=syllables_location_states;
end
% level 3
% states x nmaxT(3)
% set up word locations
unparams.level(3).s(2,:)    = seq;

% set up sentence
unparams.level(3).s(1,:)    = sen*ones(1,nmaxT(3));

MDPEXP                      = HAI_RUN(unparams,dic_name);

[val,ind]=max(MDPEXP.X{1}(:,end));
fprintf('P(%s)=%g\n',HAI_retrieveLevel(MDPEXP.sname{1}{ind}),val);

mdp=MDPEXP.mdp;
for im=1:length(mdp)
    loc=MDPEXP.s(2,im);
    [val,ind]=max(mdp(im).X{1}(:,end));
    add='';
    if mdp(im).T==nmaxT(2)
        add='I am not sure! Probably a new word';
        inloc=loc;
    end
    fprintf('WL(%g):P(%s)=%g | %s\n',loc,HAI_retrieveLevel(MDPEXP.mdp(im).sname{1}{ind},''),val,add);
    mdpmdp=mdp(im).mdp;
    for imm=1:length(mdpmdp)
        [val,ind]=max(mdpmdp(imm).X{1}(:,end));
        sloc=mdp(im).s(2,imm);
        recword{sloc}=MDPEXP.mdp(im).mdp(imm).sname{1}{ind};
        fprintf('SL(%g):P(%s)=%g\n',sloc,HAI_retrieveLevel(MDPEXP.mdp(im).mdp(imm).sname{1}{ind},''),val);   
    end
end
fprintf('New word: %s, in word location %g\n',HAI_retrieveLevel(recword,''),inloc)



return


    






