% function main_PLOTANDVIDEO
SEP         = filesep;
rootdir     = '~';
%% directory in which MDP_STEPS have been stored
test_name   = 'BERT_v1_S01';
dic_dir     = ['DICTIONARY' SEP 'BERT_DIC' SEP test_name SEP]; 

Mstepfiles  = dir([dic_dir 'MDP*']);
Mstepnames  = {Mstepfiles(:).name};
Dstepfiles  = dir([dic_dir '*.m']);
Dstepnames  = {Dstepfiles(:).name};
Nsteps      = length(Mstepnames);
MDP_STEPS   = cell(Nsteps,1);
DIC_STEPS   = cell(Nsteps,1);

addpath (dic_dir);
for step =1:Nsteps
    fs              =load(Mstepnames{step});
    MDP_STEPS{step} =fs.MDP;
    fn              =strsplit(Dstepnames{step},'.m');
    DIC_STEPS{step} =fn{1};
end
dic_fun = str2func(DIC_STEPS{1});
tmpDIC  = dic_fun();
sub_save_dir            = [rootdir SEP 'tmp' SEP 'SACCADES' SEP test_name SEP];
pltparams               = PLOT_defaultParams;
pltparams.hfig          = figure('visible','off');
pltparams.SAVE_MOVIE    = [sub_save_dir SEP 'MOVIE' SEP];

last_sentence           = HAI_retrieveLevel(MDP_STEPS{end}.sname{1}{MDP_STEPS{end}.s(1,end)});
GT2                     = [last_sentence '.'];
% DICTIONARY              = DICTIONARY_save('SacDic',dic_dir,[DICTIONARY_words(tmpDIC);DICTIONARY_getWords({GT})],{GT},0,1);

% pltparams.GT=DICTIONARY.Sentence{1};

% GT            = [HAI_retrieveLevel(MDP_STEPS{end}.sname{1}{MDP_STEPS{end}.s(1,end)}), ...
%                           ' THE MODEL PERFORMANCE WAS EVALUATED BY COMPARING ITS SIMULATED EYE MOVEMENTS WITH EMPIRICAL EYE MOVEMENT DATA FROM HUMAN PARTICIPANTS AS WELL AS BY CONDUCTING SIMULATIONS OF DYSLEXIA'];
% 
% 
% DICTIONARY = DICTIONARY_save('SacDic',dic_dir,[DICTIONARY_words(tmpDIC);DICTIONARY_getWords({GT})],{GT},0,1);
% pltparams.GT=DICTIONARY.Sentence{1};
pltparams.GT2=GT2;
rmpath(dic_dir);

if ~isfolder(sub_save_dir)
    mkdir(sub_save_dir)
end
if ~isfolder(pltparams.SAVE_MOVIE)
    mkdir(pltparams.SAVE_MOVIE)
end
% PLOT_Saccades_paragraph_original(MDP_STEPS,pltparams)
PLOT_Saccades_paragraph(MDP_STEPS,pltparams)


ext='pdf'; hfig=gcf;
nf  = sprintf('SACCADES.%s',ext);
fprintf('Saving %s ...\n',[sub_save_dir nf]);
exportgraphics(hfig,[sub_save_dir nf]);

inname              =[pltparams.SAVE_MOVIE SEP 'Saccades'];
outname             =[sub_save_dir SEP 'SacMovie'];
movparams           =paramsCreateMovie;
movparams.ifresize  =0;
movparams.extension ='jpg';
movparams.dirmode     =1;
movparams.FrameRate   =25;
movparams.repetitions =8;
createMovie(inname,outname,movparams);