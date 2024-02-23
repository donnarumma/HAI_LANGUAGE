%% function for boxplot execution

function Output_parameters = boxplotparameters(path,rim_out,campion,sigma_parameter)

[Pre_Result,Result] = MDP_analysis(path);

sacc_1 = Pre_Result.Sacc_total;

back_1 = Pre_Result.Back_final;

Wrong_Acc = find([Pre_Result.Accuracy{:,2}] == 0);
if Wrong_Acc ~=0
    sacc_1(Wrong_Acc,:) = [];
    back_1(Wrong_Acc,:) = [];
end

%% rightword saccades evaluation
% sum of all backward
for i=1:length(back_1)
    b1(i)=sum([back_1{i,2}]);
end
% saccades identification
s1 = [sacc_1{:,2}];

% rightward saccades

right_forw = nan(length(s1));
for j = 1:length(s1)
    right_forw(j) = s1(j)-b1(j);
end

if rim_out
    s1 = rmoutliers(s1,'percentiles',[5,95]);
    b1 = rmoutliers(b1,'percentiles',[5,95]);
    right_forw = rmoutliers(right_forw,'percentiles',[5, 95]);
end

%% parameters evaluation
% mean
Total_mean = mean(s1);
RightForw_mean = mean(right_forw);
Backw_mean = mean(b1);

if campion
    % Standard deviation c
    Total_dev = std(s1)/sqrt(length(s1));
    RightForw_dev = std(right_forw)/sqrt(length(right_forw));
    Backw_dev = std(b1)/sqrt(length(b1));
else 
    Total_dev = std(s1);
    RightForw_dev = std(right_forw);
    Backw_dev = std(b1);
end
% median
Total_median = median(s1);
RightForw_median = median(right_forw);
Backw_median = median(b1);

% max and min
Total_max = max(s1);
RightForw_max = max(right_forw);
Backw_max = max(b1);

Total_min = min(s1);
RightForw_min = min(right_forw);
Backw_min = min(b1);

% quartili
percentiles = [0.25, 0.75];
Total_quantiles = quantile(s1, percentiles);
RightForw_quantiles = quantile(right_forw, percentiles);
Backw_quantiles = quantile(b1, percentiles);


%% wiskers group of median
lower_whisker_Total_quantile = min(s1(s1 >= Total_quantiles(1) - 1.5*(Total_quantiles(2)-Total_quantiles(1))));
upper_whisker_Total_quantile = max(s1(s1 <= Total_quantiles(2) + 1.5*(Total_quantiles(2)-Total_quantiles(1))));

lower_whisker_RightForw_quantile = min(right_forw(right_forw >= RightForw_quantiles(1) - 1.5*(RightForw_quantiles(2)-RightForw_quantiles(1))));
upper_whisker_RightForw_quantile = max(right_forw(right_forw <= RightForw_quantiles(2) + 1.5*(RightForw_quantiles(2)-RightForw_quantiles(1))));

lower_whisker_Backw_quantile = min(b1(b1 >= Backw_quantiles(1) - 1.5*(Backw_quantiles(2)-Backw_quantiles(1))));
upper_whisker_Backw_quantile = max(b1(b1 <= Backw_quantiles(2) + 1.5*(Backw_quantiles(2)-Backw_quantiles(1))));


%% wiskers group of mean with min and max
lower_whisker_Total_mean = (Total_mean - 3*sigma_parameter*Total_dev);
upper_whisker_Total_mean = (Total_mean + 3*sigma_parameter*Total_dev);

lower_whisker_RightForw_mean = (RightForw_mean - 3*sigma_parameter*RightForw_dev);
upper_whisker_RightForw_mean = (RightForw_mean + 3*sigma_parameter*RightForw_dev);

lower_whisker_Backw_mean = (Backw_mean - 3*sigma_parameter*Backw_dev);
upper_whisker_Backw_mean = (Backw_mean + 3*sigma_parameter*Backw_dev);

% %% wiskers group of mean with min and max
% lower_whisker_Total_mean = min(s1(s1 >= (Total_mean - sigma_parameter*Total_dev) - 2*(2*sigma_parameter*Total_dev)));
% upper_whisker_Total_mean = max(s1(s1 <= (Total_mean + sigma_parameter*Total_dev) + 2*(2*sigma_parameter*Total_dev)));
% 
% lower_whisker_RightForw_mean = min(right_forw(right_forw >= (RightForw_mean - sigma_parameter*RightForw_dev) - 2*(2*sigma_parameter*RightForw_dev)));
% upper_whisker_RightForw_mean = max(right_forw(right_forw <= (RightForw_mean + sigma_parameter*RightForw_dev) + 2*(2*sigma_parameter*RightForw_dev)));
% 
% lower_whisker_Backw_mean = min(b1(b1 >= (Backw_mean - sigma_parameter*Backw_dev) - 2*(2*sigma_parameter*Backw_dev)));
% upper_whisker_Backw_mean = max(b1(b1 <= (Backw_mean + sigma_parameter*Backw_dev) + 2*(2*sigma_parameter*Backw_dev)));


Output_parameters.Total.mean = Total_mean;
Output_parameters.Total.dev = Total_dev;
Output_parameters.Total.max = Total_max;
Output_parameters.Total.min = Total_min;
Output_parameters.Total.median = Total_median;
Output_parameters.Total.quantile = Total_quantiles;
Output_parameters.Total.lower_wisker_quantile = lower_whisker_Total_quantile;
Output_parameters.Total.upper_wisker_quantile = upper_whisker_Total_quantile;
Output_parameters.Total.lower_wisker_mean= lower_whisker_Total_mean;
Output_parameters.Total.upper_wisker_mean= upper_whisker_Total_mean;


Output_parameters.RightForward.mean = RightForw_mean;
Output_parameters.RightForward.dev = RightForw_dev;
Output_parameters.RightForward.max = RightForw_max;
Output_parameters.RightForward.min = RightForw_min;
Output_parameters.RightForward.median = RightForw_median;
Output_parameters.RightForward.quantile = RightForw_quantiles;
Output_parameters.RightForward.lower_wisker_quantile = lower_whisker_RightForw_quantile;
Output_parameters.RightForward.upper_wisker_quantile = upper_whisker_RightForw_quantile;
Output_parameters.RightForward.lower_wisker_mean= lower_whisker_RightForw_mean;
Output_parameters.RightForward.upper_wisker_mean= upper_whisker_RightForw_mean;

Output_parameters.Backward.mean = Backw_mean;
Output_parameters.Backward.dev = Backw_dev;
Output_parameters.Backward.max = Backw_max;
Output_parameters.Backward.min = Backw_min;
Output_parameters.Backward.median = Backw_median;
Output_parameters.Backward.quantile = Backw_quantiles;
Output_parameters.Backward.lower_wisker_quantile = lower_whisker_Backw_quantile;
Output_parameters.Backward.upper_wisker_quantile = upper_whisker_Backw_quantile;
Output_parameters.Backward.lower_wisker_mean= lower_whisker_Backw_mean;
Output_parameters.Backward.upper_wisker_mean= upper_whisker_Backw_mean;

Output_parameters.Result = Result;
Output_parameters.Pre_Result = Pre_Result;