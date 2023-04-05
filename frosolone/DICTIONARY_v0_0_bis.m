function DICTIONARY = DICTIONARY_v0_0_bis

LETTERS{1,1}      = 'A';
LETTERS{2,1}      = 'B';
LETTERS{3,1}      = 'C';
LETTERS{4,1}      = 'D';
LETTERS{5,1}      = 'E';

% WORDS{1,1}        = [LETTERS{2},LETTERS{4},LETTERS{1},LETTERS{1}];
% WORDS{2,1}        = [LETTERS{2},LETTERS{3},LETTERS{1},LETTERS{1}];
% WORDS{3,1}        = [LETTERS{2},LETTERS{1},LETTERS{1},LETTERS{3}];

WORDS{1,1}        = {LETTERS{2},LETTERS{4},LETTERS{1},LETTERS{1}};
WORDS{2,1}        = {LETTERS{2},LETTERS{3},LETTERS{1},LETTERS{1}};
WORDS{3,1}        = {LETTERS{2},LETTERS{3},LETTERS{2},LETTERS{1}};

% for iw=1:length(WORDS); words{iw}=[WORDS{iw}{:}]; end  % redundat. Try to eliminate it

% words{1}        = [WORDS{1}{:}];
% words{2}        = [WORDS{2}{:}];
% words{3}        = [WORDS{3}{:}];

SENTENCES{1,1}       = {LETTERS{2},LETTERS{4},LETTERS{1},LETTERS{1}};
SENTENCES{2,1}      = {LETTERS{2},LETTERS{3},LETTERS{1},LETTERS{1}};
SENTENCES{3,1}   = {LETTERS{2},LETTERS{3},LETTERS{2},LETTERS{1}};



CLASSES{1}      = [1,2];                             % Eat
CLASSES{2}      = [3,4];                             % Drink
CLASSES{3}      = [5,6];                             % Sleep

CLASSNAMES{1}   = 'Unknown';
CLASSNAMES{2}   = 'Eat';
CLASSNAMES{3}   = 'Drink';
CLASSNAMES{4}   = 'Sleep';

LOCATIONS       = {'L1','L2','L3','L4'};
locations       = {'l1','l2','l3','l4'};

FEEDBACKS       = {'null','right','wrong'};


DICTIONARY.STATES       = {   WORDS,  SENTENCES};
DICTIONARY.OBS          = { LETTERS,  WORDS    };
DICTIONARY.CLASSES      = {      [],       []  };
DICTIONARY.StateNames   = {  'Word', 'Sentence'};
DICTIONARY.ObsNames     = {'Letter','Word'    };

DICTIONARY.Sentence     = SENTENCES;
DICTIONARY.Word         = WORDS;
DICTIONARY.Letter       = LETTERS;
DICTIONARY.NAME         = mfilename;