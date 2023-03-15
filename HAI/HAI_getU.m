function U=HAI_getU(Umode,CLASSES)
switch Umode
    case 0
        % time,k,policy
        U(1,1,:)  = [1 2 1]';           % move to successive word and report unknown (case no jump)
        for iC=1:length(CLASSES)
            U(1,iC+1,:)=[1,1,iC+1]';    % stay on current word and report class iC
        end
%         U(1,2,:)  = [1 1 2]';           % stay on current word and report   Eat
%         U(1,3,:)  = [1 1 3]';           % stay on current word and report Drink
%         U(1,4,:)  = [1 1 4]';           % stay on current word and report Sleep
    case 1 % deprecated
        U(1,1,:)  = [1 2 1]';           % move to word 2 and report unknown
        U(1,2,:)  = [1 1 2]';           % stay on current word and report   Eat
        U(1,3,:)  = [1 1 3]';           % stay on current word and report Drink
        U(1,4,:)  = [1 1 4]';           % stay on current word and report Sleep
        U(1,5,:)  = [1 3 1]';           % move to word 3
        U(1,6,:)  = [1 4 1]';           % move to word 4
    case 2 % deprecated - never used
        pause
        U(1,1,:)  = [1 1 1]';           % move to word 2 and report unknown
        U(1,2,:)  = [1 2 1]';           % stay on current word and report   Eat
        U(1,3,:)  = [1 3 1]';           % stay on current word and report Drink
        U(1,5,:)  = [1 4 1]';           % move to word 3
        U(1,6,:)  = [1 4 2]';           % move to word 4
        U(1,5,:)  = [1 4 3]';           % move to word 3
        U(1,6,:)  = [1 4 4]';           % move to word 4        
end