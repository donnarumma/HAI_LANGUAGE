function MAIN_HAI_BERT_LOOP_s05 (Trials,save_dir)
% watch
% MAIN WITH BERT WITH A SENTENCE THAT HAS A NEW WORD (BUTTER) IN IT
% the model does not recognize the word, but recognize the syllables of the
% word. Thus, it adds the new word to the dictionary
% clear all;
clc
fnew                = load('DICTIONARY/word_new');
fnew.words_new{74}  = 'OPTION';
fnew.words_new{3}   = 'BUTTER';
fnew.words_new{67}  = 'OFFBEAT';
words_new           = sort(fnew.words_new);
rng(20);
idx                 = randi(10^3,100,1);
idx(1)              = 589;
idx(2)              = 312;
idx(3)              = 32;
idx(12)             = 344;
SEP                  =filesep;

HWs                 = 4*ones(length(words_new),1);
HWs(2:3)            = 4;
fprintf('HW:%g\n',4);
% Trials              = 1:100;
try
    save_dir;
catch
    save_dir = [HAI_testsRoot() SEP 'DICTIONARY' SEP 'UNKNOWN' SEP];
end
if ~isfolder(save_dir)
    mkdir (save_dir);
end
%%
% Trials              = 1:3; % random test
for iTrial=Trials

    newword             = words_new{iTrial}; % eg. 'BUTTER';
    irng                = idx(iTrial);
    if 1
        pms.irng            = irng;
        pms.HW              = HWs(iTrial); %4 %10;
        pms.prefix          = 'THIS PAPER IS ALSO ';
        pms.suffix          = ' IN THE';
        pms.nwrandomize     = false;

        [MDP, unparams] = TEST_HAI_UNKNOWN(newword,pms);
    else
        rng(irng+1)
        fprintf('\nLoading Starting Dictionary...'); t=tic;
        MDP_s1              = load ('DICTIONARY/BERT_DIC/BERT_v1_S01/MDP_STEP001.mat');
        fprintf('done. Elapsed time %g s\n',toc(t));

        GuessedSentences    = MDP_s1.GuessedSentences;
        MDP                 = MDP_s1.MDP;
        langparams          = MDP_s1.langparams;

        syllables           = HAI_level(MDP.MDP.MDP,'');
        words               = HAI_level(MDP.MDP,'');
        sentences           = HAI_level(MDP,' ');

        % new sentence with a new unknown word (BUTTER) with known syllables (BUT and TER)
        prefix              = 'THIS PAPER IS ALSO ';
        suffix              = ' IN THE';
        % find syllables not in newword
        newwordsplitted     = DICTIONARY_hyphenate(newword);
        HW                  = 10;
        sylls               = cell(0,0);
        while length(sylls) < HW
            rs=randi(length(syllables)-1)+1; % exclude empty syllable
            if ~ismember(syllables{rs},newwordsplitted)
                sylls{end+1}=syllables{rs};
            end
        end
        % compose words with previous syllables
        morewords=cell(0,0);
        while length(morewords)<HW*length(newwordsplitted)
            for iw=1:HW
                for is=1:length(newwordsplitted)
                    moreword        = newwordsplitted;
                    moreword{is}    = sylls{iw};
                    moreword        = [moreword{:}];
                    if length(DICTIONARY_hyphenate(moreword))==length(newwordsplitted)
                        morewords{end+1,1}= moreword;
                    end
                end
            end
        end
        % add new words and new sentences
        words               = [newword; morewords; words];
        newsentence         = {prefix newword suffix};
        newsentence         = [newsentence{:}];
        for isentence=1:length(morewords)
            moresentence        = {prefix morewords{isentence} suffix};
            moresentence        = [moresentence{:}];
            sentences           = [moresentence; sentences];
        end
        sentences           = [newsentence; sentences];
        % save new dictionary in dic_name
        dohyphen            =1;
        deleteoldsentences  =1;
        dic_name            =['BERT_v1_' newword];

        dic_dir             = ['.' SEP 'BERT' SEP dic_name  SEP];
        mkdir(dic_dir);
        addpath(dic_dir);

        % https://it.mathworks.com/help/textanalytics/ref/editdistance.html
        fprintf('Saving %s in %s\n',dic_name,dic_dir);
        DICTIONARY_save(dic_name,dic_dir,words,sentences,deleteoldsentences,dohyphen);
        % dirfun              = str2func(dic_name);
        % actdir              = dirfun();
        % sentences           = DICTIONARY_sentences(actdir);
        % words               = DICTIONARY_words(actdir);

        % max saccades on letters    syllables     words
        % nmaxT          = [   8,          8,          8  ];
        nmaxT               = [   5,          6,          7  ];
        dictionary_function = str2func(dic_name);

        DICTIONARY          = dictionary_function();

        syllables           = cellfun(@(x)(HAI_retrieveLevel(x))   ,DICTIONARY.Syllable,'UniformOutput',false);
        words               = cellfun(@(x)(HAI_retrieveLevel(x,'')),DICTIONARY.Word, 'UniformOutput',false);
        sentences           = cellfun(@(x)(HAI_retrieveLevel(x))   ,DICTIONARY.Sentence,'UniformOutput',false);

        sends               = cellfun(@(x)(editDistance(x,newsentence)),sentences);
        [~,sen]             = min(sends);
        wors                = cellfun(@(x)(editDistance(x,newword)),words);
        [~,indnewword]      = min(wors);
        %%
        % params for the unknown
        % unparams            = HAI_getParams(23,dic_name);
        unparams                          = HAI_DefaultParams(dic_name);

        for il = 1:length(unparams.level); unparams.level(il).maxT=nmaxT(il);   end
        for il = 1:length(unparams.level); unparams.level(il).chi = 1/32;       end
        for il = 1:length(unparams.level); unparams.level(il).Ht=false;         end

        % indnewword                        = 97;
        unparams.level(2).idkContent      = indnewword;

        unparams                        = HAI_initialiseParams(unparams);
        % unparams.level(2).D{1}(indnewword)= 0;
        unparams.irng               = 344;
        unparams.irng               = irng;

        % set up sentence
        unparams.level(3).s(1,:)    = sen*ones(1,nmaxT(3));

        fprintf('Reading %s\n',HAI_retrieveLevel(unparams.level(3).STATES{sen},' '))

        unparams.debugmode          = true;
        MDPEXP                      = HAI_RUN(unparams,dic_name);
        %
        ind                     = MDPEXP.s(1,1);
        val                     = MDPEXP.X{1}(ind,end);
        fprintf('Real P(%s)=%g\n',HAI_retrieveLevel(MDPEXP.sname{1}{ind}),val);
        [valMax,indMax]         = max(MDPEXP.X{1}(:,end));
        fprintf('Max P(%s)=%g\n',HAI_retrieveLevel(MDPEXP.sname{1}{indMax}),valMax);
        fprintf('Number of saccades: %g\n',HAI_getSaccades(MDPEXP));
        mdp=MDPEXP.mdp;
        for im=1:length(mdp)
            loc=MDPEXP.s(2,im);
            [val,ind]=max(mdp(im).X{1}(:,end));
            add='';
            if mdp(im).T==nmaxT(2) || val<0.6
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
        try
            fprintf('New word: %s, in word location %g\n',HAI_retrieveLevel(recword,''),inloc);
        catch
            fprintf('All read smoothly\n');
        end
        MDP       =MDPEXP;
    end
    save_file = sprintf('%sMDP_unknown_%s.mat',save_dir,newword);
    fprintf('Saving %s\n',save_file);
    save(save_file,'MDP','unparams')
end


return
%%
save_dir = [HAI_testsRoot() SEP 'BERT_LOOP' SEP 'DICTIONARY' SEP 'BERT_DIC' SEP 'BERT_v1_PAPER' SEP 'IMAGES' SEP];
ison=false;
pltparams.hfig     =figure('visible',ison);
pltparams.factor   =1;     % plot first factor (CONTENT)
pltparams.nla      =0.05;  % neuron line alpha
pltparams.sa       =0.1;   % step alpha
pltparams.humanlike=true;  % rescale times for human saccades

h=PLOT_TimeProbLevel(MDPEXP,pltparams);
optionsPlot(h);
if addto
    nf='KNOWN_Probabilities';
else
    nf='UNKNOWN_Probabilities';
end
% print(h,[save_dir nf],'-depsc2')
export_fig([save_dir nf '.pdf']);
%%

return

DEADBEAT
HEARTBEAT
UPBEAT
OFFSHOOT
OFFHAND
OFFSET
OFFLOAD
OFFEND
OFFSITE
OFFSTAGE
OFFSHORE
OFFSPRING





"THIS PAPER IS ALSO FRAMED IN AN OFFBEAT MANNER"
