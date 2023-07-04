function   [X,cmap_label] = PLOT_getSaccadesCOORD(MDP_STEPS,Nsteps,x,y,line_center,num_lett_pos,NUMBW_LINE)
% function [X,cmap_label] = PLOT_getSaccadesCOORD(MDP_STEPS,Nsteps,x,y,line_center,num_lett_pos,NUMBW_LINE)
X           =[];
cmap_label  =[];
for istep = 1:Nsteps
    MDP_lev3 = MDP_STEPS{istep};
    % Extract eye movements
    for ilev3 = 1:MDP_lev3.T         %   top  level (word)
        word_loc            = MDP_lev3.o(2,ilev3);
        n                   = ceil(word_loc./NUMBW_LINE)-1; % get last line number
        MDP_lev2            = MDP_lev3.mdp(ilev3);
        for ilev2 = 1:MDP_lev2.T     % middle level (syllale)
            MDP_lev1                = MDP_lev2.mdp(ilev2);
            syllable_loc            = MDP_lev2.o(2,ilev2);
            for ilev1 = 1:MDP_lev1.T % lowest level (letter)
                pos_lett            = num_lett_pos{word_loc,syllable_loc};
                letter_id           = MDP_lev1.o(1,ilev1);
                letter_loc          = MDP_lev1.o(2,ilev1);
                if letter_id == 1    % empty letter
                    if pos_lett(end)==0
                        last_loc        = find(cell2mat(cellfun(@(x)(x(1)~=0),num_lett_pos(word_loc,1:syllable_loc),'UniformOutput',false)),1,"last");
                        pos_lett        = num_lett_pos{word_loc,last_loc};
                    end
                    x_value         = x(pos_lett(end))+1;
                    % x_value         = x(round((letter_loc*length(pos_lett))/length(phr_sent_final{1,1})))+1;
                else 
                    try
                        x_value         = x(pos_lett(letter_loc));
                    catch
                        fprintf('ilev1%g\n',ilev1);
                    end
                end
                cmap_label(end+1)   = word_loc;%ilev3;
                try 
                    X(end + 1,:)        = y{n+1}(word_loc-(NUMBW_LINE*n),:) + x_value;
                catch
                    fprintf('Lev3:%g Lev2%g Lev1%g',ilev3,ilev2,ilev1);
                end
                X(end,2)            = (line_center(n+1,2)+line_center(n+1,1))/2;
            end
        end
    end
end
%cmap_label
