% Sim1_Fig5a 
% main for boxplot figures 5 a)

%% parameters
rem_out = false; % remove outliers  
campion = true; % Standard deviation for population or sample
sigma_parameter = [1 2 3]; %percentage of the sigma interval

%% Four Letters MDP paths
SEP = filesep;
%% Four Letter
path1 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_CM_4l'  SEP];

path2 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM1_4l' SEP];

path3 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM2_4l' SEP];

path4 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM_4l'  SEP];

%% Eight Letter
path5 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_CM_8l'  SEP];

path6 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM1_8l' SEP];

path7 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM2_8l' SEP];

path8 = ['.' SEP 'HAI_LANGUAGE' SEP 'Sim1_DM_8l'  SEP];

Output_parameters_Group1 = boxplotparameters(path1,rem_out,campion,sigma_parameter(1));

Output_parameters_Group2 = boxplotparameters(path2,rem_out,campion,sigma_parameter(1));

Output_parameters_Group3 = boxplotparameters(path3,rem_out,campion,sigma_parameter(1));

Output_parameters_Group4 = boxplotparameters(path4,rem_out,campion,sigma_parameter(1));

Output_parameters_Group5 = boxplotparameters(path5,rem_out,campion,sigma_parameter(1));

Output_parameters_Group6 = boxplotparameters(path6,rem_out,campion,sigma_parameter(1));

Output_parameters_Group7 = boxplotparameters(path7,rem_out,campion,sigma_parameter(1));

Output_parameters_Group8 = boxplotparameters(path8,rem_out,campion,sigma_parameter(1));

%% plot del boxplot

% box width and boxplot offset
box_width = 0.5;
box_position = 0.1;
box_offset = 0.2;
%% box color
% Light blue colors
% cmaps = [0.7,0.85,1;0.5,0.7,1];
cmaps = [0.7 0.85 1 1; 1 0.15 0 0.2; 1 0.15 0 0.4; 1 0.15 0 1];
box_dist = [1,2,3,4,5,6,7,8,9];

