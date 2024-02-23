function   paths = HAI_LANGUAGE_pathsLoad()
% function paths = HAI_LANGUAGE_pathsLoad()
curdir      = pwd;
SEP         = filesep;
D           = pathsep;
p           = '';
p           = [p, curdir SEP 'BERT'         D];
p           = [p, curdir SEP 'chatGPT'      D];
p           = [p, curdir SEP 'DICTIONARY'   D];
p           = [p, curdir SEP 'HAI'          D];
p           = [p, curdir SEP 'MAIN'         D];
p           = [p, curdir SEP 'PLOT'         D];
p           = [p, curdir SEP 'SPM12_UTILS'  D];
p           = [p, curdir SEP 'TRACE'        D];
p           = [p, curdir SEP 'TREE'         D];
p           = [p, curdir SEP 'UTILITIES'    D];
p           = [p, curdir SEP 'VB'           D];

% p           = genpath (curdir);

addpath(p);
if nargout > 0
    paths   =p;
end
