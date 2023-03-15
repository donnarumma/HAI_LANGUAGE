function   hfig=PLOT_mode(MDPsub,noisedescription,rtmode,GT)
% function hfig=PLOT_mode(MDPsub,noisedescription,rtmode,GT)

%% create BAR NOISE PLOT
Nsubs=length(MDPsub);
lensT=nan(Nsubs,1);
for iM=1:Nsubs
    lensT(iM)=length(MDPsub{iM}.rt);
end

% Nwords=size(MDPsub{end}.rt,2);
Nwords=max(lensT);
X=nan(Nsubs,Nwords);
for iM = 1:Nsubs
%     lensT=length(MDPsub{iM}.rt);
    if rtmode
        X(iM,1:lensT(iM))=MDPsub{iM}.rt; yl='rt [s]';
    else
        X(iM,1:lensT(iM))=[MDPsub{iM}.mdp(:).T];yl='recognition steps';
    end
end
MDP         =MDPsub{1};
sentences   =MDP.sname{1};
L2s         =MDP.s;
Ses         =L2s(1,:);
WLs         =L2s(2,:);
[~,idms]=max(MDP.X{1}(:,end));
sentence    =sentences{idms};
sentencestr =HAI_retrieveLevel(sentence);
% sentencestr =sentencestr(1:end-1);

% for is=1:length(Ses)
%     pb(is)=MDP.X{1}(idms,is);
% end
pb          =MDP.X{1}(idms,:);    
cmaps       =linspecer(Nwords);

if nargout > 0
    hfig        =figure('visible','off');
else 
    hfig        = gcf;
end
hold on; box on; grid on;
try
    yl=[yl  ' (input=' GT ')' ];
catch
end
ylabel(yl);
%% PLOT SACCADES BAR
if size(X,1)==1
    for iw=1:Nwords
        hb(iw)=bar(iw,X(iw),'FaceColor',cmaps(iw,:));
    end
    xticks(1:Nwords);
    xticklabels(num2str(WLs'));
else
    hb=bar(X);
    for iw=1:Nwords
        hb(iw).FaceColor=cmaps(iw,:);
    end
    xticks(1:Nsubs);
end
xpos=0.5;
if Nsubs==1
%     xlabel(['Sub' num2str(1) ': ' noisedescription{1}]);
    xlabel(noisedescription{1});
%     xticks([]);
else
    xlabel('subject');
    for it=1:Nsubs
        text(xpos,ypos+it,['Sub' num2str(it) ': ' noisedescription{it}]);
    end
end
% ylim([0,max(max(X(:)),ypos+Nsubs+1)]);
mws=max(max(X(:)));
ylim([0,mws+1]);
yticks(1:mws);
fs =16;
lstr=cell(1,Nwords);
% dxlen=[0.06,0,0.035,0.035];
dxlen=[0.08,0,0.035,0.035];
%% PLOT WORD PROBABILITIES
ewp=cell(1,Nwords);
for iw=1:Nwords
    word    = sentence{WLs(iw)};
    rword   = HAI_retrieveLevel(word);
    pbw=MDPsub{1}.mdp(iw).X{1}; %     word probability
    pbl=MDPsub{1}.mdp(iw).X{2}; % location probability
    [~,idx] = max(pbl);
    for ieq=1:length(MDP.oname{1})
        if strcmp(rword,HAI_retrieveLevel(MDP.oname{1}{ieq}))
            break
        end
    end
    [~,idxw]=max(pbw);
    Np = MDP.mdp(iw).T; % size(pbw,2)-1
    for iL=1:Np
%         wstr=nmb2String(pbw(ieq,iL));
        %%%%
        wstr=nmb2String(pbw(idxw(Np),iL));
        %%%%
        wpstr=[num2str(idx(iL)) '. (' wstr ')'];
        dx=0.19;
        text(iw-dx,iL-0.5,wpstr,'FontSize',fs);
    end
%     ewp{iw}=nmb2String(pbw(ieq,Np));
    %%%%
    ewp{iw}=nmb2String(pbw(idxw(Np),Np));
    %%%%
end
%% PLOT SENTENCE PROBABILITIES
for iw=1:Nwords
    pbw     = MDPsub{1}.mdp(iw).X{1}; %    word probability
    [~,idxw]= max(pbw(:,end));
    Np      = MDP.mdp(iw).T; 
    word    = MDP.mdp(iw).sname{1}{idxw};
    %%%%
    lstr{iw}= sprintf('%g. p(%s)=%s',iw,HAI_retrieveLevel(word),ewp{iw});
    pstr    = nmb2String(pb(iw));
    Lenpstr = length(pstr);
    dx      = dxlen(Lenpstr)*Lenpstr;
    text(iw-dx,mws+0.5,['(' pstr ')'],'FontSize',fs);
end

%% title
pbstr       = nmb2String(pb(end));
titlestr    =sprintf('p(%s)=%s',sentencestr,pbstr);
title(titlestr);

%% legend
legend(lstr,'location','bestoutside')

%% plot dimension
set(gca,'Fontsize',fs)
set(gca, 'layer', 'top');
set(gca, 'xgrid', 'off');
p=[0,0,1500,600];
set(hfig, 'PaperPositionMode','auto');
set(hfig,'Position',p);
if nargout == 0
    hfig        =figure('visible','on');
end

end
%% ---------------------------------------------------- %%
function   pstr = nmb2String(nmb)
% function pstr = nmb2String(nmb)
    pstr=sprintf('%.2f',nmb);
    el   = pstr(end);
    while strcmp(el,'0')
        pstr   =pstr(1:end-1);
        el      =pstr(end);
    end
    if strcmp(pstr(end),'.')
        pstr=pstr(1:end-1);
    end
end