function   hfig=PLOT_Saccades(MDP,NSUB,GT,hfigure)
% function hfig=PLOT_Saccades(MDP,NSUB,GT,ifshow)
% MDP is the Model organized in high and low (mdp) levels
% NSUB the low levels to plot (default all)
% GT Ground Truth state (default: initial state s of MDP)
% illustrates visual search graphically
%--------------------------------------------------------------------------
lw          = 2;                % linewidth of the saccadic lines
LDIM        = 2;                % space between two letters
map_yellow  = [0.8,0.8,0.2];    % color of the saccadic points
markertype   ='o';              % marker of the saccadic point
ms           = 5;               % marker size

STS=MDP.sname{1};
try
    phr=GT;
    phr{1};
catch
    s  =MDP.s(1,1);
    phr=STS{s};
end
WORDNUMBER  =length(phr);
% LETTERNUMBER=length(phr{1});
% % XMAX        = (LETTERNUMBER+1)*LDIM*WORDNUMBER-LDIM;
% 
rx      = [-1,1]/2;
ry      = [-1,1]/2;
% x       = zeros(LETTERNUMBER+1,2);
% x(:,1)  = ((0:1:LETTERNUMBER)').*LDIM;
% y       = zeros(WORDNUMBER,2);
% % y(:,1)  = 1:((LETTERNUMBER+1)*LDIM):(LETTERNUMBER*LDIM*WORDNUMBER);
% 
% % compute length of each word with a space in between
% lenWs    = zeros(WORDNUMBER,1);  % store length of each word
% for iw=1:WORDNUMBER
%     lenWs(iw)=length(HAI_retrieveLevel(phr{iw}));
% end
% lenWSpace=lenWs+1;                 % add one space between each word
% % compute location of each word
% wordLoc   = zeros (WORDNUMBER,1);  % 
% wordLoc(1)=1; 
% for il=1:length(lenWSpace)-1 
%     wordLoc(il+1)=(lenWSpace(il))*LDIM+wordLoc(il); 
% end
% y(:,1)   = wordLoc;
% % XMAX     = (sum(lenWSpace)+1)*LDIM;
% XMAX     = sum(lenWSpace)*LDIM;

[x,y,XMAX]=PLOT_computeCOORDS(phr,LDIM);

% plot the cues
%--------------------------------------------------------------------------

if nargout > 0
    hfig=figure('visible','off'); 
else
    try
        hfig=hfigure;
    catch
        hfig=gcf;
    end
end
hold on; legend off; axis ij; 
cax=gca;
cax.XAxis.Visible=0;
cax.YAxis.Visible=0;
set(cax,'color',0.95*[1 1 1])

axis([0-rx(1), XMAX+rx(2), ry(1), ry(2)])
X     = [];
for iWW = 1:WORDNUMBER
    a = HAI_retrieveLevel(phr{iWW},'');
    for iLL = 1:numel(a)
        image(rx + y(iWW,1) + x(iLL,1),ry + y(iWW,2) + x(iLL,2),  PLOT_createCharacterImage(a(iLL)));% hold on
    end
end  % Extract eye movements
        
%----------------------------------------------------------------------
try
    NSUB(1);
catch
    NSUB=1:length(MDP.mdp);
end
cmaps=linspecer(length(MDP.mdp));
cmap_label=[];
if NSUB(1)>1
    X(end + 1,:) = y(MDP.o(2,NSUB(1)-1),:) + x(MDP.mdp(NSUB(1)-1).o(2,end),:);
    cmap_label(end+1)=NSUB(1)-1;
end
for iNs = NSUB
    for is = 1:numel(MDP.mdp(iNs).o(2,:))
        X(end + 1,:) = y(MDP.o(2,iNs),:) + x(MDP.mdp(iNs).o(2,is),:);
        cmap_label(end+1)=iNs;
    end
end
 
DARC=ry(2)/4;
% Smooth and plot eye movements
%--------------------------------------------------------------------------

% for pl = 1:length(X)-1
for pl = 1:size(X,1)-1
    x1 = X(pl,:);
    x3 = X(pl+1,:);
    ns = randn*0.1; % noise
    if mod(pl,2)==0
        x2 = [mean([x1(1),x3(1)]), +DARC + ns];
    else
        x2 = [mean([x1(1),x3(1)]), -DARC + ns];
    end
    x_pl = [x1;x2;x3];
    f = fit(x_pl(:,1),x_pl(:,2),'poly2');
    hp = plot(f,[x1(1) x3(1)],[x1(2) x3(2)]);
    set(hp,'color',cmaps(cmap_label(pl),:));
    set(hp,'linewidth',lw);
%     if mod(pl,2)==0
%         set(hp, 'color','r')
%     else
%         set(hp, 'color','b')
%     end
    legend off
end
plot(X(:,1),X(:,2),'marker',markertype,'linestyle','none','color',map_yellow,'MarkerSize',ms,'MarkerEdgeColor','k','MarkerFaceColor',map_yellow)

p=[0,0,XMAX*30,80]; set(hfig, 'Position',p);

if nargout==0 && nargin<4
    set(hfig,'visible','on');
end