function   paths = HAI_LANGUAGE_pathsLoad(hai_dir)
% function paths = HAI_LANGUAGE_pathsLoad(hai_dir)
try 
    haidir=hai_dir;
catch
    haidir      = pwd;
end
SEP         = filesep;
D           = pathsep;
p           = '';
p           = [p, haidir SEP 'BERT'         D];
p           = [p, haidir SEP 'chatGPT'      D];
p           = [p, haidir SEP 'DICTIONARY'   D];
p           = [p, haidir SEP 'HAI'          D];
p           = [p, haidir SEP 'MAIN'         D];
p           = [p, haidir SEP 'PLOT'         D];
p           = [p, haidir SEP 'SPM12_UTILS'  D];
p           = [p, haidir SEP 'TRACE'        D];
p           = [p, haidir SEP 'TREE'         D];
p           = [p, haidir SEP 'UTILITIES'    D];
p           = [p, haidir SEP 'VB'           D];
p           = [p, haidir SEP 'Simulation'   D];

% p           = genpath (curdir);

addpath(p);
if nargout > 0
    paths   =p;
end
