function DICTIONARY = DICTIONARY_v2


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

LETTERS         =cell(0,0);

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

WORDS           =cell(0,0);
WORDS{end+1,1}  ={LETTERS{iL.B},LETTERS{iL.E},LETTERS{iL.T},LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% BETTER;
WORDS{end+1,1}  ={LETTERS{iL.C},LETTERS{iL.I},LETTERS{iL.R},LETTERS{iL.C},LETTERS{iL.L},LETTERS{iL.E}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% CIRCLE;
WORDS{end+1,1}  ={LETTERS{iL.C},LETTERS{iL.I},LETTERS{iL.R},LETTERS{iL.C},LETTERS{iL.U},LETTERS{iL.S}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% CIRCUS;
WORDS{end+1,1}  ={LETTERS{iL.F},LETTERS{iL.I},LETTERS{iL.N},LETTERS{iL.G},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% FINGER;
WORDS{end+1,1}  ={LETTERS{iL.G},LETTERS{iL.A},LETTERS{iL.R},LETTERS{iL.D},LETTERS{iL.E},LETTERS{iL.N}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% GARDEN;
WORDS{end+1,1}  ={LETTERS{iL.L},LETTERS{iL.A},LETTERS{iL.T},LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% LATTER;
WORDS{end+1,1}  ={LETTERS{iL.L},LETTERS{iL.I},LETTERS{iL.T},LETTERS{iL.T},LETTERS{iL.L},LETTERS{iL.E}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% LITTLE;
WORDS{end+1,1}  ={LETTERS{iL.P},LETTERS{iL.U},LETTERS{iL.R},LETTERS{iL.P},LETTERS{iL.L},LETTERS{iL.E}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% PURPLE;
WORDS{end+1,1}  ={LETTERS{iL.R},LETTERS{iL.U},LETTERS{iL.B},LETTERS{iL.B},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% RUBBER;
WORDS{end+1,1}  ={LETTERS{iL.B},LETTERS{iL.U},LETTERS{iL.T},LETTERS{iL.T},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% BETTER;
WORDS{end+1,1}  ={LETTERS{iL.P},LETTERS{iL.R},LETTERS{iL.O},LETTERS{iL.P},LETTERS{iL.E},LETTERS{iL.R}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% PROPER;
WORDS{end+1,1}  ={LETTERS{iL.G},LETTERS{iL.L},LETTERS{iL.O},LETTERS{iL.B},LETTERS{iL.A},LETTERS{iL.L}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% PROPER;
WORDS{end+1,1}  ={LETTERS{iL.B},LETTERS{iL.U},LETTERS{iL.T},LETTERS{iL.T},LETTERS{iL.O},LETTERS{iL.N}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% BUTTON;
WORDS{end+1,1}  ={LETTERS{iL.C},LETTERS{iL.A},LETTERS{iL.S},LETTERS{iL.T},LETTERS{iL.L},LETTERS{iL.E}}; iW.(HAI_retrieveLevel(WORDS{end}))=length(WORDS);% CASTLE;

SENTENCES           =cell(0,0);
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.CIRCLE},WORDS{iW.RUBBER},WORDS{iW.GARDEN}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.PURPLE},WORDS{iW.FINGER},WORDS{iW.GARDEN}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LATTER},WORDS{iW.RUBBER},WORDS{iW.GARDEN}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LATTER},WORDS{iW.FINGER},WORDS{iW.GARDEN}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LATTER},WORDS{iW.FINGER},WORDS{iW.CIRCLE}}; % better circle rubber garden
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.RUBBER},WORDS{iW.LITTLE},WORDS{iW.GARDEN}}; % better circle rubber garden
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
SENTENCES{end+1,1}  ={WORDS{iW.BETTER},WORDS{iW.LITTLE},WORDS{iW.RUBBER},WORDS{iW.CASTLE}}; % better little rubber circle

for iL=1:length(LETTERS)
    fprintf('LETTER(%g)=%s\n',iL,HAI_retrieveLevel(LETTERS{iL}));
end
for iW=1:length(WORDS)
    fprintf('WORD(%g)=%s\n',iW,HAI_retrieveLevel(WORDS{iW}));
end
for iSen=1:length(SENTENCES)
    fprintf('SENTENCE(%g)=%s\n',iSen,HAI_retrieveLevel(SENTENCES{iSen}));
end


DICTIONARY.STATES       = {   WORDS,  SENTENCES};
DICTIONARY.OBS          = { LETTERS,  WORDS    };
DICTIONARY.CLASSES      = {        [],       []};
DICTIONARY.StateNames   = {  'Word', 'Sentence'};
DICTIONARY.ObsNames     = {'Letter','Word'    };

DICTIONARY.Sentence     = SENTENCES;
DICTIONARY.Word         = WORDS;
DICTIONARY.Letter       = LETTERS;
DICTIONARY.NAME         = mfilename;