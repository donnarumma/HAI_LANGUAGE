function   prompt= chatGPT_getPrompt(input_str,Nalts,HORIZON,idx)
% function prompt= chatGPT_getPrompt(input_str,Nalts,HORIZON,idx)

NumAltsStrs=num2str(Nalts);
HorStr=num2str(HORIZON);
ILen = length(strsplit(input_str,' '));
NnewWords = num2str(HORIZON-ILen);
switch idx
    case 0

        prompt = "Initial words: <<" + input_str + ">> " + newline + ...
                 "Sample starting from this input and using GPT capabilities to predict the following " + HorStr +  "words" +           newline + ...
                 "Report in a m code form suitable to be incorporated in matlab project:" +                                             newline + ...
                 "1) " + NumAltsStrs + " possible guessed sentences each compose of the initial words given plus the guessed words" +        newline + ...
                 "2) The probability of sampling the first new guessed word of the reported " + NumAltsStrs + " sentences. For identical guessed words the value must be the same." +    newline + ...
                 "Generate an m code suitabile for matlab for this code. " + newline + ...
                 "a) Put the sentences in a cell struct <<Sentences>> in incremental way <<Sentences{1}, Sentences{2}>>. " + newline + ...
                 "b) Similarly put the first guessed word in a cell struct <<Words>>" + newline + ...
                 "c) Put the probabilities in a double array <<Probs>>. remember: for each identical word the probability shoud be the same.";
    case 1
        if str2num(NnewWords)<2
            prompt = "Initial words: <<" + input_str + ">> " + newline + ...
            "Complete the sentence sampling " + NnewWords + " final word starting from this input and using GPT capabilities"  + newline + ...
         "1) Generate " + NumAltsStrs + " alternative text composed of at a total of " + NnewWords  + " word after the initial words in input (a total of  " + HorStr + " words for each text) in total. Thus, these alternatives must be composed of exact the initial words in input followed by the guessed word" + newline + ...
         "2) Generate m-code suitable for matlab putting these " + NumAltsStrs + " alternative texts in a cell array named <<SENTENCES>> and put this m-code between << and >>";
        elseif str2num(NnewWords)<5
            prompt = "Initial words: <<" + input_str + ">> " + newline + ...
            "Complete the sentence sampling " + NnewWords + " final words starting from this input and using GPT capabilities"  + newline + ...
         "1) Generate " + NumAltsStrs + " alternative text composed of at a total of " + NnewWords  + " words after the initial words in input (a total of  " + HorStr + " words for each text) in total. Thus, these alternatives must be composed of exact the initial words in input followed by the guessed " + NnewWords +" words" + newline + ...
         "2) Generate m-code suitable for matlab putting these " + NumAltsStrs + " alternative texts in a cell array named <<SENTENCES>> and put this m-code between << and >>";
        else
            prompt = "Initial words: <<" + input_str + ">> " + newline + ...
             "Continue the sentence sampling a possible next word starting from this input and using GPT capabilities"  + newline + ...
             "1) Guess " + NumAltsStrs + " alternative text of at a total of " + NnewWords  + " words after the initial words in input (a total of  " + HorStr + " words for each text) in total. Thus, these alternatives must be composed of exact the initial words in input followed by the guessed text" + newline + ...
             "2) Generate m-code suitable for matlab putting these " + NumAltsStrs + " alternative texts in a cell array named <<SENTENCES>> and put this m-code between << and >>";
        end
    case 2
        prompt = "Initial words: <<" + input_str + ">> " + newline + ...
         "Sample starting from this input and using GPT capabilities to predict next word" + " (imagine a total horizon of " + HorStr + " words" + newline + ...
         "1) Guess me " + NumAltsStrs + " alternative words after the initial words in input" +        newline + ...
         "2) The probability of sampling the guessed word you suggest." +    newline + ...
         "Generate an m code suitabile for matlab for this code. " + newline + ...
         "a) Similarly put the first guessed word in a cell struct <<Words>>" + newline + ...
         "b) Put the probabilities in a double array <<Probs>>.";
    case 3
        prompt = "Initial words: <<" + input_str + ">> " + newline + ...
         "Sample a possible next word starting from this input and using GPT capabilities" + " (imagine a total horizon of " + HorStr + " words" + newline + ...
         "1) Guess me " + NumAltsStrs + " alternative words after the initial words in input" +        newline + ...
         "2) The probability of sampling the guessed word you suggest." +    newline + ...
         "Generate an m code suitabile for matlab for this code. " + newline + ...
         "a) Similarly put the first guessed word in a cell struct <<Words>>" + newline + ...
         "b) Put the probabilities in a double array <<Probs>>.";
    case 4
        prompt = "Initial words: <<" + input_str + ">> " + newline + ...
         "Continue the sentences sampling a possible next word starting from this input and using GPT capabilities" + " (imagine a total horizon of " + HorStr + " words" + newline + ...
         "1) Guess me " + NumAltsStrs + " alternative words after the initial words in input" +        newline + ...
         "2) The probability of sampling the guessed word you suggest." +    newline + ...
         "Generate an m code suitabile for matlab that: " + newline + ...
         "a) Put the first guessed word in a cell struct <<Words>>" + newline + ...
         "b) Put the probabilities in a double array <<Probs>>.";
    case 5
        prompt = "Initial words: <<" + input_str + ">> " + newline + ...
         "Complete the sentence sampling a possible final word starting from this input and using GPT capabilities"  + newline + ...
         "1) Guess " + NumAltsStrs + " alternative text of at a total of " + NnewWords  + " words after the initial words in input (a total of  " + HorStr + " words for each text) in total. Thus, these alternatives must be composed of exact the initial words in input followed by the guessed text" + newline + ...
         "2) Generate m-code suitable for matlab putting these " + NumAltsStrs + " alternative texts in a cell array named <<SENTENCES>> and put this m-code between << and >>";

end
