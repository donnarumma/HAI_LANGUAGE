function   hfig=PLOT_TimeProbLevel(MDP,params)
% function hfig=PLOT_TimeProbLevel(MDP,params)

if ~exist('params','var') || isempty(params.hfig) || ~isvalid(params.hfig)
    hfig=figure;
else
    hfig=params.hfig;
end
if nargout>0
    h=hfig;
end
probLevel=HAI_getTimeProb(MDP);
% dt=eps;%0.1;
% dt=0.001;
dt=eps*10;

% fs      =(1000/3 + 1000/4)/2;   % mean frequency of human saccades in ms
% fs      =(1/3 + 1/4)/2;         % mean frequency of human saccades in s
fs      = params.fs;
if ~params.Steps || params.RTstretch
    indp=2;
    % hai_neu = HAI_getNeuralStatistics(MDP,params);
else
    indp=4;
end
if indp==4
    dt=-dt;
end
maxTime =probLevel{end}(end,indp);
nSacc   =size(probLevel{1},1);
if params.humanlike
    h=(nSacc*fs)/maxTime;
else
    h=1;
end
for il=1:length(probLevel)
    probLevel{il}(:,indp)=probLevel{il}(:,indp)*h;
end
% dt=dt/msconv;

hold on
cmaps=lines(MDP.level);

Nlevels=length(probLevel);
ALLT=[];
for lev=1:Nlevels
    ALLT=[ALLT; probLevel{lev}(:,indp)];
end
LIMT=[min(ALLT),max(ALLT)];
MDP_I=MDP;
t0=0;
for lev=Nlevels:-1:1
    subplot(Nlevels,1,Nlevels-lev+1);
    hold on; box on; grid on;
    Y=probLevel{lev}(:,1);
    T=probLevel{lev}(:,indp)+t0;
    if lev<Nlevels
        t_reset=probLevel{lev+1}(:,indp);
        p_reset=zeros(size(t_reset));
        xline([t0;t_reset],'color',cmaps(lev+1,:),'LineWidth',3);
        if indp~=4
            T=[t_reset-dt;t_reset;t_resetend-dt;t_resetend;T];
            Y=[p_reset*nan;p_reset;p_resetend*nan;p_resetend;Y];
            [T,sortind]=unique(T);
            Y=Y(sortind);
        else
            T=[t_reset-dt;t_resetend-dt;T];
            Y=[p_reset*0;p_resetend*0;Y];
            [T,sortind]=unique(T);
            Y=Y(sortind);
        end
    else
        t_resetend=probLevel{end}(:,indp);
        p_resetend=zeros(size(t_resetend));
    end
    if lev>0
        T=[t0;T];
        Y=[t0;Y];
    end
    h(lev)=plot(T,Y,'o:','linewidth',3,'color',cmaps(lev,:),'markersize',8);%legend({'Level 1','Level 2','Level 3'});
    % legend(h(lev),MDP_I.Aname{1},'autoupdate','off','location','northwest');
    legend(h(lev),MDP_I.Aname{1},'autoupdate','off','location','southeast');
    try
        MDP_I=MDP_I.MDP;
    catch
    end

    if lev==1
        xlabel('time [s]')
    end
    ylabel(sprintf('p(C^{%g}|O)',lev));
    % xlim([LIMT(1)-dt,LIMT(2)+dt]); 
    xlim([t0-dt,LIMT(2)+dt]); 
    ylim([0-0.01;1+0.01]);
    set(gca,'fontsize',16);
end