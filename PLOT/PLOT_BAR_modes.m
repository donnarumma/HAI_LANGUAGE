function   PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,GT,save_dir)
% function PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,GT,save_dir)
% GT=HAI_retrieveLevel(GT);
if ~isfolder(save_dir)
    mkdir(save_dir);
end
texparams.wm=200; texparams.N_subfigures=1; texparams.file_type   ='pdf';

%% create BAR NOISE PLOT
NSubs = length(MDPsub);
hfig=PLOT_modes(MDPsub,noisedescription,rtmode);
ext = 'pdf';
p=[0,0,1500,800];
set(hfig, 'visible','off');
set(hfig, 'PaperPositionMode','auto');
set(hfig, 'Position',p);
nf  = sprintf('%s_%s.%s',dictionary,num2str(paramsmodes),ext);
fprintf('Saving %s ...\n',[save_dir nf]);
exportgraphics(hfig,[save_dir nf]);

for iSub=1:NSubs
    expID=fromNumToOrderedString(paramsmodes(iSub),100);
    sub_save_dir = sprintf('%s/ID%s/',save_dir,expID);
    if ~isfolder(sub_save_dir)
        mkdir(sub_save_dir);
    end
    %% bar plot sub
    hfig=PLOT_mode(MDPsub(iSub),noisedescription(iSub),rtmode,HAI_retrieveLevel(GT));
    p=[0,0,1500,800];
    set(hfig, 'visible','off');
    set(hfig, 'PaperPositionMode','auto');
    set(hfig, 'Position',p);
    nf  = sprintf('%s_SBAR_ID%s.%s',dictionary,expID,ext);
    fprintf('Saving %s ...\n',[sub_save_dir nf]);
    exportgraphics(hfig,[sub_save_dir nf]);
    close(hfig);
    %% saccades all 
    if MDPsub{iSub}.level>2 % temporary disabled for levels > 2
        hfig    = PLOT_Saccades(MDPsub{iSub},[],GT);
        nf  = sprintf('%s_SACCADES_ID%s.%s',dictionary,expID,ext);
        fprintf('Saving %s ...\n',[sub_save_dir nf]);
        exportgraphics(hfig,[sub_save_dir nf]);
        close(hfig);
        %% saccades steps
        hfig    = PLOT_SaccadesLines(MDPsub{iSub},[],GT);
        nf  = sprintf('%s_SUBSACCADES_ID%s.%s',dictionary,expID,ext);
        fprintf('Saving %s ...\n',[sub_save_dir nf]);
        exportgraphics(hfig,[sub_save_dir nf]);
        close(hfig);
    end
    %% latex compile
    [~,outnf]=latexCompile_ImageDirecory(sub_save_dir,save_dir,texparams);
    %% rename file
    fprintf('Compiled %s\n',[save_dir '/ID' expID '.pdf'])
    movefile(outnf,[save_dir '/ID' expID '.pdf']);
    todel=strsplit(outnf,'/');
    delete([save_dir '/' todel{end}]);
end

close all;