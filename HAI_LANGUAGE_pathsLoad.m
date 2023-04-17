function   paths = HAI_LANGUAGE_pathsLoad()
% function paths = HAI_LANGUAGE_pathsLoad()
curdir      = cd;
p           = genpath (curdir);

addpath(p);
if nargout > 0
    paths   =p;
end
