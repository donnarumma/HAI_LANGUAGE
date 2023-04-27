%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
## Hierarchical Active Inference for Language
Nested hierarchies of structures using Active inference 
for language recognition and reading 
## Description
Each level of the hierarchy has a default structure if the lowest observable is a letter o(1)=letter  a simple hierarchy can be described
level 1 
two factor:
states  = [composition of letters (e.g. word), locations of letters in the word]
obs     = [ letter,  locations of letters in the word]
than level 2
states  = [composition of words (e.g. sentence), locations of words in the sentence]
obs     = [ word,  locations of words in the sentence]

Extending the composition and the meaning of the composition it is possible to iterate this structure on N-levels

It is, also, possible to add classes for each level, that gives a context for each state recognized.
For example for level 2 becomes:
states  = [sentence, locations of words in the sentence, context]
obs     = [    word, locations of words in the sentence,  report]

## Getting started
Type HAI_LANGUAGE_pathsLoad; in main the directory to add necessary subpaths.
then choose one of the main in directory "MAINS" to see a demonstration of code features

## Code

### (1) HAI_LANGUAGE_DICTIONARY_v0_sample_main.m
simple example with a simple dictionary
2-level hierarchy 
level 1 
states  = [    word, locations of letters in the word]
obs     = [  letter, locations of letters in the word]
level 2
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

DICTIONARY: Simple dictionary of 6 words composed by A B C D 

### (2) HAI_LANGUAGE_DICTIONARY_v1_sample_main.m
2-level hierarchy 
level 1 
states  = [    word, locations of letters in the word]
obs     = [  letter, locations of letters in the word]
level 2
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

DICTIONARY: Simple dictonary of English words (two syllable words of six letters)

### (3) HAI_LANGUAGE_DICTIONARY_v2_sample_main.m
3-level hierarchy 
level 1 
states  = [syllable, locations of  letters in the syllable]
obs     = [  letter, locations of  letters in the syllable]
level 2
states  = [    word, locations of syllable in the sentence]
obs     = [syllable, locations of syllable in the sentence]
level 2
states  = [sentence, locations of   word   in the sentence]
obs     = [    word, locations of   word   in the sentence]

DICTIONARY: Simple dictonary of English words (two syllable words of six letters)

### (4) HAI_LANGUAGE_DICTIONARY_v3_sample_main.m
2-level hierarchy 
level 1 
states  = [syllable, locations of  letters in the syllable]
obs     = [  letter, locations of  letters in the syllable]
level 2
states  = [    word, locations of syllable in the sentence]
obs     = [syllable, locations of syllable in the sentence]

DICTIONARY: Simple dictionary of English words (two syllable words of six letters)

### TRANSFORMES IN THE LOOP

### (5) HAI_LANGUAGE_BERT_LOOP_sample_01_main.m, 
three level structure, Dictionary provided by BERT

Read the produced BERT sentence 'THIS PAPER IS ALSO MENTIONED IN THE FAMOUS ENGLISH HISTORICAL NOVEL BY SIR ROBERT DE LA HAY'

level 1 
states  = [syllable, locations of letters in the syllable]
obs     = [  letter, locations of letters in the syllable]
level 2
states  = [    word, locations of syllables in the word]
obs     = [syllable, locations of syllables in the word]
level 3
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

### (6) HAI_LANGUAGE_BERT_LOOP_sample_02_main.m, 
Same as previous but given a context
"We present a novel computational model that uses hierarchical active inference to simulate the reading process and eye movements during reading." 
read the BERT produced sentence:

THE COMPUTATIONAL MODEL IS ABLE TO PREDICT A TIME HORIZON FOR READING DURING A GIVEN TIME OR PLACE PERIOD


### (7) HAI_LANGUAGE_BERT_LOOP_sample_03_main.m

Loop with BERT reading a sentence that has a word (BUTTER) that BERT does not provide


LOOP of HAI Code on a DICTIONARY predicted by BERT
https://it.mathworks.com/matlabcentral/fileexchange/107375-transformer-models?s_tid=FX_rc3_behav
add the corresponding path to use BERT model
git clone https://github.com/matlab-deep-learning/transformer-models 

### (8) main_chatGPT_SampleSentence.m

provided an API-KEY.txt for OPEN-AI chatGPT, given the same context of (6)
"We present a novel computational model that uses hierarchical active inference to simulate the reading process and eye movements during reading." 

produce a random sentence:
e.g. THIS MODEL HAS BEEN DESIGNED TO ENABLE THE ACCOMMODATION OF A COMPREHENSIVE SET OF ADAPTIVE BEHAVIORS TO ACHIEVE BEST ACCURACY

## Authors and acknowledgment
Francesco Donnaruma	francesco.donnarumma@istc.cnr.it

Mirco Frosolone     mirco.frosolone@istc.cnr.it

Giovanni Pezzulo	giovanni.pezzulo@istc.cnr.it

COgnition iN ActioN Laboratory (CONAN)
https://www.istc.cnr.it/it/group/conan-0

## License
This code is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 1, or (at your option)
any later version.

This code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details. A copy of the GNU 
General Public License can be obtained from the 
Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.