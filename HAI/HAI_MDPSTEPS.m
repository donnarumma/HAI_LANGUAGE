function   [STEPS]=HAI_MDPSTEPS(MDP)
% function [STEPS]=HAI_MDPSTEPS(MDP)
% Ne = size(MDP.xn{1},4);      % number of epochs
STEPS = size(MDP.xn{1},1);      % number of time beans
% STEPS=Ne*Nx;