function   hfig = SubPlot_LANGUAGE_Saccades_Frosolone(MDP,noisedescription,GT)
% function hfig = SubPlot_LANGUAGE_Saccades(MDP,noisedescription,GT)
if nargout>0
    hfig=figure('visible',0);
else
    hfig=gcf;
end
NF=length(MDP.mdp);
if nargin > 1
    ALL=15;
else 
    ALL=NF;
end
for ip = 1:NF
    subplot(ALL,1,ip)
    Plot_LANGUAGE_Saccades_Frosolone(MDP,ip,[]);
    set(hfig,'visible',0);
    axis on;
    cax=gca;
    cax.XAxis.Visible=0;
    cax.YAxis.Visible=0;
    set(cax,'color',0.941*[1 1 1])
end
p=[0,0,1500,80*NF]; set(hfig, 'Position',p)
if nargin > 1
    subplot(ALL,1,(NF+1):ALL)
    set(hfig,'visible',0);
    plotSUB_MAX({MDP},noisedescription(iSub),rtmode,GT);
    dx=0.59;xlim([0+dx,NF+1-0.5])
    legend('location','best')
end
exportgraphics(hfig,'~/tmp/DYSLEXIA/PROVA.png');
if nargout == 0
    set(hfig,'visible','on');
end