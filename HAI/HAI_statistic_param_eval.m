%% Exit time, Response, Probability of Exit, Probability, and Real State VS...
% observation identification
function [Exit_time,Response,Prob_exit,State_obs,Probability]= HAI_statistic_param_eval(MDP)

    T_H = MDP.T;
    [v,m] = max(MDP.X{1, 1}(:,T_H));
    v1 = find(MDP.X{1, 1}(:,T_H)==m);
    if size(v1) ~=   1
        Res = 0;
    else
        if MDP.s(1,end) == m
            Res = 1;
        else
            Res = 0;
        end
    end
    Exit_time = T_H;
    Response = Res;
    Prob_exit = v;
    State_obs = [m, MDP.s(1,end)];
    Probability = MDP.X{1, 1}(:,T_H);