function   h3=putsFigsOn(dir_figs,params)
% function h3=putsFigsOn(dir_figs)
% dir_figs={'/home/donnarumma/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA/L2_Raster_t1.fig'; ...
%           '/home/donnarumma/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA/L2_Raster_t3.fig'; ...
%           '/home/donnarumma/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA/L2_Raster_t2.fig'; ...
%           '/home/donnarumma/TESTS/HAI_LANGUAGE_TESTS/IMAGES/CONTRA/L2_Raster_t4.fig';};
 
LEN_FIG=length(dir_figs);
for iFig=1:LEN_FIG
    h(iFig) = openfig(dir_figs{iFig},'reuse');  % open figure
    ax(iFig) = gca;                             % get handle to axes of figure
end
xlab=ax(1).XLabel.String;
ylab=ax(1).YLabel.String;
tlab=ax(1).Title.String;
if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    h3=figure;
else
    h3=params.hfig;
end
hold on;
for iFig=1:LEN_FIG
    s = subplot(1,LEN_FIG,iFig); %create and get handle to the subplot axes
    fig = get(ax(iFig),'children'); %get handle to all the children in the figure
    pos=get(s,'Position');
    xl  = get(ax(iFig),'Xlim');
    yl  = get(ax(iFig),'Ylim');
    copyobj(fig,s); %copy children to new parent axes i.e. the subplot axes
    colormap gray;
    set(s,'Position',pos);
    % fs=16;
    % set(gca,'fontsize',fs);
    l1=findobj(h(iFig),'Type','Legend');
    if ~isempty(l1)
        legend(l1.String,'location','south');
        % legend(l1.String);
    end
    xlim(xl);
    ylim(yl);
    if iFig>1 && ~(isempty(params.ylim))
        set(s,'YTick',[]);
    end
    if ~isempty(params.ylim)
        ylim(params.ylim);
    end
    box on; grid on;
    set(gca,'fontsize',16);
end

han=axes(h3,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,xlab);
ylabel(han,ylab);
title (han,tlab);
return
% s1 = subplot(2,1,1); %create and get handle to the subplot axes
% s2 = subplot(2,1,2);
% fig1 = get(ax1,'children'); %get handle to all the children in the figure
% fig2 = get(ax2,'children');
% copyobj(fig1,s1); %copy children to new parent axes i.e. the subplot axes
% copyobj(fig2,s2);