function deltas=HAI_stretched(MDP)
%function newsteps=HAI_stretched(MDP)
probLevel=HAI_getTimeProb(MDP);
exectime=probLevel{MDP.level}(:,2);   % sub-level exec time ?
deltas=diff([0;exectime]);
% newsteps=round(MDP.VBNi*deltas/min(deltas));