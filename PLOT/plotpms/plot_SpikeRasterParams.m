function   par = plot_SpikeRasterParams(parSource)
% function par = plot_SpikeRasterParams(parSource)
par.exec        = true;
par.hfig        = [];
par.lw          = 2;
par.zero_time   = 0;
par.isms        = false;
par.fs          = 12;
par.SpikeHeight = 0.4;
par.th          = 0;
par.ifmean      = 0;
par.freqTheta   = 8;
par.cmapsfunc   = str2func('cmapfunc_black');

try
    fnames=fieldnames(parSource);
    for in=1:length(fnames)
        par.(fnames{in})=parSource.(fnames{in});
    end
catch
end
end