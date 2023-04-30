% function main_PLOTANDVIDEO
SEP         = filesep;
rootdir     = '~';
%% directory in which MDP_STEPS are saved
test_name='BERT_v1_S01';
% test_name='BERT_v1_S02';
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
rmpath(dic_dir);
sub_save_dir            = [rootdir SEP 'tmp' SEP 'SACCADES' SEP test_name SEP];

SEP = filesep;
pltparams               = PLOT_defaultParams;
pltparams.hfig          = figure('visible','off');
pltparams.NUMBW_LINE    = 7;
pltparams.SAVE_MOVIE    = [sub_save_dir SEP 'MOVIE' SEP];
pltparams.INT_LINE      = 0.2;%0.2;

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