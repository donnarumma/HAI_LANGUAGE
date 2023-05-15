function    A=HAI_getAContext(OBS,STATES,CLASSES,NLocations,val)
%function   A=HAI_getAContext(OBS,STATES,CLASSES,NLocations,val)
% function  A=HAI_getAContext(LETTERS,WORDS,CLASSES,NLocations,val)
% Level likelihood p(obs|S)
% val(1) good value on p(o{1}|s)
% val(2) good value on p(o{2}|s)
NFeedbacks  = 3; % null right wrong
No          = [   length(OBS),NLocations, NFeedbacks]; 
Ns          = [length(STATES),NLocations, length(CLASSES)+1];
Ng          = length(No); % number of   obs factors = 2:   obs level and location
% Nf          = length(Ns); % number of state factors = 2: state level and location

antival     = (1-val)./(No-1);
iclasses    = 1:length(CLASSES);
            
A           = cell(1,Ng);                             %% initialize p(obs|states)
for ig=1:Ng
    A{ig}   = ones([No(ig),Ns])*antival(ig);
end
for f1 = 1:Ns(1)
    STATE = STATES{f1};
    for f2 = 1:Ns(2)
        for f3 = 1:Ns(3)
            %==============================================================         
            % saccade to cue location
            %----------------------------------------------------------
            for iw=1:No(1) % number of OBS splitting
            %   cmp               = min(strcmp(STATE{f2},OBS{iw}));
                cmp               = all(strcmp(STATE{f2},OBS{iw}));
                A{1}(iw,f1,f2,f3) = cmp*val(1)+(1-cmp)*antival(1);
            
            end
            % A{2} Words Location: {'Location1',...,'Location4'}
            %----------------------------------------------------------
            A{2}(f2,f1,f2,f3) = 1*val(2);
            % A{3} feedback: {'undecided','right','wrong'}
            %--------------------------------------------------------------
            c=nan(size(CLASSES));
            for ic=1:length(CLASSES)
                c(ic)= any(ismember(CLASSES{ic},f1));
            end        
%           eat     = any(ismember([1 2],f1));
%           drink   = any(ismember([3 4],f1));
%           sleep   = any(ismember([5 6],f1));  
            % reports r1,r2,r3 mutual exclusive
            
            r1              = (f3 == 1);                    % undecided
            r2              = 0;               % right
            r3              = 0;               % wrong
            
            
            for ic=1:length(CLASSES)
                r2  = r2 | (f3==(ic+1) & c(ic));
                ifc  = ismember(iclasses,ic);
                r3  = r3 | ( ismember(f3-1,iclasses(~ifc)) & c(ic));
            end
%             three classes             
%             r3              = (f3 == 3 & c(1)) | (f3 == 4 & c(1)) | ...
%                               (f3 == 2 & c(2)) | (f3 == 4 & c(2)) | ...
%                               (f3 == 2 & c(3)) | (f3 == 3 & c(3)); % wrong


%             r2               = (f3 == 2 & c(1)) | (f3 == 3 & c(2)) | (f3 == 4 & c(3)); % right
%             r3               = (f3 == 3 & c(1)) | (f3 == 2 & c(2)) | (f3 == 3 & c(3)) | ...
%                                (f3 == 2 & c(3)) | (f3 == 4 & c(1)) | (f3 == 4 & c(2)); % wrong
            
            A{3}(1,f1,f2,f3) = r1*val(3)+(1-r1)*antival(3); % undecided
            A{3}(2,f1,f2,f3) = r2*val(3)+(1-r2)*antival(3); % right
            A{3}(3,f1,f2,f3) = r3*val(3)+(1-r3)*antival(3); % wrong
        end
    end
end