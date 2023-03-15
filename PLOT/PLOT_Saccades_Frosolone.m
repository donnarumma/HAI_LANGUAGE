function   hfig=PLOT_Saccades_Frosolone(MDP,NSUB,GT,hfigure)
% function hfig=Plot_LANGUAGE_Saccades(MDP,NSUB,GT,ifshow)
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

% Define the number of word for each line and the interline lenght

NUMBW_LINE = 11;                % number of word for line
INT_LINE = 0.4;                    % interline lenght


n_max_line = 5;					% This is the max number of line. If want to increase the number of lines, create a new elseif code.
STS=MDP.sname{1};
try
    phr=GT;
    phr{1};
catch
    s  =MDP.s(1,1);
    phr=STS{s};
end

%count number of letter e word for each sentence
WORDNUMBER  = length(phr);
LETTERNUMBER=length(phr{1});
if WORDNUMBER/NUMBW_LINE > n_max_line
    disp('reduce number of words for line')
end

%Count nunmber or line
if WORDNUMBER == NUMBW_LINE
    R_WORD = NUMBW_LINE-WORDNUMBER;
    N_LINE = 1;
    LINE_VEC = NUMBW_LINE;
    iw_end(1) = NUMBW_LINE;

elseif WORDNUMBER == 2*NUMBW_LINE
    N_LINE = 2;
    LINE_VEC = [NUMBW_LINE,2*NUMBW_LINE];
    iw_end(1) = [NUMBW_LINE,2*NUMBW_LINE];

elseif WORDNUMBER == 3*NUMBW_LINE
    N_LINE = 3;
    LINE_VEC = [NUMBW_LINE,3*NUMBW_LINE];
    iw_end(1) = [NUMBW_LINE,3*NUMBW_LINE];

elseif WORDNUMBER == 4*NUMBW_LINE
    N_LINE = 4; 
    LINE_VEC = [NUMBW_LINE,4*NUMBW_LINE];
    iw_end(1) = [NUMBW_LINE,4*NUMBW_LINE];   
    
elseif WORDNUMBER == 5*NUMBW_LINE
    N_LINE = 5;
    LINE_VEC = [NUMBW_LINE,5*NUMBW_LINE];
    iw_end(1) = [NUMBW_LINE,5*NUMBW_LINE];
        
else
    Q_LINE = floor(WORDNUMBER/NUMBW_LINE);
    R_WORD = WORDNUMBER-(NUMBW_LINE*Q_LINE);
    if Q_LINE == 0
        N_LINE = 1;
        for i = 1:N_LINE
            LINE_VEC(i) = R_WORD;
            iw_end(i) = R_WORD;
        end
    else
        N_LINE = Q_LINE+1;
        for i = 1:N_LINE-1
        LINE_VEC(i) = NUMBW_LINE;
        iw_end(i) = NUMBW_LINE*i;
        end
        LINE_VEC(i+1) = WORDNUMBER-NUMBW_LINE*Q_LINE;
        iw_end(i+1) = WORDNUMBER;
    end
