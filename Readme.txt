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

# (1) HAI_LANGUAGE_DICTIONARY_v0_sample_main.m
simple example with a simple dictionary
2-level hierarchy 
level 1 
states  = [    word, locations of letters in the word]
obs     = [  letter, locations of letters in the word]
level 2
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

DICTIONARY: Simple dictionary of 6 words composed by A B C D 

# (2) HAI_LANGUAGE_DICTIONARY_v1_sample_main.m
2-level hierarchy 
level 1 
states  = [    word, locations of letters in the word]
obs     = [  letter, locations of letters in the word]
level 2
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

DICTIONARY: Simple dictonary of English words (two syllable words of six letters)

# (3) HAI_LANGUAGE_DICTIONARY_v2_sample_main.m
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

# (4) HAI_LANGUAGE_DICTIONARY_v3_sample_main.m
2-level hierarchy 
level 1 
states  = [syllable, locations of  letters in the syllable]
obs     = [  letter, locations of  letters in the syllable]
level 2
states  = [    word, locations of syllable in the sentence]
obs     = [syllable, locations of syllable in the sentence]

DICTIONARY: Simple dictonary of English words (two syllable words of six letters)

# (5) HAI_LANGUAGE_BERT_LOOP_sample_01.m, HAI_LANGUAGE_BERT_LOOP_sample_02.m

LOOP of HAI Code on a DICTIONARY predicted by BERT
https://it.mathworks.com/matlabcentral/fileexchange/107375-transformer-models?s_tid=FX_rc3_behav
add the corresponding path to use BERT model
git clone https://github.com/matlab-deep-learning/transformer-models 

level 1 
states  = [    word, locations of letters in the word]
obs     = [  letter, locations of letters in the word]
level 2
states  = [sentence, locations of words in the sentence]
obs     = [    word, locations of words in the sentence]

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

##











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# InterActive Inference

Active Inference code for Multi Agent Interactions. 
Examples code for Joint Actions.


## Name
Interactive inference: a multi-agent model of cooperative joint actions

see https://doi.org/10.48550/arXiv.2210.13113

## Description
A novel computational model of multi-agent, cooperative joint actions that is grounded in the cognitive framework of active inference. The model assumes that to solve a joint task, such as pressing together a red or blue button, two (or more) agents engage in a process of interactive inference. Each agent maintains probabilistic beliefs about the goal of the joint task (e.g., should we press the red or blue button?) and updates them by observing the other agent's movements, while in turn selecting movements that make his own intentions legible and easy to infer by the other agent (i.e., sensorimotor communication). Over time, the interactive inference aligns both the beliefs and the behavioral strategies of the agents, hence ensuring the success of the joint action.

## Getting started

Type pathsLoad_Djoint in main the directory to add necessary subpaths.
then choose one of the main in directory "mains" to see a demonstration of code features


## Code

In directory mains:  

(1) main_Djoint_OPEN_A15050_A25050_TEST100

Test Name Code: OPEN_A15050_A25050
Demonstration of a Follower-Follower interaction with INTERACTIVE INFERENCE
Agent1 FOLLOWER - Agent2 FOLLOWER
Default: 100 repetitions of 30 Trials 

(2) main_Djoint_OPEN_LF_A15050S_A25050_TEST100
Test Name Code: OPEN_LF_A15050S_A25050
Demonstration of a Leader Follower interaction with INTERACTIVE INFERENCE
Agent1: LEADER - Agent2: FOLLOWER
Joint goal: Button: Agent1: BLUE button - Agent2 BLUE button (MIRROR-IMITATIVE)
Default: 100 repetitions of 30 Trials 

(3) main_Djoint_OPEN_LF_A15050C_A25050_TEST100
Test Name Code: OPEN_LF_A15050C_A25050
Demonstration of a Leader Follower interaction with INTERACTIVE INFERENCE
Agent1: LEADER - Agent2: FOLLOWER
Joint goal: Button: Agent1: RED button - Agent2 RED button (MIRROR-IMITATIVE)
Default: 100 repetitions of 30 Trials 

(4) main_Djoint_OPEN_A15050_A25050_RL_TEST100
Test Name Code: OPEN_A15050_A25050_RL
Demonstration of a Follower-Follower interaction, Reinforcement Learning simulation
Agent1 FOLLOWER - Agent2 FOLLOWER
Default: 100 repetitions of 30 Trials 


(5) main_Djoint_OPEN_LF_A15050C_A25050_KL_TEST100
Test Name Code: OPEN_A15050C_A25050_KL
Demonstration of a Leader Follower interaction only Kullback-Leibler (KL) optimization
Agent1: LEADER - Agent2: FOLLOWER
Joint goal: Button: Agent1: RED button - Agent2 RED button (MIRROR-IMITATIVE)
Default: 100 repetitions of 30 Trials 

Note: these tests save all the results in a default directory (). 
This parameter and the others can be fine tuned in the parameter structure "params"
e.g.:
params.default_dir: new directory test name	 				(default is "~/tmp/DJOINT/")
params.custom_maze: set new custom maze function 				(default is @custom_simmetric_maze_open)
params.Repetitions: set the number of repetitions				(default is 100)
params.N 	  : set the number of trials, i.e. N interaction between agents (default is 30)

see the structure params and the mains to modify and test other execution options

Once a test is run, you can also visualize a sample Joint Execution:
e.g.;
test_name     ='OPEN_A15050_A25050';
test_dir      ='~/tmp/DJOINT/tests_djoint/';
indRepetition =100;  % default repetitions are 100:199
indTrial      =1;
showExecution(test_name,indRepetition,indTrial,test_dir);


In directory run: InterActive Inference simulation

Joint Active Inference function: parun_JointTask 
recalling in turn single Active Inference function: spm_MDP_GAME_parsim


In directory models: 

functions to build the custom environment and the likelihood and priors of the agents in it
  

In directory sim: 

functions to set parameters and execute the simulations (required by mains)


In directory show: 

functions that help to visualize the custom environment 


In directory aux: 

auxiliary custom functions


In directory utilities: general utility functions


## Authors and acknowledgment
Domenico Maisto 	domenico.maisto@cnr.it
Francesco Donnaruma	francesco.donnarumma@istc.cnr.it
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

##