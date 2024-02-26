%% function for boxplot execution

function Out_par = boxplotparameters(path)

% parameters identification
parameters = MDP_analysis(path);

% data extraction
sacc = parameters.Sacc_total;
back = parameters.Back_final;

% Non correct word identification
Wrong_Acc = find([parameters.Accuracy{:,2}] == 0);
if Wrong_Acc ~=0
    sacc(Wrong_Acc,:) = [];
    back(Wrong_Acc,:) = [];
end

%% rightword saccades evaluation
% sum of all backward
back_1 = nan(length(back));
for i=1:length(back)
    back_1(i)=sum([back{i,2}]);
end

% saccades identification
sacc_1 = [sacc{:,2}];

% rightward saccades
right_forw = nan(length(sacc_1));
for j = 1:length(sacc_1)
    right_forw(j) = sacc_1(j)-back_1(j);
end

%% statistical parameters evaluation
% mean
Total_mean = mean(sacc_1);
RightForw_mean = mean(right_forw);
Backw_mean = mean(back_1);

% Standard deviation
Total_dev = std(sacc_1)/sqrt(length(sacc_1));
RightForw_dev = std(right_forw)/sqrt(length(right_forw));
Backw_dev = std(back_1)/sqrt(length(back_1));

% median
Total_median = median(sacc_1);
RightForw_median = median(right_forw);
Backw_median = median(back_1);

% max and min
Total_max = max(sacc_1);
RightForw_max = max(right_forw);
Backw_max = max(back_1);

Total_min = min(sacc_1);
RightForw_min = min(right_forw);
Backw_min = min(back_1);

% quantiles 
percentiles = [0.25, 0.75];
Total_quantiles = quantile(sacc_1, percentiles);
RightForw_quantiles = quantile(right_forw, percentiles);
Backw_quantiles = quantile(back_1, percentiles);


%% wiskers group of median
lower_whisker_Total_quantile = min(sacc_1(sacc_1 >= Total_quantiles(1) - 1.5*(Total_quantiles(2)-Total_quantiles(1))));
upper_whisker_Total_quantile = max(sacc_1(sacc_1 <= Total_quantiles(2) + 1.5*(Total_quantiles(2)-Total_quantiles(1))));

lower_whisker_RightForw_quantile = min(right_forw(right_forw >= RightForw_quantiles(1) - 1.5*(RightForw_quantiles(2)-RightForw_quantiles(1))));
upper_whisker_RightForw_quantile = max(right_forw(right_forw <= RightForw_quantiles(2) + 1.5*(RightForw_quantiles(2)-RightForw_quantiles(1))));

lower_whisker_Backw_quantile = min(back_1(back_1 >= Backw_quantiles(1) - 1.5*(Backw_quantiles(2)-Backw_quantiles(1))));
upper_whisker_Backw_quantile = max(back_1(back_1 <= Backw_quantiles(2) + 1.5*(Backw_quantiles(2)-Backw_quantiles(1))));

sigma_parameter = 1; %percentage of the sigma interval
%% wiskers group of mean with min and max
lower_whisker_Total_mean = (Total_mean - 3*sigma_parameter*Total_dev);
upper_whisker_Total_mean = (Total_mean + 3*sigma_parameter*Total_dev);

lower_whisker_RightForw_mean = (RightForw_mean - 3*sigma_parameter*RightForw_dev);
upper_whisker_RightForw_mean = (RightForw_mean + 3*sigma_parameter*RightForw_dev);

lower_whisker_Backw_mean = (Backw_mean - 3*sigma_parameter*Backw_dev);
upper_whisker_Backw_mean = (Backw_mean + 3*sigma_parameter*Backw_dev);


Out_par.Total.mean = Total_mean;
Out_par.Total.dev = Total_dev;
Out_par.Total.max = Total_max;
Out_par.Total.min = Total_min;
Out_par.Total.median = Total_median;
Out_par.Total.quantile = Total_quantiles;
Out_par.Total.lower_wisker_quantile = lower_whisker_Total_quantile;
Out_par.Total.upper_wisker_quantile = upper_whisker_Total_quantile;
Out_par.Total.lower_wisker_mean= lower_whisker_Total_mean;
Out_par.Total.upper_wisker_mean= upper_whisker_Total_mean;


Out_par.RightForward.mean = RightForw_mean;
Out_par.RightForward.dev = RightForw_dev;
Out_par.RightForward.max = RightForw_max;
Out_par.RightForward.min = RightForw_min;
Out_par.RightForward.median = RightForw_median;
Out_par.RightForward.quantile = RightForw_quantiles;
Out_par.RightForward.lower_wisker_quantile = lower_whisker_RightForw_quantile;
Out_par.RightForward.upper_wisker_quantile = upper_whisker_RightForw_quantile;
Out_par.RightForward.lower_wisker_mean= lower_whisker_RightForw_mean;
Out_par.RightForward.upper_wisker_mean= upper_whisker_RightForw_mean;

Out_par.Backward.mean = Backw_mean;
Out_par.Backward.dev = Backw_dev;
Out_par.Backward.max = Backw_max;
Out_par.Backward.min = Backw_min;
Out_par.Backward.median = Backw_median;
Out_par.Backward.quantile = Backw_quantiles;
Out_par.Backward.lower_wisker_quantile = lower_whisker_Backw_quantile;
Out_par.Backward.upper_wisker_quantile = upper_whisker_Backw_quantile;
Out_par.Backward.lower_wisker_mean= lower_whisker_Backw_mean;
Out_par.Backward.upper_wisker_mean= upper_whisker_Backw_mean;