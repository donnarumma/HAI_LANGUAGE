function   hfig=plotSUBS(MDPsub,noisedescription,rtmode)
% function hfig=plotSUBS(MDPsub,noisedescription,rtmode)

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

cmaps = linspecer(Nwords);
hfig=figure; hold on; box on; grid on;
ylabel(yl);
if size(X,1)==1
    for iw=1:Nwords
        hb(iw)=bar(iw,X(iw),'FaceColor',cmaps(iw,:));
    end
else
    hb=bar(X);
    for iw=1:Nwords
        hb(iw).FaceColor=cmaps(iw,:);
    end
end
xticks([1:Nsubs]);
lstr=cell(1,Nwords);
for iw=1:Nwords
    lstr{iw}=sprintf('L%g',iw);
end
xpos=0.5;
ypos=4.5;
ypos=2.5;
legend(lstr,'location','bestoutside')
    
if Nsubs==1
%     xlabel(['Sub' num2str(1) ': ' noisedescription{1}]);
    xlabel(noisedescription{1});
    xticks([]);
else
    xlabel('subject');
    for it=1:Nsubs
        text(xpos,ypos+it,['Sub' num2str(it) ': ' noisedescription{it}]);
    end
end
ylim([0,max(max(X(:)),ypos+Nsubs+1)]);