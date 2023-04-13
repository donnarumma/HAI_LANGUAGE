function EP=HAI_getLocationPriors(location,Nlocations,params)

EP=ones(Nlocations,1);
EP=EP./sum(EP);

if params.location_priors==1 %% Poisson location priors
    EP=HAI_getPoissonLocationPriors(location,Nlocations,params.LocPrLambda);   
end