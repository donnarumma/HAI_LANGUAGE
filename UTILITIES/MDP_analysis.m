%% This function extract all MDP from one path and evaluate intresting parameters
function Result = MDP_analysis(path)
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

Result.Back_final= Back_final;
Result.Sacc_total = Sacc_total;
Result.Exit_time = Exit_time;
Result.Accuracy = Accuracy;
Result.Prob_exit = Prob_exit;
Result.Probability = Probability;


