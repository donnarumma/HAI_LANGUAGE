function   wordsplitted=DICTIONARY_hyphenate(word)
% function wordsplitted=DICTIONARY_hyphenate(word)
switch word
    case 'ARRANGED'
        wordsplitted = {'AR','RANGED'};
    case 'LABRADOR'
        wordsplitted = {'LAB','RA','DOR'}; 
    case 'TOURISTS'
        wordsplitted = {'TOUR','ISTS'};
    case 'TREVOR'
        wordsplitted = {'TREV','OR'};
    case 'AUTO'
        wordsplitted = {'AU','TO'};
    case 'TATA'
        wordsplitted = {'TA','TA'};
    case 'TAXA'
        wordsplitted = {'TA','XA'};
    case 'TUNA'    
        wordsplitted = {'TU','NA'};
    case 'TUBA'   
        wordsplitted = {'TU','BA'};
    case 'TAXI'            
        wordsplitted = {'TAX','I'};
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

