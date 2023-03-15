function    A=HAI_getA(OBS,STATES,NLocations,val)
% function  A=HAI_getA(LETTERS,    WORDS,NLocations,val)  I level
% function  A=HAI_getA(  WORDS,SENTENCES,NLocations,val) II level
% Level likelihood p(obs|S)
% val(1) good value on p(o{1}|s)
% val(2) good value on p(o{2}|s)
No  = [   length(OBS),NLocations];
Ns  = [length(STATES),NLocations];
Ng  = length(No); % number of   obs factors = 2:   obs level and location
% Nf  = length(Ns); % number of state factors = 2: state level and location

antival     = (1-val)./(No-1);
A           = cell(1,Ng);   %% initialize p(obs|states)
for ig=1:Ng
    A{ig}   = ones([No(ig),Ns])*antival(ig);
end

for f1 = 1:Ns(1)            %% loop on words
    STATE = STATES{f1};
    for f2 = 1:Ns(2)        %% loop on locations
        % location of cues for this hidden state
        %----------------------------------------------------------
        %==========================================================            
        % saccade to cue location
        %----------------------------------------------------------
        for il=1:length(OBS)
            cmp             = isequal(HAI_retrieveLevel(STATE{f2},''),HAI_retrieveLevel(OBS{il},''));
            A{1}(il,f1,f2)  = cmp*val(1)+(1-cmp)*antival(1);
        end
        % A{2} where: {1,...,NLocations}
        %----------------------------------------------------------
        A{2}(f2,f1,f2)      = 1*val(2);
    end
end
