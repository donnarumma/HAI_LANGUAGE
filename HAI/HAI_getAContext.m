function    A=HAI_getAContext(OBS,STATES,CLASSES,NLocations,val,addUnk)
%function   A=HAI_getAContext(OBS,STATES,CLASSES,NLocations,val,addUnk)
% function  A=HAI_getAContext(LETTERS,WORDS,CLASSES,NLocations,val)
% Level likelihood p(obs|S)
% val(1) good value on p(o{1}|s)
% val(2) good value on p(o{2}|s)
NFeedbacks  = 2+addUnk;     % number of answers: if 3: {unknown, right, wrong} if 2 {right, wrong}
No          = [   length(OBS),NLocations, NFeedbacks]; 
Ns          = [length(STATES),NLocations, length(CLASSES)+addUnk];
Ng          = length(No);   % number of   obs factors = 2:   obs level and location
% Nf          = length(Ns); % number of state factors = 2: state level and location

antival     = (1-val)./(No-1);
iclasses    = 1:length(CLASSES);
            
A           = cell(1,Ng);                             %% initialize p(obs|states)
for ig=1:Ng
    A{ig}   = ones([No(ig),Ns])*antival(ig);
end

r           = false(2+addUnk,1); % answer vector initialization

for f1 = 1:Ns(1)            % loop on the structures
    STATE = STATES{f1};
    for f2 = 1:Ns(2)        % loop on the locations
        for f3 = 1:Ns(3)    % loop on the contexts
            %==============================================================         
            % saccade to cue location
            %----------------------------------------------------------
            for iw=1:No(1) % number of OBS splitting
                cmp   = isequal(HAI_retrieveLevel(STATE{f2},''),HAI_retrieveLevel(OBS{iw},''));
                % cmp   = all(strcmp(STATE{f2},OBS{iw}));
                A{1}(iw,f1,f2,f3) = cmp*val(1)+(1-cmp)*antival(1);            
            end
            % A{2} Location: {'Location1',...,'LocationN'}
            %----------------------------------------------------------
            A{2}(f2,f1,f2,f3) = 1*val(2);
            % A{3} feedback: {'undecided','right','wrong'}
            %--------------------------------------------------------------
            c=nan(size(CLASSES));
            for ic=1:length(CLASSES)
                c(ic)= any(ismember(CLASSES{ic},f1));
            end        
            % reports r1,r2,r3 mutual exclusive
            if addUnk
                r(1)          = (f3 == 1);       % undecided
            end
            r(end-1)          = 0;               % right
            r(end)            = 0;               % wrong
            
            
            for ic=1:length(CLASSES)
                r(end-1) = r(end-1) | (f3==(ic+addUnk) & c(ic));
                ifc      = ismember(iclasses,ic);
                r(end)   = r(end) | ( ismember(f3-addUnk,iclasses(~ifc)) & c(ic));
            end
%             three classes example             
%             r3              = (f3 == 3 & c(1)) | (f3 == 4 & c(1)) | ...
%                               (f3 == 2 & c(2)) | (f3 == 4 & c(2)) | ...
%                               (f3 == 2 & c(3)) | (f3 == 3 & c(3)); % wrong

%             r2               = (f3 == 2 & c(1)) | (f3 == 3 & c(2)) | (f3 == 4 & c(3)); % right
%             r3               = (f3 == 3 & c(1)) | (f3 == 2 & c(2)) | (f3 == 3 & c(3)) | ...
%                                (f3 == 2 & c(3)) | (f3 == 4 & c(1)) | (f3 == 4 & c(2)); % wrong
            
            for ic=1:length(r)
                A{3}(ic,f1,f2,f3) = r(ic)*val(3)+(1-r(ic))*antival(3);
            end
            % A{3}(1,f1,f2,f3) = r(1)*val(3)+(1-r(1))*antival(3); % undecided
            % A{3}(2,f1,f2,f3) = r(2)*val(3)+(1-r(2))*antival(3); % right
            % A{3}(3,f1,f2,f3) = r(3)*val(3)+(1-r(3))*antival(3); % wrong
        end
    end
end