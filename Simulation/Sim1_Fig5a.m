% Sim1_Fig5a 
% main for boxplot figures 5 a)

dictionary = 'BERT_100_SY';
%% Four Letters MDP paths
SEP = filesep;
%% Four Letter
path1 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_CM_4l' SEP];

path2 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM1_4l' SEP];

path3 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM2_4l' SEP];

path4 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM_4l'  SEP];

%% Eight Letter
path5 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_CM_8l'  SEP];

path6 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM1_8l' SEP];

path7 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM2_8l' SEP];

path8 = ['.' SEP 'HAI_LANGUAGE_TESTS' SEP dictionary SEP 'Sim1_DM_8l'  SEP];

Out_par_CM4l = boxplotparameters(path1);

Out_par_DM14l = boxplotparameters(path2);

Out_par_DM24l = boxplotparameters(path3);

Out_par_DM4l = boxplotparameters(path4);

Out_par_CM8l = boxplotparameters(path5);

Out_par_DM18l = boxplotparameters(path6);

Out_par_DM28l = boxplotparameters(path7);

Out_par_DM8l = boxplotparameters(path8);

%% plot del boxplot

% box width and boxplot offset
box_width = 0.5;
box_position = 0.1;
box_offset = 0.2;
%% boxplot colors

% cmaps = [0.7,0.85,1;0.5,0.7,1]; % Light blue colors
cmaps = [0.7 0.85 1 1; 1 0.15 0 0.2; 1 0.15 0 0.4; 1 0.15 0 1]; % selected colors
box_dist = [1,2,3,4,5,6,7,8,9]; % box distance