%% boxplot figure total saccades
figure;
hold on;
% Boxplot mean first group
rectangle('Position', [box_dist(1)-box_width/2, (Output_parameters_Group1.Total.mean - sigma_parameter(1)*Output_parameters_Group1.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group1.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1,'FaceColor', cmaps(1,:));
line([box_dist(1) box_dist(1)], [Output_parameters_Group1.Total.lower_wisker_mean, (Output_parameters_Group1.Total.mean - sigma_parameter(1)*Output_parameters_Group1.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(1) box_dist(1)], [(Output_parameters_Group1.Total.mean+sigma_parameter(1)*Output_parameters_Group1.Total.dev), Output_parameters_Group1.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(1)-box_width/2, box_dist(1)+box_width/2], [Output_parameters_Group1.Total.mean, Output_parameters_Group1.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(1)-box_width/6, box_dist(1)+box_width/6], [Output_parameters_Group1.Total.lower_wisker_mean, Output_parameters_Group1.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1);
line([box_dist(1)-box_width/6, box_dist(1)+box_width/6], [Output_parameters_Group1.Total.upper_wisker_mean, Output_parameters_Group1.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

% Boxplot mean group 2
rectangle('Position', [box_dist(2)-box_width/2, (Output_parameters_Group2.Total.mean- sigma_parameter(1)*Output_parameters_Group2.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group2.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(2,:));
line([box_dist(2) box_dist(2)], [Output_parameters_Group2.Total.lower_wisker_mean, (Output_parameters_Group2.Total.mean - sigma_parameter(1)*Output_parameters_Group2.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(2) box_dist(2)], [(Output_parameters_Group2.Total.mean+sigma_parameter(1)*Output_parameters_Group2.Total.dev), Output_parameters_Group2.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(2)-box_width/2, box_dist(2)+box_width/2], [Output_parameters_Group2.Total.mean, Output_parameters_Group2.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(2)-box_width/6, box_dist(2)+box_width/6], [Output_parameters_Group2.Total.lower_wisker_mean, Output_parameters_Group2.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(2)-box_width/6, box_dist(2)+box_width/6], [Output_parameters_Group2.Total.upper_wisker_mean, Output_parameters_Group2.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 3
rectangle('Position', [box_dist(3)-box_width/2,(Output_parameters_Group3.Total.mean- sigma_parameter(1)*Output_parameters_Group3.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group3.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(3,:));
line([box_dist(3) box_dist(3)], [Output_parameters_Group3.Total.lower_wisker_mean, (Output_parameters_Group3.Total.mean - sigma_parameter(1)*Output_parameters_Group3.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(3) box_dist(3)], [(Output_parameters_Group3.Total.mean+sigma_parameter(1)*Output_parameters_Group3.Total.dev), Output_parameters_Group3.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(3)-box_width/2, box_dist(3)+box_width/2], [Output_parameters_Group3.Total.mean, Output_parameters_Group3.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(3)-box_width/6, box_dist(3)+box_width/6], [Output_parameters_Group3.Total.lower_wisker_mean, Output_parameters_Group3.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(3)-box_width/6, box_dist(3)+box_width/6], [Output_parameters_Group3.Total.upper_wisker_mean, Output_parameters_Group3.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 4
rectangle('Position', [box_dist(4)-box_width/2, (Output_parameters_Group4.Total.mean- sigma_parameter(1)*Output_parameters_Group4.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group4.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(4,:));
line([box_dist(4) box_dist(4)], [Output_parameters_Group4.Total.lower_wisker_mean, (Output_parameters_Group4.Total.mean - sigma_parameter(1)*Output_parameters_Group4.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(4) box_dist(4)], [(Output_parameters_Group4.Total.mean+sigma_parameter(1)*Output_parameters_Group4.Total.dev), Output_parameters_Group4.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(4)-box_width/2, box_dist(4)+box_width/2], [Output_parameters_Group4.Total.mean, Output_parameters_Group4.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(4)-box_width/6, box_dist(4)+box_width/6], [Output_parameters_Group4.Total.lower_wisker_mean, Output_parameters_Group4.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(4)-box_width/6, box_dist(4)+box_width/6], [Output_parameters_Group4.Total.upper_wisker_mean, Output_parameters_Group4.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar


% Boxplot mean group 5
rectangle('Position', [box_dist(6)-box_width/2,(Output_parameters_Group5.Total.mean- sigma_parameter(1)*Output_parameters_Group5.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group5.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(1,:));
line([box_dist(6) box_dist(6)], [Output_parameters_Group5.Total.lower_wisker_mean, (Output_parameters_Group5.Total.mean - sigma_parameter(1)*Output_parameters_Group5.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(6) box_dist(6)], [(Output_parameters_Group5.Total.mean+sigma_parameter(1)*Output_parameters_Group5.Total.dev), Output_parameters_Group5.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(6)-box_width/2, box_dist(6)+box_width/2], [Output_parameters_Group5.Total.mean, Output_parameters_Group5.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(6)-box_width/6, box_dist(6)+box_width/6], [Output_parameters_Group5.Total.lower_wisker_mean, Output_parameters_Group5.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(6)-box_width/6, box_dist(6)+box_width/6], [Output_parameters_Group5.Total.upper_wisker_mean, Output_parameters_Group5.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 6
rectangle('Position', [box_dist(7)-box_width/2,(Output_parameters_Group6.Total.mean- sigma_parameter(1)*Output_parameters_Group6.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group6.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(2,:));
line([box_dist(7) box_dist(7)], [Output_parameters_Group6.Total.lower_wisker_mean, (Output_parameters_Group6.Total.mean - sigma_parameter(1)*Output_parameters_Group6.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(7) box_dist(7)], [(Output_parameters_Group6.Total.mean+sigma_parameter(1)*Output_parameters_Group6.Total.dev), Output_parameters_Group6.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(7)-box_width/2, box_dist(7)+box_width/2], [Output_parameters_Group6.Total.mean, Output_parameters_Group6.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(7)-box_width/6, box_dist(7)+box_width/6], [Output_parameters_Group6.Total.lower_wisker_mean, Output_parameters_Group6.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(7)-box_width/6, box_dist(7)+box_width/6], [Output_parameters_Group6.Total.upper_wisker_mean, Output_parameters_Group6.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 7
rectangle('Position', [box_dist(8)-box_width/2,(Output_parameters_Group7.Total.mean- sigma_parameter(1)*Output_parameters_Group7.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group7.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(3,:));
line([box_dist(8) box_dist(8)], [Output_parameters_Group7.Total.lower_wisker_mean, (Output_parameters_Group7.Total.mean - sigma_parameter(1)*Output_parameters_Group7.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(8) box_dist(8)], [(Output_parameters_Group7.Total.mean+sigma_parameter(1)*Output_parameters_Group7.Total.dev), Output_parameters_Group7.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(8)-box_width/2, box_dist(8)+box_width/2], [Output_parameters_Group7.Total.mean, Output_parameters_Group7.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(8)-box_width/6, box_dist(8)+box_width/6], [Output_parameters_Group7.Total.lower_wisker_mean, Output_parameters_Group7.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(8)-box_width/6, box_dist(8)+box_width/6], [Output_parameters_Group7.Total.upper_wisker_mean, Output_parameters_Group7.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

% Boxplot mean group 8
rectangle('Position', [box_dist(9)-box_width/2,(Output_parameters_Group8.Total.mean- sigma_parameter(1)*Output_parameters_Group8.Total.dev), box_width, 2*sigma_parameter(1)*Output_parameters_Group8.Total.dev], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', cmaps(4,:));
line([box_dist(9) box_dist(9)], [Output_parameters_Group8.Total.lower_wisker_mean, (Output_parameters_Group8.Total.mean - sigma_parameter(1)*Output_parameters_Group8.Total.dev)], 'Color', 'k', 'LineWidth', 1);
line([box_dist(9) box_dist(9)], [(Output_parameters_Group8.Total.mean+sigma_parameter(1)*Output_parameters_Group8.Total.dev), Output_parameters_Group8.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(9)-box_width/2, box_dist(9)+box_width/2], [Output_parameters_Group8.Total.mean, Output_parameters_Group8.Total.mean], 'Color', 'k', 'LineWidth', 1);

line([box_dist(9)-box_width/6, box_dist(9)+box_width/6], [Output_parameters_Group8.Total.lower_wisker_mean, Output_parameters_Group8.Total.lower_wisker_mean], 'Color', 'k', 'LineWidth', 1); % orizzontal bar
line([box_dist(9)-box_width/6, box_dist(9)+box_width/6], [Output_parameters_Group8.Total.upper_wisker_mean, Output_parameters_Group8.Total.upper_wisker_mean], 'Color', 'k', 'LineWidth', 1); %  orizzontal bar

%%
xticks([2.5 7.5]);
xticklabels({'4-letter','8-letter'});
%% axis limit
xlim([0 10])
ymin = min([Output_parameters_Group1.Total.lower_wisker_mean,Output_parameters_Group2.Total.lower_wisker_mean,Output_parameters_Group3.Total.lower_wisker_mean,Output_parameters_Group4.Total.lower_wisker_mean,Output_parameters_Group5.Total.lower_wisker_mean,Output_parameters_Group6.Total.lower_wisker_mean,Output_parameters_Group7.Total.lower_wisker_mean,Output_parameters_Group8.Total.lower_wisker_mean])-1;
ymax = max([Output_parameters_Group1.Total.upper_wisker_mean,Output_parameters_Group2.Total.upper_wisker_mean,Output_parameters_Group3.Total.upper_wisker_mean,Output_parameters_Group4.Total.upper_wisker_mean,Output_parameters_Group5.Total.upper_wisker_mean,Output_parameters_Group6.Total.upper_wisker_mean,Output_parameters_Group7.Total.upper_wisker_mean,Output_parameters_Group8.Total.upper_wisker_mean]);
ylim([ymin ymax+3])
% yt = yticks;
% yticks(yt(1:end-1))
% separation line
line([box_dist(5) , box_dist(5)], [ymin ymax+3], 'Color', 'k', 'LineStyle', '--', 'LineWidth',1);

xlabel('Number of letters in the word')
ylabel('Total number of saccades [#]') 
grid on
set(gca, 'FontSize', 16);

legend('','Location','northeast')
% col_names = ["Control Model (CM)","Dyslexic Model (DM)"];
col_names = ["Control Model","DM - Noise on Level 1","DM - Noise on Level 2","Dyslexic Model"];
for i = 1:length(col_names)
    plot([NaN NaN NaN NaN],[NaN NaN NaN NaN],'Color',cmaps(i,:),'DisplayName',col_names(i),'LineWidth',1.5)
end

set(gcf,'position',[0,0,525,800])
box on
hold off

print('-depsc2','fig5a.eps')
