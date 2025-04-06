function    A=HAI_getA_Likelihood(    OBS,STATES,CLASSES,NLocations,params)%val,maskval,addUnk)
% function  A=HAI_getA_Likelihood(    OBS,STATES,CLASSES,NLocations,val,maskval,addUnk)
% function  A=HAI_getA_Likelihood(    OBS,STATES,CLASSES,NLocations,val,maskval,addUnk)
% function  A=HAI_getA_Likelihood(LETTERS, WORDS,CLASSES,NLocations,val,maskval,addUnk)
% Level likelihood p(obs|S)
% val(1) good value on p(o{1}|s)
% val(2) good value on p(o{2}|s)
maskval = params.maskval;
addUnk  = params.unknown;
val     = 1 - params.obsnoise; % observation vals (oval)
if ~isempty(CLASSES)
    NFeedbacks  = 2+addUnk;     % number of answers: if 3: {unknown, right, wrong} if 2 {right, wrong}
else
    NFeedbacks  = [];
end
No          = [   length(OBS),NLocations, NFeedbacks]; 
Ns          = [length(STATES),NLocations, length(CLASSES)+addUnk];
Ns          = Ns(Ns>0);
Ng          = length(No);   % number of   obs factors = 2:   obs level and location
% Nf          = length(Ns); % number of state factors = 2: state level and location

iclasses    = 1:length(CLASSES);

% antival     = (1-val)./(No-1);
switch maskval
    case 0 % uniform
        antival     = (1-val)./(No-1);
        % mask        = ones(Ns(1),Ns(1));
        mask        = ones(No(1),Ns(1));
    case 1 % rotational-> works in case No(1)==Ns(1)
        antival     = (1-val)./2;
        mask        = tril(ones(Ns(1),Ns(1)),1).*~tril(ones(Ns(1),Ns(1)),-2);
        mask(1,end) = 1;
        mask(end,1) = 1;
end

A           = cell(1,Ng);                             %% initialize p(obs|states)
for iv=1:length(antival)
    if ~antival(iv)
        antival(iv)=eps;
    end
end
for ig=1:Ng
    A{ig}   = ones([No(ig),Ns])*antival(ig);
end

r           = false(2+addUnk,1); % answer vector initialization
if length(Ns)<3; Ns(3)=1; end
for f1 = 1:Ns(1)            % loop on the structures
    STATE = STATES{f1};
    for f2 = 1:Ns(2)        % loop on the locations
        for f3 = 1:Ns(3)    % loop on the contexts
            if params.SaccadesLocation %|| ~empty(params.plan2D)
                %==============================================================         
                % saccade to cue location
                %----------------------------------------------------------
                for il=1:No(1) % number of OBS splitting
                    try
                        cmp   = isequal(HAI_retrieveLevel(STATE{f2},''),HAI_retrieveLevel(OBS{il},''));
                    catch
                        pause;
                    end
                    % cmp   = all(strcmp(STATE{f2},OBS{iw}));
                    A{1}(il,f1,f2,f3) = mask(il,f1)*cmp*val(1)+(1-cmp)*antival(1);            
                end
                %==============================================================         
                % A{2} Location: {'Location1',...,'LocationN'}
                %----------------------------------------------------------
                A{2}(f2,f1,f2,f3) = 1*val(2);
            elseif ~isempty(params.plan2D)
                % cmp                = isequal(HAI_retrieveLevel(STATE{1},''),HAI_retrieveLevel(OBS{f2},''));
                A{1}(f1,f1,f2,f3)  = 1*val(1); %% mask?? mask(f1,f2)*
                
                A{2}(f2,f1,f2,f3)  = 1*val(2);
            else % planning states and topologies
                %
                cmp1               = isequal(HAI_retrieveLevel(STATE{1},''),HAI_retrieveLevel(OBS{f2},''));
                cmp2               = f2 == f1;
                cmp                = cmp1 && cmp2;
                
                % A{1}(f1,f1,f2,f3)  = cmp*val(1)+(1-cmp)*antival(1); %% mask?? mask(f1,f2)*
                A{1}(f1,f1,f2,f3)  = cmp*val(1)+(1-cmp)*antival(1); %% mask?? mask(f1,f2)*
                % allNs2             = 1:Ns(2);
                % idx2               = allNs2(~ismember(allNs2,f1));
                % A{1}(f1,:,idx2,f3) = 1;
                
                A{2}(f2,f1,f2,f3)  = cmp*val(2)+(1-cmp)*antival(2);
                % allNs1             = 1:Ns(1);
                % idx1               = allNs1(~ismember(allNs1,f1));
                % A{2}(f2,:,idx1,f3) = 1;
            end
            %==============================================================         
            % A{3} feedback: {'undecided','right','wrong'}
            %--------------------------------------------------------------
            c=nan(size(CLASSES));
            if ~isempty(c)
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
                % three classes example             
                % r3         = (f3 == 3 & c(1)) | (f3 == 4 & c(1)) | ...
                %              (f3 == 2 & c(2)) | (f3 == 4 & c(2)) | ...
                %              (f3 == 2 & c(3)) | (f3 == 3 & c(3)); % wrong
    
                % r2         = (f3 == 2 & c(1)) | (f3 == 3 & c(2)) | (f3 == 4 & c(3)); % right
                % r3         = (f3 == 3 & c(1)) | (f3 == 2 & c(2)) | (f3 == 3 & c(3)) | ...
                %              (f3 == 2 & c(3)) | (f3 == 4 & c(1)) | (f3 == 4 & c(2)); % wrong
                
                for ic=1:length(r)
                    A{3}(ic,f1,f2,f3) = r(ic)*val(3)+(1-r(ic))*antival(3);
                end
                % A{3}(1,f1,f2,f3) = r(1)*val(3)+(1-r(1))*antival(3); % undecided
                % A{3}(2,f1,f2,f3) = r(2)*val(3)+(1-r(2))*antival(3); % right
                % A{3}(3,f1,f2,f3) = r(3)*val(3)+(1-r(3))*antival(3); % wrong
            end
        end
    end
end