%% boxplot figure total saccades
figure;
hold on;
% Boxplot mean first group
rectangle('Position', [box_dist(1)-box_width/2, (Out_par_CM4l.Total.mean - sigma_parameter(1)*Out_par_CM4l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_CM4l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1,'FaceColor', cmaps(1,:));
line([box_dist(1) box_dist(1)], [Out_par_CM4l.Total.lower_wisker_mean, (Out_par_CM4l.Total.mean - sigma_parameter(1)*Out_par_CM4l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(1) box_dist(1)], [(Out_par_CM4l.Total.mean+sigma_parameter(1)*Out_par_CM4l.Total.dev), Out_par_CM4l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(1)-box_width/2, box_dist(1)+box_width/2], [Out_par_CM4l.Total.mean, Out_par_CM4l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(1)-box_width/6, box_dist(1)+box_width/6], [Out_par_CM4l.Total.lower_wisker_mean, Out_par_CM4l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1);
line([box_dist(1)-box_width/6, box_dist(1)+box_width/6], [Out_par_CM4l.Total.upper_wisker_mean, Out_par_CM4l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

% Boxplot mean group 2
rectangle('Position', [box_dist(2)-box_width/2, (Out_par_DM14l.Total.mean- sigma_parameter(1)*Out_par_DM14l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM14l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(2,:));
line([box_dist(2) box_dist(2)], [Out_par_DM14l.Total.lower_wisker_mean, (Out_par_DM14l.Total.mean - sigma_parameter(1)*Out_par_DM14l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(2) box_dist(2)], [(Out_par_DM14l.Total.mean+sigma_parameter(1)*Out_par_DM14l.Total.dev), Out_par_DM14l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(2)-box_width/2, box_dist(2)+box_width/2], [Out_par_DM14l.Total.mean, Out_par_DM14l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(2)-box_width/6, box_dist(2)+box_width/6], [Out_par_DM14l.Total.lower_wisker_mean, Out_par_DM14l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(2)-box_width/6, box_dist(2)+box_width/6], [Out_par_DM14l.Total.upper_wisker_mean, Out_par_DM14l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 3
rectangle('Position', [box_dist(3)-box_width/2,(Out_par_DM24l.Total.mean- sigma_parameter(1)*Out_par_DM24l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM24l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(3,:));
line([box_dist(3) box_dist(3)], [Out_par_DM24l.Total.lower_wisker_mean, (Out_par_DM24l.Total.mean - sigma_parameter(1)*Out_par_DM24l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(3) box_dist(3)], [(Out_par_DM24l.Total.mean+sigma_parameter(1)*Out_par_DM24l.Total.dev), Out_par_DM24l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(3)-box_width/2, box_dist(3)+box_width/2], [Out_par_DM24l.Total.mean, Out_par_DM24l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(3)-box_width/6, box_dist(3)+box_width/6], [Out_par_DM24l.Total.lower_wisker_mean, Out_par_DM24l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(3)-box_width/6, box_dist(3)+box_width/6], [Out_par_DM24l.Total.upper_wisker_mean, Out_par_DM24l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 4
rectangle('Position', [box_dist(4)-box_width/2, (Out_par_DM4l.Total.mean- sigma_parameter(1)*Out_par_DM4l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM4l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(4,:));
line([box_dist(4) box_dist(4)], [Out_par_DM4l.Total.lower_wisker_mean, (Out_par_DM4l.Total.mean - sigma_parameter(1)*Out_par_DM4l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(4) box_dist(4)], [(Out_par_DM4l.Total.mean+sigma_parameter(1)*Out_par_DM4l.Total.dev), Out_par_DM4l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(4)-box_width/2, box_dist(4)+box_width/2], [Out_par_DM4l.Total.mean, Out_par_DM4l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(4)-box_width/6, box_dist(4)+box_width/6], [Out_par_DM4l.Total.lower_wisker_mean, Out_par_DM4l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(4)-box_width/6, box_dist(4)+box_width/6], [Out_par_DM4l.Total.upper_wisker_mean, Out_par_DM4l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar


% Boxplot mean group 5
rectangle('Position', [box_dist(6)-box_width/2,(Out_par_CM8l.Total.mean- sigma_parameter(1)*Out_par_CM8l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_CM8l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(1,:));
line([box_dist(6) box_dist(6)], [Out_par_CM8l.Total.lower_wisker_mean, (Out_par_CM8l.Total.mean - sigma_parameter(1)*Out_par_CM8l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(6) box_dist(6)], [(Out_par_CM8l.Total.mean+sigma_parameter(1)*Out_par_CM8l.Total.dev), Out_par_CM8l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(6)-box_width/2, box_dist(6)+box_width/2], [Out_par_CM8l.Total.mean, Out_par_CM8l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(6)-box_width/6, box_dist(6)+box_width/6], [Out_par_CM8l.Total.lower_wisker_mean, Out_par_CM8l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(6)-box_width/6, box_dist(6)+box_width/6], [Out_par_CM8l.Total.upper_wisker_mean, Out_par_CM8l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 6
rectangle('Position', [box_dist(7)-box_width/2,(Out_par_DM18l.Total.mean- sigma_parameter(1)*Out_par_DM18l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM18l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(2,:));
line([box_dist(7) box_dist(7)], [Out_par_DM18l.Total.lower_wisker_mean, (Out_par_DM18l.Total.mean - sigma_parameter(1)*Out_par_DM18l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(7) box_dist(7)], [(Out_par_DM18l.Total.mean+sigma_parameter(1)*Out_par_DM18l.Total.dev), Out_par_DM18l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(7)-box_width/2, box_dist(7)+box_width/2], [Out_par_DM18l.Total.mean, Out_par_DM18l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(7)-box_width/6, box_dist(7)+box_width/6], [Out_par_DM18l.Total.lower_wisker_mean, Out_par_DM18l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(7)-box_width/6, box_dist(7)+box_width/6], [Out_par_DM18l.Total.upper_wisker_mean, Out_par_DM18l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 7
rectangle('Position', [box_dist(8)-box_width/2,(Out_par_DM28l.Total.mean- sigma_parameter(1)*Out_par_DM28l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM28l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(3,:));
line([box_dist(8) box_dist(8)], [Out_par_DM28l.Total.lower_wisker_mean, (Out_par_DM28l.Total.mean - sigma_parameter(1)*Out_par_DM28l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(8) box_dist(8)], [(Out_par_DM28l.Total.mean+sigma_parameter(1)*Out_par_DM28l.Total.dev), Out_par_DM28l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(8)-box_width/2, box_dist(8)+box_width/2], [Out_par_DM28l.Total.mean, Out_par_DM28l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(8)-box_width/6, box_dist(8)+box_width/6], [Out_par_DM28l.Total.lower_wisker_mean, Out_par_DM28l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(8)-box_width/6, box_dist(8)+box_width/6], [Out_par_DM28l.Total.upper_wisker_mean, Out_par_DM28l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 8
rectangle('Position', [box_dist(9)-box_width/2,(Out_par_DM8l.Total.mean- sigma_parameter(1)*Out_par_DM8l.Total.dev), box_width, 2*sigma_parameter(1)*Out_par_DM8l.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(4,:));
line([box_dist(9) box_dist(9)], [Out_par_DM8l.Total.lower_wisker_mean, (Out_par_DM8l.Total.mean - sigma_parameter(1)*Out_par_DM8l.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(9) box_dist(9)], [(Out_par_DM8l.Total.mean+sigma_parameter(1)*Out_par_DM8l.Total.dev), Out_par_DM8l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(9)-box_width/2, box_dist(9)+box_width/2], [Out_par_DM8l.Total.mean, Out_par_DM8l.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(9)-box_width/6, box_dist(9)+box_width/6], [Out_par_DM8l.Total.lower_wisker_mean, Out_par_DM8l.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(9)-box_width/6, box_dist(9)+box_width/6], [Out_par_DM8l.Total.upper_wisker_mean, Out_par_DM8l.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

%%
xticks([2.5 7.5]);
xticklabels({'4-letter','8-letter'});
%% axis limit
xlim([0 10])
ymin = min([Out_par_CM4l.Total.lower_wisker_mean,Out_par_DM14l.Total.lower_wisker_mean,Out_par_DM24l.Total.lower_wisker_mean,Out_par_DM4l.Total.lower_wisker_mean,Out_par_CM8l.Total.lower_wisker_mean,Out_par_DM18l.Total.lower_wisker_mean,Out_par_DM28l.Total.lower_wisker_mean,Out_par_DM8l.Total.lower_wisker_mean])-1;
ymax = max([Out_par_CM4l.Total.upper_wisker_mean,Out_par_DM14l.Total.upper_wisker_mean,Out_par_DM24l.Total.upper_wisker_mean,Out_par_DM4l.Total.upper_wisker_mean,Out_par_CM8l.Total.upper_wisker_mean,Out_par_DM18l.Total.upper_wisker_mean,Out_par_DM28l.Total.upper_wisker_mean,Out_par_DM8l.Total.upper_wisker_mean]);
ylim([ymin ymax+3])

% separation line
line([box_dist(5) , box_dist(5)], [ymin ymax+3], 'Color', 'k', 'LineStyle', '--', 'LineWidth',1);

xlabel('Number of letters in the word')
ylabel('Total number of saccades [#]') 
grid on
set(gca, 'FontSize', 16);

legend('','Location','northeast')
col_names = ["Control Model","DM - Noise on Level 1","DM - Noise on Level 2","Dyslexic Model"];
for i = 1:length(col_names)
    plot([NaN NaN NaN NaN],[NaN NaN NaN NaN],'Color',cmaps(i,:),'DisplayName',col_names(i),'LineWidth',1.5)
end

set(gcf,'position',[0,0,525,800])
box on
hold off

% save eps
print('-depsc2','fig5a.eps')
