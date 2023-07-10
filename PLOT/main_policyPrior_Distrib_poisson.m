% function main_policyPrior_Distrib_poisson
%Poisson
X = 0:1000;

% lambda = 6;
params.LocPrLambda=10;
params.LocPrLambda=6;
% params.LocPrTh= 0.01;% lambda = 2;
params.location_priors=1;
lambda=params.LocPrLambda;
% lambda = 20;
% lambda = 10;
% lambda= 2;
% lambda= 1;
th          = 0;0.01;
Y           = poisspdf(X,lambda);
inds        = Y>th;
%% select maximum on next first (word) location
Y           = Y(inds);
X           = X(inds);
FY          = Y(Y>0.01);
[~,iM]      = min(abs(diff(FY)));
indM        = find(Y==FY(iM),1);
% [~,indM]=max(Y);
X           = X-X(indM);
Nlocations  =-(X(1)-1);
% Nlocations  = 7;
Nlocations  = 5;
% -(X(1)-1)
Ysuppressed=Y;
Ysuppressed(X==0)=0;
Ysuppressed=Ysuppressed./sum(Ysuppressed);
hfig=figure; hold on; box on; grid on;
bar(X,Ysuppressed,'facecolor','k');
bar(X,Y,0.4,'facecolor','r');
title(['lambda=' num2str(lambda) ' locations ' num2str(Nlocations)])
xticks(X);
ylim([0-th/10,max(Ysuppressed)+th])
xlim([-inf,2*Nlocations]);
XW=X;
YW=Ysuppressed;
YW=YW./sum(YW);
fprintf('lambda=%g,Points:%g, sum:%g\n',lambda,sum(inds),sum(Y))
issave=true;
if issave
    ylabel('p(\pi)')
    xlabel('locations');
    title('E distribution');
    
    optionsPlot(hfig);
    print(hfig,'-depsc2','~/TESTS/HAI_LANGUAGE_TESTS/E_PRIORS.eps');
    convertEPS2PDF({'~/TESTS/HAI_LANGUAGE_TESTS/'});
    export_fig(hfig,'~/TESTS/HAI_LANGUAGE_TESTS/E_PRIORS.pdf');
end
% Nlocations=4;
location = 0;
figure; hold on; box on; grid on;
bar(XW,YW,'facecolor','k');
% bar(XW(onloc)+location,YW(onloc),'facecolor','k');
title(['location ' num2str(location)]);
xticks(XW+location);
ylim([0-th/10,max(YW)+th])
xlim([-inf,2*Nlocations]);

for location=1:Nlocations

    EP=HAI_getLocationPriors(location,Nlocations,params);
%     EP=HAI_getLocationPriors_OLD(location,Nlocations,params);
    figure; hold on; box on; grid on;
    bar(1:Nlocations,EP,'facecolor','k');
    title(['location ' num2str(location)]);
    xticks(1:Nlocations);
    xlim([1-0.5,Nlocations+0.5]);
    ylim([0-1/1000,max(EP)+1/100]);
end
return

location = 4;
figure; hold on; box on; grid on;
bar(X(inds)+location,Ysuppressed(inds),'facecolor','k');
% bar(XW(onloc)+location,YW(onloc),'facecolor','k');
title(['location ' num2str(location)]);
xticks(XW+location);
ylim([0-th/10,max(YW)+th])
