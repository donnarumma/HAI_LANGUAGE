function   h=PLOT_Saccades_paragraph(MDP_STEPS,params)
% function h=PLOT_Saccades_paragraph(MDP_STEPS,params)
% MDP is the Model organized in high and low (mdp) levels
% NSUB the low levels to plot (default all)
% GT Ground Truth state (default: initial state s of MDP)
% illustrates visual search graphically
%--------------------------------------------------------------------------
if isempty(params.hfig)
    hfig=figure;
else
    hfig=params.hfig;
end
if nargout>0
    h = hfig;
end

% lw          = 2;                % linewidth of the saccadic lines
LDIM        = 2;                % space between two letters
map_yellow  = [0.8,0.8,0.2];    % color of the saccadic points
markertype  ='o';              % marker of the saccadic point
% ms          = 5;               % marker size
ms          = params.ms;
lw          = params.lw;
% Define the number of word for each line and the interline lenght
% NUMBW_LINE  = 6;
NUMBW_LINE  = params.NUMBW_LINE;
% NUMBW_LINE  = 11;                     % number of word for line

% INT_LINE    = 0.2;                    % interline lenght
INT_LINE    = params.INT_LINE;
if isempty(params.STEP)                 % choose last step
    Nsteps=length(MDP_STEPS);
else
    Nsteps=params.STEP;
end

MDP         =MDP_STEPS{Nsteps};  

STS     =MDP.sname{1};          % assumes that the first  level are sentences 
words   =HAI_level(MDP.MDP,''); % assumes that the second level are words 
if isempty(params.GT)           % if empty assumes the system read the correct sentence
    s       =MDP.s(1,1);
    phr     =STS{s};
else
    phr     =params.GT;
end
% find maximum length word and store it in max_word
for i = 1:length(words)
    len(i) = length(words{i});
end
[~, v_max] = max(len);
max_word = length(words{v_max});

%% sentence reconstruction
for j = 1:size(phr,2)
    phr_word = phr{1,j};
    n=1;
    for k = 1: size(phr_word,2)
        phr_syll = phr_word{1,k};
        for l = 1:size(phr_syll,2)
            phr_lett = phr_syll{l};
            if phr_lett ~= ' '
                phr_sent{1,j}{1,n} = phr_lett;
                n=n+1;
            end
        end
    end
    if size(phr_sent{1,j},2) <= max_word
       phr_sent_final{1,j}=phr_sent{1,j};
       for m = size(phr_sent{1,j},2)+1:size(phr_syll,2)
            phr_sent_final{1,j}{m} = ' ';
       end
    end
    for k_syll = 2:size(phr_word,2)
        num_lett_syll = 0;
        if phr_word{1,k_syll}{1} ~= ' '
            numb_syll{j,k_syll} = 1;
            for cont = 1:length(phr_word{1,k_syll})
                if phr_word{1,k_syll}{cont} ~= ' '
                    num_lett_syll = num_lett_syll +1;
                end
            end
            num_lett{j,k_syll} = num_lett_syll;
        else
            numb_syll{j,k_syll} = 0;
            num_lett{j,k_syll} = 0;
        end
    end
end
for i=1:size(numb_syll,1)
    numb_syll{i,1} = 1;
end
for i=1:size(num_lett,1)
    num_lett{i,1} = 0;
