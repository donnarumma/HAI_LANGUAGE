function MAIN_HAI_DICTIONARY_v2
%  'Level 2, Time 0:
%      Sentence(1):BETTER CIRCLE RUBBER GARDEN
%      Sentence(2):PURPLE RUBBER FINGER CIRCLE
%      Sentence(3):LITTLE PURPLE CIRCLE GARDEN
%      Sentence(4):BETTER LITTLE RUBBER CIRCLE
%      Sentence(5):LITTLE PURPLE RUBBER FINGER
%      Sentence(6):PURPLE RUBBER LITTLE FINGER
%      Sentence(7):LATTER PURPLE CIRCLE GARDEN
%      Sentence(8):LITTLE PURPLE RUBBER GARDEN
%      WordLocation(1):WoL1
%      WordLocation(2):WoL2
%      WordLocation(3):WoL3
%      WordLocation(4):WoL4
%      
%      Level 1, Time 0:
%      Word(1):BETTER
%      Word(2):CIRCLE
%      Word(3):FINGER
%      Word(4):GARDEN
%      Word(5):LATTER
%      Word(6):LITTLE
%      Word(7):PURPLE
%      Word(8):RUBBER
%      LetterLocation(1):LeL1
%      LetterLocation(2):LeL2
%      LetterLocation(3):LeL3
%      LetterLocation(4):LeL4
%      LetterLocation(5):LeL5
%      LetterLocation(6):LeL6

% LETTER(1)=A
% LETTER(2)=B
% LETTER(3)=C
% LETTER(4)=D
% LETTER(5)=E
% LETTER(6)=F
% LETTER(7)=G
% LETTER(8)=I
% LETTER(9)=L
% LETTER(10)=N
% LETTER(11)=O
% LETTER(12)=P
% LETTER(13)=R
% LETTER(14)=S
% LETTER(15)=T
% LETTER(16)=U

% WORD(1)=BETTER
% WORD(2)=CIRCLE
% WORD(3)=CIRCUS
% WORD(4)=FINGER
% WORD(5)=GARDEN
% WORD(6)=LATTER
% WORD(7)=LITTLE
% WORD(8)=PURPLE
% WORD(9)=RUBBER
% WORD(10)=BUTTER
% WORD(11)=PROPER
% WORD(12)=GLOBAL
% WORD(13)=BUTTON
% WORD(14)=CASTLE

% SENTENCE(1)=BETTER CIRCLE RUBBER GARDEN 
% SENTENCE(2)=PURPLE RUBBER FINGER GARDEN 
% SENTENCE(3)=LITTLE PURPLE CIRCLE GARDEN 
% SENTENCE(4)=BETTER LITTLE RUBBER CIRCLE 
% SENTENCE(5)=BUTTON LITTLE RUBBER CIRCLE 
% SENTENCE(6)=BETTER LITTLE RUBBER CIRCUS 
% SENTENCE(7)=LITTLE PURPLE RUBBER FINGER 
% SENTENCE(8)=PURPLE RUBBER LITTLE FINGER 
% SENTENCE(9)=LATTER PURPLE CIRCLE GARDEN 
% SENTENCE(10)=LITTLE PURPLE RUBBER GARDEN 
% SENTENCE(11)=BUTTER LITTLE RUBBER CIRCLE 
% SENTENCE(12)=BETTER CIRCLE RUBBER GLOBAL 
% SENTENCE(13)=LITTLE PURPLE RUBBER GLOBAL 
% SENTENCE(14)=BETTER LATTER RUBBER CIRCLE 
% SENTENCE(15)=BUTTON LITTLE RUBBER CASTLE 
% SENTENCE(16)=BETTER LITTLE RUBBER CASTLE 
% ------------------------------------------- %
% LEVEL 1       
%             letter  x  word   x   location
% size(A{1})=   16         14           6
%            location x  word   x   location
% size(A{2})=    6         14           6 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear MDPsub;
rtmode                             = 0;  % 1 reaction time, 0 recognition steps
% idsentence                         = 8;
idsentence                         = 4;
irng                               = 10; %'default';
% imode                              = 0; OLD COMMAND TO RETURN TO FRISTON MODE

% paramsmodes                        = [1,2,9:14];
% paramsmodes                        = [14,15];
% paramsmodes                        = 15;
% paramsmodes                        = [1,2];
% paramsmodes                        = 14;
% paramsmodes                        = [12:15];
% paramsmodes                        = 16;
% idsentences                        = [4,  4];
paramsmodes                        =  17:19;
% sub                                 17 18 19
idsentences(paramsmodes)           = [16, 4, 4];
NSubs                              = length(paramsmodes);
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedescription                   = cell(NSubs,1);
dictionary                         = 'DICTIONARY_v2';
for iSub=1:NSubs
     %% get params with the selected dictionary
    [par_series{iSub},noisedescription{iSub}] = HAI_getParams(paramsmodes(iSub),dictionary);   
    par_series{iSub}                          = HAI_initialiseParams(par_series{iSub});
    %% set seed
    par_series{iSub}.irng                     = irng;
    %% set higher level to true sentence
    maxT                                      = par_series{iSub}.level(end).maxT;
    par_series{iSub}.level(end).s(1,:)        = ones(1,maxT)*idsentences(paramsmodes(iSub));          % initial      sentence state

    %% run the inference
    MDPsub{iSub}                              =HAI_RUN(par_series{iSub},dictionary);
    fprintf('Ended computation for SubjectID%g\n',paramsmodes(iSub));
%     pause;
end
SEP = filesep;%'//';
root_dir =[SEP 'tmp' SEP 'HAI_LANGUAGE_TESTS' SEP];
save_dir =[root_dir  SEP          dictionary  SEP];

PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,'',save_dir)
save([save_dir SEP 'MDPsub'],'MDPsub');

return