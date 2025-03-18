function   paths = HAI_LANGUAGE_pathsLoad(hai_dir)
% function paths = HAI_LANGUAGE_pathsLoad(hai_dir)
try 
    haidir=hai_dir;
catch
    haidir      = pwd;
end
FS          = filesep;
PS          = pathsep;
p           = '';
p           = [p, haidir FS 'BERT'         PS];
p           = [p, haidir FS 'chatGPT'      PS];
p           = [p, haidir FS 'DICTIONARY'   PS];
p           = [p, haidir FS 'HAI'          PS];
p           = [p, haidir FS 'HAI' FS 'haipms' PS];
p           = [p, haidir FS 'MAIN'         PS];
p           = [p, haidir FS 'PLOT'         PS];
p           = [p, haidir FS 'PLOT' FS 'plotpms' PS];
p           = [p, haidir FS 'SPM12_UTILS'  PS];
p           = [p, haidir FS 'TRACE'        PS];
p           = [p, haidir FS 'TREE'         PS];
p           = [p, haidir FS 'UTILITIES'    PS];
p           = [p, haidir FS 'VB'           PS];
p           = [p, haidir FS 'Simulation'   PS];

% p           = genpath (curdir);

addpath(p);
if nargout > 0
    paths   =p;
end
