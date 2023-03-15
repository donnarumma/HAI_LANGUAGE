function   paths = pathsLoad_HAI_LANGUAGE()
% function paths = pathsLoad_HAI_LANGUAGE()
curdir      = cd;
p           = genpath (curdir);

addpath(p);
if nargout > 0
    paths   =p;
end
