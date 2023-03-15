function    [params, noisedescription]=HAI_getParams(index,dictionary)
%% function [params, noisedescription]=HAI_getParams(index,dictionary)

    params                              = HAI_getDefaultParams(dictionary);
    noisedescription                    = '';
    params.irng                         = 10; %'default';
    DICTIONARY                          = params.DICTIONARY();
switch index
    case  0
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).jump                = 0;  % no jump in location
        params.level(2).umode               = 0;  % Friston matrix no jump
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};

        params.level(2).chi                 = []; % no sentence exit when no more in doubt
        noisedescription                   = 'default';
    case  1
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        noisedescription                   = 'No Noise';

        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

    case  2
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).umode              = 1; % deprecated
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};

        noisedescription                   = 'No Noise - jump mode';
    case  3
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.4,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 


        noisedescription                   = 'letter recognition noise';
    case  4
        %% SUBJECT noise on location transition
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.4,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.4];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'location transition noise';
    case  5
        %% SUBJECT letter recognition and location transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.4];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.4];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'letter recognition and location transition noise';
    case  6
        %% SUBJECT letter and location recognition and location transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.4,0.4];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.4];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump               = 0;
        params.level(2).umode              = 0;

        noisedescription                   = 'letter and location recognition and location transition noise';
    case  7
        %% SUBJECT 6 letter, word and location recognition and location transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.4,0.4];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.4];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.4,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'letter, word and location recognition and location transition noise';
    case  8
        %% SUBJECT letter, word, location, Location recognition and location, Location transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.4,0.4];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.4];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.4,0.7,0.5];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.7,0.5];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'letter, word, location, Location recognition and location, Location transition noise';
    case  9
        %% SUBJECT word transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.2,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'word transition noise';
     case 10
         %% SUBJECT 9 word and sentences transition noise
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.1,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.01,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;        
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        params.level(2).jump                = 0;        % get "stay-next"   transition matrix
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 

        noisedescription                   = 'word and sentences transition noise';
    case 11
        %% SUBJECT word transition noise, jump mode
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.3,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.0,0.0,0.0];  % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).umode              = 1; % deprecated
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};
        
        noisedescription                   = 'word transition noise, jump mode';
    case 12
        %% SUBJECT word transition noise, jump mode
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.0,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.25,0.0,0.0]; % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).umode              = 1; % deprecated
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};

        noisedescription                   = 'sentences transition noise, jump mode';
    case 13 
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];      % noise on [letter  ,location]          recognition 
        params.level(1).statenoise   = [0.1,0.0];      % noise on [word    ,location]           transition 
        params.level(2).obsnoise        = [0.0,0.0,0.0];  % noise on [word    ,Location,  report] recognition 
        params.level(2).statenoise   = [0.01,0.0,0.0]; % noise on [sentence,Location, context]  transition
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1; % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).umode              = 1; % deprecated
        params.level(2).CLASSES            = DICTIONARY.CLASSES{2};

        noisedescription                   = 'word and sentences transition noise, jump mode';
    case 14 
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.15,0.0];     % noise on [word    ,location]      transition 
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(2).statenoise   = [0.0,0.0];     % noise on [sentence,Location]      transition

%         params.level(2).create              = str2func('createLevel2_v7');
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).CLASSES            = [];
        params.level(2).umode              =  0;        % get only "stay-report" transition matrix (Friston default) 
noisedescription                   = 'word transition noise, jump mode, (no context)';
    case 15 
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.2,0.0];     % noise on [word    ,location]      transition 
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(2).statenoise   = [0.012,0.0];     % noise on [sentence,Location]      transition

        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1; % modify B matrix
        params.level(2).CLASSES            = [];
        params.level(2).umode              = 0;

        noisedescription                   = 'word and sentences transition noise, jump mode, (no context)';
    case 16
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.0,0.0];     % noise on [word    ,location]      transition 
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(2).statenoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
        params.level(2).CLASSES            = [];
        params.level(2).chi                = 1/64;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        params.level(2).umode              = 0;

        noisedescription                   = 'no noise, jump mode, (no context)';
    case 17
% noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
%         params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
%         params.level(1).statenoise   = [0,0.0];     % noise on [word    ,location]      transition 
        params.level(1).chi                = 1/8;
        
%         params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(2).statenoise   = [0.0,0.0];    % noise on [sentence,Location]      transition
%         params.level(2).CLASSES            = [];
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;

        noisedescription                   = 'no noise, jump mode, (no context)';
    case 18
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise      = [0,0.0];     % noise on [word    ,location]      transition 
        params.level(1).chi                = 1/8;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(2).statenoise   = [0.1,0.0];    % noise on [sentence,Location]      transition
        params.level(2).statenoise      = [0.0,0.0];    % noise on [sentence,Location]      transition
        params.level(2).CLASSES            = [];
%         params.level(2).chi                = 1/64;
%         params.level(2).chi                = 1/64;
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;

        noisedescription                   = 'no noise, jump mode, (no context)';
    case 19
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.1,0.0];     % noise on [word    ,location]      transition 
        params.level(1).chi                = 1/8;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(2).statenoise   = [0.1,0.0];    % noise on [sentence,Location]      transition
        params.level(2).statenoise   = [0.0,0.0];    % noise on [sentence,Location]      transition
        params.level(2).CLASSES            = [];
%         params.level(2).chi                = 1/64;
%         params.level(2).chi                = 1/64;
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).jump               = 1;
        
        noisedescription                   = 'word noise, jump mode, (no context)';
    case 20
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statenoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        
        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statenoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
       
        noisedescription                   = '3 levels, jump mode, (no context)';
    case 21
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statenoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statenoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statenoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 levels, jump mode, (no context)';

end
