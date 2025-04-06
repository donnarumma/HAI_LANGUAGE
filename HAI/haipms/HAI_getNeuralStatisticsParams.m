function   par = HAI_getNeuralStatisticsParams(parSource)
% function par = HAI_getNeuralStatisticsParams(parSource)
par.exec        = true;
par.factor      = 1;
par.fakeneuron  = 0;
par.killNNeurons= 0;
par.maxVBxn     = 0;
try
    fnames=fieldnames(parSource);
    for in=1:length(fnames)
        par.(fnames{in})=parSource.(fnames{in});
    end
catch
end
end