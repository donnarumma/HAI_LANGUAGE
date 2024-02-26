%% main to evaluate the Analysis Result obtained
function [Time_over_max,Wrong_sent,Accuracy_final,Back_level,Backw_statistic,Saccad_statistic,Prob_statistic] = HAI_result_eval(Back_final,Sacc_total,Exit_time,Accuracy,Prob_exit,Probability)

%% Number of wrong elment
        Time_over_max = find([Exit_time{:,2}] == 8);
        Wrong_sent = find([Accuracy{:,2}] == 0);
  % Wrong sentence identification
    Wrong_Acc = find([Accuracy{:,2}] == 0);
    if Wrong_Acc ~=0
           Back_final(Wrong_Acc,:) = [];
           Sacc_total(Wrong_Acc,:) = [];
           Prob_exit(Wrong_Acc,:) = [];
           Accuracy(Wrong_Acc,:) = [];
    end
    Accuracy_final = sum([Accuracy{:,2}]);

   
    % Mean bacword saccades for each level (1 low, 2 high, 3 higher...)
    % row(1) means, row(2) dev st, columns are the levels
    back_out = zeros(length(Back_final),size(Back_final{1,2},2));
    for bk = 1:length(Back_final)
        back_out(bk,:) = Back_final{bk,2};
    end
    mean_back_lev = zeros(1,size(back_out,2));
    std_back_lev = zeros(1,size(back_out,2));
    for j=1:size(back_out,2)
        mean_back_lev(1,j) = mean([back_out(:,j)]);
        std_back_lev(1,j) = std([back_out(:,j)])/sqrt(size(back_out,1));
    end
    Back_level = [mean_back_lev;std_back_lev];

    Total_Backsaccades = zeros(1,length(Back_final));
    for i=1:length(Back_final)
        Total_Backsaccades(i) = sum([Back_final{i,2:end}]);
    end
    mean_back_tot = mean(Total_Backsaccades);
    std_back_tot = std(Total_Backsaccades)/sqrt(size(Back_final,1));
    
    Backw_statistic = [mean_back_tot;std_back_tot];

    % Mean and standard deviation Probability of exit
    mean_prob = mean([Prob_exit{:,2}]);
    std_prob = std([Prob_exit{:,2}])/sqrt(size(Prob_exit,1));

    Prob_statistic = [mean_prob;std_prob];

    % Mean and Standard deviation Saccades
    mean_sacc = mean([Sacc_total{:,2}]);
    std_sacc = std([Sacc_total{:,2}])/sqrt(size(Sacc_total,1));

    Saccad_statistic = [mean_sacc;std_sacc];
