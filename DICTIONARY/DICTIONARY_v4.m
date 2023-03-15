function DICTIONARY=DICTIONARY_v4

% 
% mu-sic
% du-ty
% stu-pid
% ta-ble
% or-der
% wa-ter
% hap-py
% gar-den

% bet
% ter
% cir
% cle
% rub
% ber
% gar
% den

% SYLLABLES
% better circle rubber garden
% purple rubber finger circle
% little purple circle garden
% better little rubber circle
% little purple rubber finger
% purple rubber little finger 
% latter purple circle garden


% better
% circle
% rubber
% garden
% purple
% finger
% little
% WORDS       =cell(0,0);
% WORDS{end+1}='BETTER';
% WORDS{end+1}='CIRCLE';
% WORDS{end+1}='RUBBER';
% WORDS{end+1}='GARDEN';
% WORDS{end+1}='PURPLE';
% WORDS{end+1}='FINGER';
% WORDS{end+1}='LITTLE';

LETTERS         =cell(0,0); clear iL iS iW; 

LETTERS{end+1,1}='A'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='B'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='C'; iL.(LETTERS{end})=length(LETTERS);  
LETTERS{end+1,1}='D'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='E'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='F'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='G'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='I'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='L'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='N'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='O'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='P'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='R'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='S'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='T'; iL.(LETTERS{end})=length(LETTERS); 
LETTERS{end+1,1}='U'; iL.(LETTERS{end})=length(LETTERS); 

SYLLABLES       =cell(0,0);
D               ='';
SYLLABLES{end+1,1}={LETTERS{iL.B},LETTERS{iL.A},LETTERS{iL.L},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.B},LETTERS{iL.E},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.B},LETTERS{iL.E},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.B},LETTERS{iL.U},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.C},LETTERS{iL.A},LETTERS{iL.S},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.C},LETTERS{iL.I},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.C},LETTERS{iL.L},LETTERS{iL.E},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.C},LETTERS{iL.U},LETTERS{iL.S},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.D},LETTERS{iL.E},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.F},LETTERS{iL.I},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.G},LETTERS{iL.E},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.G},LETTERS{iL.A},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.G},LETTERS{iL.L},LETTERS{iL.O},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.L},LETTERS{iL.A},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.L},LETTERS{iL.E},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.L},LETTERS{iL.I},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.L},LETTERS{iL.I},LETTERS{iL.S},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.L},LETTERS{iL.U},LETTERS{iL.T},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.P},LETTERS{iL.E},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.P},LETTERS{iL.L},LETTERS{iL.E},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.P},LETTERS{iL.R},LETTERS{iL.O},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.P},LETTERS{iL.U},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.R},LETTERS{iL.U},LETTERS{iL.B},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.S},LETTERS{iL.O},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.L},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.R},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.S},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.I},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.L},LETTERS{iL.E},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);
SYLLABLES{end+1,1}={LETTERS{iL.T},LETTERS{iL.O},LETTERS{iL.N},}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);


