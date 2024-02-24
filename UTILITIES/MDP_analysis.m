%% This function extract all MDP from one path and evaluate intresting parameters
function [Pre_Result,Result] = MDP_analysis(path)
%% MDP analysis on sentence

%% backword saccades
% Get the list of files and initialize parameters
SEP = filesep;
path_name = strcat(path,[SEP '**' SEP '*' '.mat']);
f_names = dir(path_name);
len = length(f_names);
Back_final = cell(len,2);
Exit_time = cell(len,2);
Accuracy = cell(len,2);
Prob_exit = cell(len,2);
State_obs = cell(len,2);
Probability = cell(len,2);
Sacc_level = cell(len,2);
Sacc_total = cell(len,2);
% Loop over the input files
for p=1:length(f_names)
      % data file load
    data=load(strcat(f_names(p).folder,SEP,f_names(p).name));
    try 
        MDP = data.MDP;
    catch
        MDP = data.MDPsub;
    end
    Back_final{p,2} = HAI_backward_evaluation(MDP);
    [Exit_time{p,2},Accuracy{p,2},Prob_exit{p,2},State_obs{p,2},Probability{p,2}]= HAI_statistic_param_eval(MDP);
    [Sacc_level{p,2},Sacc_total{p,2}] = HAI_saccades_eval(MDP);
end
for i=1:len
Back_final{i,1} = f_names(i).name;
Exit_time{i,1} = f_names(i).name;
Accuracy{i,1} = f_names(i).name;
Prob_exit{i,1} = f_names(i).name;
State_obs{i,1} = f_names(i).name;
Probability{i,1} = f_names(i).name;
Sacc_total{i,1} = f_names(i).name;
end

%% mean and dev_st evaluation
[Time_over_max,Wrong_sent,Accuracy_final,back_level,Backw_statistic,Saccad_statistic,Prob_statistic] = HAI_result_eval(Back_final,Sacc_total,Exit_time,Accuracy,Prob_exit,Probability);


Result.Time_over_max = Time_over_max;      
Result.Wrong_sent = Wrong_sent;
Result.Accuracy_final = Accuracy_final;
Result.back_level = back_level;
Result.Backw_statistic = Backw_statistic;
Result.Saccad_statistic = Saccad_statistic;
Result.Prob_statistic = Prob_statistic;

Pre_Result.Back_final= Back_final;
Pre_Result.Sacc_total = Sacc_total;
Pre_Result.Exit_time = Exit_time;
Pre_Result.Accuracy = Accuracy;
Pre_Result.Prob_exit = Prob_exit;
Pre_Result.Probability = Probability;


