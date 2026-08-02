function root_dir = HAI_testsRoot()
% HAI_testsRoot  Canonical directory for HAI_LANGUAGE simulation outputs.
%
% Keeping the path in one function prevents paper scripts from diverging
% between relative paths, /tmp, and legacy HAI_LANGUAGE locations.

root_dir = fullfile(getenv('HOME'), 'TESTS', 'HAI_LANGUAGE');
end
