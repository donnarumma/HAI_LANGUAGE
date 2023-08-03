function   wordsplitted=DICTIONARY_hyphenate(word)
% function wordsplitted=DICTIONARY_hyphenate(word)
switch word
    case 'ACADEMIC'
        wordsplitted = {'AC','A','DEM','IC'};
    case 'ARRANGED'
        wordsplitted = {'AR','RANGED'};
    case 'AUTO'
        wordsplitted = {'AU','TO'};
    case 'BUTTED'
        wordsplitted = {'BUT','TED'};
    case 'BUTTEN'
        wordsplitted = {'BUT','TEN'};
    case 'HOERARCHIHCAL'
        wordsplitted = {'HO','ER','AR','CHI','CAL'};
    case 'LABRADOR'
        wordsplitted = {'LAB','RA','DOR'}; 
    case 'TATA'
        wordsplitted = {'TA','TA'};
    case 'MODAL'
        wordsplitted = {'MOD','AL'};
    case 'TAXA'
        wordsplitted = {'TA','XA'};
    case 'TAXI'            
        wordsplitted = {'TAX','I'};
    case 'TOURISTS'
        wordsplitted = {'TOUR','ISTS'};
    case 'TREVOR'
        wordsplitted = {'TREV','OR'};
    case 'TUNA'    
        wordsplitted = {'TU','NA'};
    case 'TUBA'   
        wordsplitted = {'TU','BA'};
    case 'UBER'            
        wordsplitted = {'U','BER'};
    case 'UNTU'            
        wordsplitted = {'UN','TO'};
    case 'UNDO'            
        wordsplitted = {'UN','DO'};
    case 'UCLA'            
        wordsplitted = {'U','CLA'};
    case 'VIVA'            
        wordsplitted = {'VI','VA'};
    case 'VIVO'            
        wordsplitted = {'VI','VO'};
    otherwise
        wordsplitted = hyphenate(word);
end

