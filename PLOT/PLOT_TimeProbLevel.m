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
if ~exist('params','var') || ~isfield(params,'humanlike')
    params.humanlike=true;
end
probLevel=HAI_getTimeProb(MDP);
dt=0.1;
if params.humanlike
    fs      =(1000/3 + 1000/4)/2;   % mean frequency of human saccades in ms
    maxTime =probLevel{end}(end,end)*1000;
    nSacc   =size(probLevel{1},1);
    h=(nSacc*fs)/maxTime;
    for il=1:length(probLevel)
        probLevel{il}(:,2)=probLevel{il}(:,2)*h;
    end
    dt=dt/1000;
end
hold on
cmaps=lines(MDP.level);

Nlevels=length(probLevel);
ALLT=[];
for lev=1:Nlevels
    ALLT=[ALLT; probLevel{lev}(:,2)];
end
LIMT=[min(ALLT),max(ALLT)];
MDP_I=MDP;
t0=0;
for lev=Nlevels:-1:1
    subplot(Nlevels,1,Nlevels-lev+1);
    hold on; box on; grid on;
    Y=probLevel{lev}(:,1);
    T=probLevel{lev}(:,2)+t0;
    if lev<Nlevels
        t_reset=probLevel{lev+1}(:,2);
        p_reset=zeros(size(t_reset));
        xline([t0;t_reset],'color',cmaps(lev+1,:),'LineWidth',3);
        
        T=[t_reset-dt;t_reset;t_resetend-dt;t_resetend;T];
        Y=[p_reset*nan;p_reset;p_resetend*nan;p_resetend;Y];
        [T,sortind]=unique(T);
        Y=Y(sortind);
    else
        t_resetend=probLevel{end}(:,2);
        p_resetend=zeros(size(t_resetend));
    end
    if lev>1
        T=[t0;T];
        Y=[t0;Y];
    end
    h(lev)=plot(T,Y,'o:','linewidth',3,'color',cmaps(lev,:),'markersize',8);%legend({'Level 1','Level 2','Level 3'});
    legend(h(lev),MDP_I.Aname{1},'autoupdate','off','location','northwest');
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