end
%-------------------------------------------------------------------------
   %create the plot framework
    rx      = [-1,1]/2;
    ry      = [-1,1]/2;
    x       = zeros(LETTERNUMBER+1,2);
    x(:,1)  = ((0:1:LETTERNUMBER)').*LDIM;

% Creation of x_max and y_max limits
    m = 0;
    for lin = 1:N_LINE
        lenWs = zeros(LINE_VEC(lin),1);
        len_ws = 1;
        for iw = 1+NUMBW_LINE*m:iw_end(lin)
            lenWs(len_ws)=length(HAI_retrieveLevel(phr{iw}));
            len_ws = len_ws + 1;
        end
        lenWSpace{1,lin}=lenWs+1;
        m = m + 1;
    end
    XMAX = zeros(length(lenWSpace),1);
    for i = 1:length(lenWSpace)
        XMAX(i) = (sum(lenWSpace{i}))*LDIM;
    end
    XMAX_T = max(XMAX);
    for i = 1:length(LINE_VEC)
        y{i} = zeros(LINE_VEC(i),2);
        wordLoc{i} = zeros(LINE_VEC(i),1);
    end
    for w = 1:length(wordLoc)
        wordLoc{1,w}(1,1) = 1;
    end

    % spaces insert
    for lws = 1:length(lenWSpace)
        for il=1:length(lenWSpace{lws})-1 
            wordLoc{lws}(il+1)=(lenWSpace{lws}(il))*LDIM+wordLoc{lws}(il); 
        end
        y{lws}(:,1) = wordLoc{lws};
    end
    

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

    ry_max = -0.1 - INT_LINE;
    for i = 1:length(LINE_VEC)
        ry_max = ry_max - 0.2*2 + INT_LINE + 1;
    end

    axis([0-rx(1), XMAX_T+rx(2), ry(1), ry_max])

    % p Line letter evaluation 
    m = 0;
    line_center = [ry; zeros(length(LINE_VEC),2)];
    for p = 1: length(LINE_VEC)
        for iWW = 1:LINE_VEC(p)
            a = HAI_retrieveLevel(phr{iWW+NUMBW_LINE*m});
            for iLL = 1:numel(a)
                image(rx + y{1,p}(iWW,1) + x(iLL,1),ry + y{1,p}(iWW,2) + x(iLL,2),  PLOT_createCharacterImage(a(iLL)));% hold on
            end
        end
        m = m+1;
        ry = ry + (1 - 0.2*2 + INT_LINE);
        line_center(p+1,:) = ry;
    end
    
    X     = [];
    % Extract eye movements
    try
        NSUB(1);
    catch
        NSUB=1:length(MDP.mdp);
    end

    cmaps=linspecer(length(MDP.mdp));
    cmap_label=[];


    for iNs = NSUB
         for is = 1:numel(MDP.mdp(iNs).o(2,:))
             if MDP.o(2,iNs) <= NUMBW_LINE
                n = 0;
                X(end + 1,:) = y{n+1}(MDP.o(2,iNs)-(NUMBW_LINE*n),:) + x(MDP.mdp(iNs).o(2,is),:);
                cmap_label(end+1)=iNs;
                X(end,2) = (line_center(n+1,2)+line_center(n+1,1))/2;
             elseif MDP.o(2,iNs) <= NUMBW_LINE*2
                n = 1;
                X(end + 1,:) = y{n+1}(MDP.o(2,iNs)-(NUMBW_LINE*n),:) + x(MDP.mdp(iNs).o(2,is),:);
                cmap_label(end+1)=iNs;
                X(end,2) = (line_center(n+1,2)+line_center(n+1,1))/2;
             elseif MDP.o(2,iNs) <= NUMBW_LINE*3
                n = 2;
                X(end + 1,:) = y{n}(MDP.o(2,iNs)-(NUMBW_LINE*n),:) + x(MDP.mdp(iNs).o(2,is),:);
                cmap_label(end+1)=iNs;
                X(end,2) = (line_center(n+1,2)+line_center(n+1,1))/2;
             elseif MDP.o(2,iNs) <= NUMBW_LINE*4
                n = 3;
                X(end + 1,:) = y{n+1}(MDP.o(2,iNs)-(NUMBW_LINE*n),:) + x(MDP.mdp(iNs).o(2,is),:);
                cmap_label(end+1)=iNs;
                X(end,2) = (line_center(n+1,2)+line_center(n+1,1))/2;
             elseif MDP.o(2,iNs) <= NUMBW_LINE*5
                n = 4;
                X(end + 1,:) = y{n+1}(MDP.o(2,iNs)-(NUMBW_LINE*n),:) + x(MDP.mdp(iNs).o(2,is),:);
                cmap_label(end+1)=iNs;
                X(end,2) = (line_center(n+1,2)+line_center(n+1,1))/2;
             end
         end
    end
    DARC=ry_max/24;
    % Smooth and plot eye movements
    %--------------------------------------------------------------------------
    for pl = 1:size(X,1)-1
        x1 = X(pl,:);
        x3 = X(pl+1,:);
        ns = randn*0.1; % noise

        if mod(pl,2)==0
            x2 = [mean([x1(1),x3(1)]), ((x1(2)/24 + DARC + ns))/4];
        else
            x2 = [mean([x1(1),x3(1)]), (-x1(2)/24 - DARC - ns)/4];
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
    
    p=[0,0,XMAX_T*30,80]; set(hfig, 'Position',p);
    
    if nargout==0
        set(hfig,'visible','on');
    end
end