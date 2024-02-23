function    [params, noisedescription]=HAI_getParams_bis(index,dictionary)
%% function [params, noisedescription]=HAI_getParams_bis(index,dictionary)

    params                              = HAI_getDefaultParams(dictionary);
    noisedescription                    = '';
    params.irng                         = 10; %'default';
    DICTIONARY                          = params.DICTIONARY();
switch index
    
case 10
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NO NOISE, 4 letters, jump mode, (no context)';

case 11
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 1 (syllable transition noise), 4 letters, jump mode, (no context)';
case 12
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 2 (word transition noise), 4 letters, jump mode, (no context)';
case 13
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 1 and 2 (syllable adn word transition noise), 4 letters, jump mode, (no context)';

case 20
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        
        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NO NOISE, 8 letters, jump mode, (no context)';

case 21
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 1 (syllable transition noise), 8 letters, jump mode, (no context)';
case 22
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 2 (word transition noise), 8 letters, jump mode, (no context)';
case 23
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT               = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT               = 8;
%         params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
%         params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
%         params.level(3).chi                = 1/8;
%         params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
%        
        noisedescription                   = '2 level, NOISE on LEVEL 1 and 2 (syllable adn word transition noise), 8 letters, jump mode, (no context)';

case 30
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT             = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT             = 8;

        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(3).maxT             = 8;
        noisedescription                   = '3 levels, NO NOISE, jump mode, (no context)';   
case 31
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT             = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT             = 8;

        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(3).maxT             = 8;
        noisedescription                   = '3 levels, NOISE LEVEL 1, jump mode, (no context)';  
case 32
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT             = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT             = 8;

        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statesnoise   = [0.0,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(3).maxT             = 8;
        noisedescription                   = '3 levels, NOISE LEVEL 2, jump mode, (no context)';
case 33
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.0,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT             = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.0,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT             = 8;

        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statesnoise   = [0.15,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(3).maxT             = 8;
        noisedescription                   = '3 levels, NOISE LEVEL 3, jump mode, (no context),';
case 34
        % noise on likelihood  p(   obs|state)
        % noise on transitions p(S(t+1)| S(t))
        params.level(1).obsnoise        = [0.0,0.0];     % noise on [letter  ,location]      recognition 
        params.level(1).statesnoise   = [0.15,0.0];     % noise on [syllable,location]      transition 
        params.level(1).chi                = 1/8;
        params.level(1).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(1).maxT             = 8;

        params.level(2).obsnoise        = [0.0,0.0];     % noise on [syllable,Location]      recognition 
        params.level(2).statesnoise   = [0.15,0.0];     % noise on [word    ,Location]      transition
        params.level(2).chi                = 1/8;
        params.level(2).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(2).maxT             = 8;

        params.level(3).obsnoise        = [0.0,0.0];     % noise on [word    ,Location]      recognition 
        params.level(3).statesnoise   = [0.15,0.0];     % noise on [sentence,Location]      transition
        params.level(3).chi                = 1/8;
        params.level(3).factor             = 1;             % exit factor on upper level 2: I am sure of the sentence;
        params.level(3).maxT             = 8;
        noisedescription                   = '3 levels, NOISE LEVEL 1,2 and 3,jump mode, (no context)';
end