WORDS           =cell(0,0);
WORDS{end+1,1}  ={SYLLABLES{iS.BET},SYLLABLES{iS.TER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% BETTER;
WORDS{end+1,1}  ={SYLLABLES{iS.BUT},SYLLABLES{iS.TER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% BUTTER;
WORDS{end+1,1}  ={SYLLABLES{iS.BUT},SYLLABLES{iS.TON}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% BUTTON;
WORDS{end+1,1}  ={SYLLABLES{iS.CIR},SYLLABLES{iS.CLE}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% CIRCLE;
WORDS{end+1,1}  ={SYLLABLES{iS.CIR},SYLLABLES{iS.CUS}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% CIRCUS;
WORDS{end+1,1}  ={SYLLABLES{iS.CAS},SYLLABLES{iS.TLE}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% CASTLE;
WORDS{end+1,1}  ={SYLLABLES{iS.FIN},SYLLABLES{iS.GER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% FINGER;
WORDS{end+1,1}  ={SYLLABLES{iS.GAR},SYLLABLES{iS.DEN}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% GARDEN;
WORDS{end+1,1}  ={SYLLABLES{iS.GLO},SYLLABLES{iS.BAL}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% GLOBAL;
WORDS{end+1,1}  ={SYLLABLES{iS.LAT},SYLLABLES{iS.TER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% LATTER;
WORDS{end+1,1}  ={SYLLABLES{iS.LIT},SYLLABLES{iS.TLE}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% LITTLE;
WORDS{end+1,1}  ={SYLLABLES{iS.LIT},SYLLABLES{iS.TEL}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% LITTLE;
WORDS{end+1,1}  ={SYLLABLES{iS.LIT},SYLLABLES{iS.TES}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% LITTLE;
WORDS{end+1,1}  ={SYLLABLES{iS.LIT},SYLLABLES{iS.SON}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% LITTLE;
WORDS{end+1,1}  ={SYLLABLES{iS.LUT},SYLLABLES{iS.TER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% BUTTER;
WORDS{end+1,1}  ={SYLLABLES{iS.PUR},SYLLABLES{iS.PLE}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% PURPLE;
WORDS{end+1,1}  ={SYLLABLES{iS.RUB},SYLLABLES{iS.BER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% RUBBER;
WORDS{end+1,1}  ={SYLLABLES{iS.PRO},SYLLABLES{iS.PER}}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);% PROPER;

SENTENCES           =cell(0,0);
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.CIRCLE},WORDS{iW.RUBBER},WORDS{iW.GARDEN}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.PURPLE},WORDS{iW.RUBBER},WORDS{iW.FINGER},WORDS{iW.GARDEN}}; % purple rubber finger circle
SENTENCES{end+1,1}  ={WORDS{iW.LITTLE},WORDS{iW.PURPLE},WORDS{iW.CIRCLE},WORDS{iW.GARDEN}}; % little purple circle garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CIRCLE}}; % better little rubber circle
SENTENCES{end+1,1}  ={WORDS{iW.BUTTON},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CIRCLE}}; % button little rubber circle
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CIRCUS}}; % better little rubber circus
SENTENCES{end+1,1}  ={WORDS{iW.LITTLE},WORDS{iW.PURPLE},WORDS{iW.RUBBER},WORDS{iW.FINGER}}; % little purple rubber finger
SENTENCES{end+1,1}  ={WORDS{iW.PURPLE},WORDS{iW.RUBBER},WORDS{iW.LITTLE},WORDS{iW.FINGER}}; % purple rubber little finger
SENTENCES{end+1,1}  ={WORDS{iW.LATTER},WORDS{iW.PURPLE},WORDS{iW.CIRCLE},WORDS{iW.GARDEN}}; % latter purple circle garden
SENTENCES{end+1,1}  ={WORDS{iW.LITTLE},WORDS{iW.PURPLE},WORDS{iW.RUBBER},WORDS{iW.GARDEN}}; % little purple rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BUTTER},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CIRCLE}}; % butter little rubber circle
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.CIRCLE},WORDS{iW.RUBBER},WORDS{iW.GLOBAL}}; % better circle rubber global
SENTENCES{end+1,1}  ={WORDS{iW.LITTLE},WORDS{iW.PURPLE},WORDS{iW.RUBBER},WORDS{iW.GLOBAL}}; % little purple rubber global
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LATTER},WORDS{iW.RUBBER},WORDS{iW.CIRCLE}}; % better latter rubber circle
SENTENCES{end+1,1}  ={WORDS{iW.BUTTON},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CASTLE}}; % button little rubber castle

% LITTER={SYLLABLES{iS.LIT},SYLLABLES{iS.TER}};
% SENTENCES{end+1,1}  ={WORDS{iW.BETTER},LITTER,WORDS{iW.RUBBER},WORDS{iW.CASTLE}}; % better litter rubber circle

if 1
    for iLetter=1:length(LETTERS)
        fprintf('LETTER(%g)=%s\n',iLetter,HAI_retrieveLevel(LETTERS{iLetter},D));
    end
    for iSyllable=1:length(SYLLABLES)
        fprintf('SYLLABLE(%g)=%s\n',iSyllable,HAI_retrieveLevel(SYLLABLES{iSyllable},D));
    end
    for iword=1:length(WORDS)
        fprintf('WORD(%g)=%s\n',iword,HAI_retrieveLevel(WORDS{iword},D));
    end
    D=' ';
    for iSentence=1:length(SENTENCES)
        fprintf('SENTENCE(%g)=%s\n',iSentence,HAI_retrieveLevel(SENTENCES{iSentence},D));
    end
end
DICTIONARY.STATES       = { SYLLABLES,      WORDS, SENTENCES};
DICTIONARY.OBS          = {   LETTERS,  SYLLABLES,     WORDS};
DICTIONARY.CLASSES      = {        [],         [],        []};
DICTIONARY.StateNames   = { 'Syllable',    'Word','Sentence'};
DICTIONARY.ObsNames     = {   'Letter','Syllable',    'Word'};

DICTIONARY.STATES       = { SYLLABLES,      WORDS};
DICTIONARY.OBS          = {   LETTERS,  SYLLABLES};
DICTIONARY.CLASSES      = {        [],         []};
DICTIONARY.StateNames   = { 'Syllable',    'Word'};
DICTIONARY.ObsNames     = {   'Letter','Syllable'};

DICTIONARY.Sentence     = SENTENCES; 
DICTIONARY.Word         = WORDS;
DICTIONARY.iW           = iW;
DICTIONARY.iS           = iS;
DICTIONARY.iL           = iL;
DICTIONARY.Syllable     = SYLLABLES;
DICTIONARY.Letter       = LETTERS;
DICTIONARY.NAME         = mfilename;