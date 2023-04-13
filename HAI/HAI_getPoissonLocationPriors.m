function   [EP,OP]=HAI_getPoissonLocationPriors(location,Nlocations,lambda)
% function [EP,OP]=HAI_getPoissonLocationPriors(location,Nlocations,lambda)

X           = 0:1000;
% lambda      = params.LocPrLambda;%4;

% th          = params.LocPrTh;   %=0.01;
Y           = poisspdf(X,lambda);
% [~,indM]    = max(Y);
FY          = Y(Y>0.01);
[~,iM]      = min(abs(diff(FY)));
indM        = find(Y==FY(iM),1);
% inds        = Y>th;
%% select maximum on next first (word) location
X           = X-X(indM);

inds        = X>(-Nlocations) & X<2*Nlocations;
Y           = Y(inds);
X           = X(inds);        
OP.X        = X;
OP.Y        = Y;

% suppress the current location
Ysupp       =Y;
Ysupp(X==0) =0;
% all support. Renormalize
Ysupp       =Ysupp./sum(Ysupp);
OP.Ysupp    =Ysupp;
% on current location
XW          =X+location;
YW          =Ysupp;

YW          =YW./sum(YW);
onloc       =XW<=Nlocations & XW>0;
EP          =YW(onloc)';
