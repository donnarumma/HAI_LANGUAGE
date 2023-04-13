% function HAI_LANGUAGE_DICTIONARY_v3_sample_main
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

% SYLLABLE(1)=BAL
% SYLLABLE(2)=BET
% SYLLABLE(3)=BER
% SYLLABLE(4)=BUT
% SYLLABLE(5)=CAS
% SYLLABLE(6)=CIR
% SYLLABLE(7)=CLE
% SYLLABLE(8)=CUS
% SYLLABLE(9)=DEN
% SYLLABLE(10)=FIN
% SYLLABLE(11)=GER
% SYLLABLE(12)=GAR
% SYLLABLE(13)=GLO
% SYLLABLE(14)=LAT
% SYLLABLE(15)=LIT
% SYLLABLE(16)=PER
% SYLLABLE(17)=PLE
% SYLLABLE(18)=PRO
% SYLLABLE(19)=PUR
% SYLLABLE(20)=RUB
% SYLLABLE(21)=TER
% SYLLABLE(22)=TLE
% SYLLABLE(23)=TON

% WORD(1)=BETTER
% WORD(2)=BUTTER
% WORD(3)=BUTTON
% WORD(4)=CIRCLE
% WORD(5)=CIRCUS
% WORD(6)=CASTLE
% WORD(7)=FINGER
% WORD(8)=GARDEN
% WORD(9)=GLOBAL
% WORD(10)=LATTER
% WORD(11)=LITTLE
% WORD(12)=PURPLE
% WORD(13)=RUBBER
% WORD(14)=PROPER

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
% 
% LEVEL 1 ----------------------------------- %
%              letter    syllable    location %
%                 16   x    14     x    2     %
%             location   syllable    location %
%                  2   x    14     x    2     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%

clear MDPsub;
rtmode                             = 0;     % 1 reaction time, 0 recognition steps
irng                               = 2005;  % 'default';

paramsmodes                        = [20,22,23]; 
idsentences(paramsmodes)           = [ 4, 4, 4];
NSubs                              = length(paramsmodes);
par_series                         = cell(NSubs,1);
noisedescr                         = cell(NSubs,1);
MDPsub                             = cell(NSubs,1);
noisedescription                   = cell(NSubs,1);
dictionary                         = 'DICTIONARY_v3';
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
    MDPsub{iSub}                              = HAI_RUN(par_series{iSub},dictionary);
  
%     par_series{iSub}.idhighest                = idsentence;
%     MDPsub{iSub}=Dyslexia_RUN(par_series{iSub},dictionary);
    fprintf('Ended computation for SubjectID%g\n',paramsmodes(iSub));
%     pause;
end

SEP ='//';
root_dir =[SEP 'tmp' SEP 'HAI_LANGUAGE' SEP];
save_dir =[root_dir  SEP    dictionary  SEP];

PLOT_BAR_modes(MDPsub,noisedescription,dictionary,paramsmodes,rtmode,'',save_dir)
save([save_dir SEP 'MDPsub'],'MDPsub');

return