end
sum_riga_lett = sum(cell2mat(num_lett)')';

% sum_num_syll  = sum(cell2mat(numb_syll)');

for cn = 1:length(phr_sent_final)
    phr_word_cn = phr_sent_final{1,cn};
    count_corr = 0;
    for cns = 1:length(phr_word_cn)
        if phr_word_cn{cns} ~=' '
            count_corr = count_corr + 1;
        end
    end
    count_corr_word{cn} = count_corr;
end
for i=1:size(num_lett,1)
    num_lett{i,1} = cell2mat(count_corr_word(i))-sum_riga_lett(i);
end
for i=1:size(num_lett,1)
    for j=1:size(num_lett,2)
        if num_lett{i,j} ~= 0
            num_lett_pos{i,j} = 1:num_lett{i,j};
        else
            num_lett_pos{i,j} = 0;
        end
    end
end

for i=2:size(num_lett_pos,1)
    for j=2:size(num_lett_pos,2)
        if num_lett_pos{i,j} ~= 0
            for k =1:length(num_lett_pos{i,j})
                num_lett_pos{i,j}(1,k) =  num_lett_pos{i,j}(1,k) + num_lett_pos{i,j-1}(1,end);
            end
        end
    end
end
           

% count number of letters and words for each sentence
WORDNUMBER  = length(phr_sent_final);
for len = 1:length(phr_sent_final)
    len_lett(len) = size(phr_sent_final{len},2);
end
LETTERNUMBER=max(len_lett);

% Count number or line
[N_LINE,LINE_VEC,iw_end]=PLOT_LineCount(WORDNUMBER,NUMBW_LINE);
%-------------------------------------------------------------------------
% create the plot coordinates
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
        lenWs(len_ws)=length(HAI_retrieveLevel(phr_sent_final{iw}));
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

% insert spaces
for lws = 1:length(lenWSpace)
    for il=1:length(lenWSpace{lws})-1 
        wordLoc{lws}(il+1)=(lenWSpace{lws}(il))*LDIM+wordLoc{lws}(il); 
    end
    y{lws}(:,1) = wordLoc{lws};
end
    

% plot the cues
%--------------------------------------------------------------------------
hold on; legend off; axis ij; 
cax=gca;
wp=[0,0,XMAX_T*30,80]; 
wp=[0,0,ceil(WORDNUMBER/NUMBW_LINE)*500,NUMBW_LINE*300]; 
set(hfig, 'Position',wp);
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
        a = HAI_retrieveLevel(phr_sent_final{iWW+NUMBW_LINE*m});
        for iLL = 1:numel(a)
            image(rx + y{1,p}(iWW,1) + x(iLL,1),ry + y{1,p}(iWW,2) + x(iLL,2),  PLOT_createCharacterImage(a(iLL)));% hold on
        end
    end
    m = m+1;
    ry = ry + (1 - 0.2*2 + INT_LINE);
    line_center(p+1,:) = ry;
end



%% for each MDP step
cmaps=linspecer(length(MDP.oname{2})); % one color for each word location **** old one: % cmaps=linspecer(length(MDP.mdp));
[X,cmap_label] = PLOT_getSaccadesCOORD(MDP_STEPS,Nsteps,x,y,line_center,num_lett_pos,NUMBW_LINE);
DARC=0*ry_max/(2^8);
% Smooth and plot eye movements
%--------------------------------------------------------------------------
plot(X(1,1),X(1,2),'marker',markertype,'linestyle','none','color',map_yellow,'MarkerSize',ms,'MarkerEdgeColor','k','MarkerFaceColor',map_yellow)

if params.SAVE_MOVIE
    nf = [params.SAVE_MOVIE filesep 'SaccadesMovie'];
    nf = sprintf('%s',nf,fromNumToOrderedString(0,size(X,1)));
    print(hfig,nf,'-djpeg');
end
for pl = 1:size(X,1)-1
    x1 = X(pl,:);
    x3 = X(pl+1,:);
    ns = randn*0.1; % noise

    if mod(pl,2)==0
        x2 = [mean([x1(1),x3(1)]), mean([x1(2),x3(2)]) + (DARC + ns)];
    else
        x2 = [mean([x1(1),x3(1)]), mean([x1(2),x3(2)]) - (DARC + ns)];
    end
    x_pl = [x1;x2;x3];
    f = fit(x_pl(:,1),x_pl(:,2),'poly2');
    hp = plot(f,[x1(1) x3(1)],[x1(2) x3(2)]);
    set(hp,'color',cmaps(cmap_label(pl),:));
    set(hp,'linewidth',lw);
    
    plot(X(pl+1,1),X(pl+1,2),'marker',markertype,'linestyle','none','color',map_yellow,'MarkerSize',ms,'MarkerEdgeColor','k','MarkerFaceColor',map_yellow)

    legend off
    if params.SAVE_MOVIE
        nf = [params.SAVE_MOVIE filesep 'SaccadesMovie'];
        nf = sprintf('%s',nf,fromNumToOrderedString(pl,size(X,1)));
        print(hfig,nf,'-djpeg');
    end
end

%plot(X(:,1),X(:,2),'marker',markertype,'linestyle','none','color',map_yellow,'MarkerSize',ms,'MarkerEdgeColor','k','MarkerFaceColor',map_yellow)

X = [];   
    
end
