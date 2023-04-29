function   [X,cmap_label] = PLOT_getSaccadesCOORD(MDP_STEPS,Nsteps,x,y,line_center,num_lett_pos,phr_sent_final,NUMBW_LINE)
% function [X,cmap_label] = PLOT_getSaccadesCOORD(MDP_STEPS,Nsteps,x,y,line_center,num_lett_pos,phr_sent_final,NUMBW_LINE)
X           =[];
cmap_label  =[];
for istep = 1:Nsteps
    MDP_lev3 = MDP_STEPS{istep};
    % Extract eye movements
    for ilev3 = 1:MDP_lev3.T         %   top  level (word)
        word_loc            = MDP_lev3.o(2,ilev3);
        n                   = floor(word_loc./(NUMBW_LINE+1)); % get the line number
        MDP_lev2            = MDP_lev3.mdp(ilev3);
        for ilev2 = 1:MDP_lev2.T     % middle level (syllale)
            MDP_lev1                = MDP_lev2.mdp(ilev2);
            syllable_loc            = MDP_lev2.o(2,ilev2);
            for ilev1 = 1:MDP_lev1.T % lowest level (letter)
                pos_lett            = num_lett_pos{word_loc,syllable_loc};
                letter_id           = MDP_lev1.o(1,ilev1);
                letter_loc          = MDP_lev1.o(2,ilev1);
                if letter_id == 1    % empty letter
                    x_value         = x(round((letter_loc*length(pos_lett))/length(phr_sent_final{1,1})))+1;
                else            
                    x_value         = x(pos_lett(letter_loc));
                end
                cmap_label(end+1)   = word_loc;%ilev3;  
                X(end + 1,:)        = y{n+1}(word_loc-(NUMBW_LINE*n),:) + x_value;           
                X(end,2)            = (line_center(n+1,2)+line_center(n+1,1))/2;
            end
        end
    end
end
%cmap_label
