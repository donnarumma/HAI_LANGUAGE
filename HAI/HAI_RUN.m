function   MDP=HAI_RUN(params,dictionary)
% function MDP=HAI_RUN(params,dictionary)
% info: spm_MDP_VB_X_tutorial_debug_v5 reduced code of
% spm_MDP_VB_X_tutorial_debug_v0. Some functions disabled but is intented
% to work exactly the same of v0, with the options of not resetting time
% steps (Ht=1); spm_MDP_VB_X_tutorial_debug_v0 should behave exactly 
% as spm_MDP_VB_X_tutorial. NO WARRANTY GIVEN :)

defaultParams=HAI_DefaultParams(dictionary);
try
    params  = recopyFields(params,defaultParams);
catch
    params  = defaultParams;
end
rng(params.irng);

MDPsub =[];
NLevels=length(params.level);

for iLev=1:NLevels
    params.level(iLev).MDP  = MDPsub;
    mdp                     = params.level(iLev).create(params.level(iLev));    
    mdp.s                   = params.level(iLev).s;%
    MDPsub                  = mdp;
end

%% MDP simulation
if params.debugmode
    description = params.getDescription(params);
    idfile      = num2str(getTimeStamp);
    save_dir    = './TRACE/traces/';    % trace dir
    filename    = sprintf('%s %s_%s.txt',save_dir,description,idfile);
    diary (filename);
    TRACE_printMDP(mdp);
end 
MDP      = params.spm_MDP_VB_H(mdp,params);
if params.debugmode
    diary('off');
    fprintf('Written diary %s\n',filename);
end
return
