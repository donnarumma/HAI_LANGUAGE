function x=extendConverged (x,itrial,ie,Total)
% function x=extendConverged (x,itrial,ie,Total)

[~, Nx]=size(x{itrial}); % epochs per nhidden
% px=x{1}(ie,:);

expansion=Total-size(x{itrial}{ie,1},1);

if expansion>0
    for ix=1:Nx
        % [px{ix};repmat(px{ix}(end),expansion,1)];
        x{itrial}{ie,ix}=[x{itrial}{ie,ix}; repmat(x{itrial}{ie,ix}(end),expansion,1)];
    end
end


