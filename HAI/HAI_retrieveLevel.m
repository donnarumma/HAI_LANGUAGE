function   ltoken = HAI_retrieveLevel(Stoken,SpaceToken)
% function ltoken = HAI_retrieveLevel(Stoken,SpaceToken)
try
    D=SpaceToken;
catch
    D=' ';
end
if isempty(D)
    D='';
end
if      isempty(Stoken)
    ltoken='';
elseif ~iscell(Stoken)
    ltoken=strtrim(Stoken);
elseif ~iscell(Stoken{1})
    ltoken=strtrim([Stoken{:}]);
else
    ltoken=strtrim([HAI_retrieveLevel(Stoken{1}, D(2:end)), D(~isempty(D)), HAI_retrieveLevel(Stoken(2:end),D)]);
end
return;